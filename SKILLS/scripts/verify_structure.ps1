<#
.SYNOPSIS
  结构校验: 对比原文与译文的格式结构是否一致（翻译格式保持检查）。

.DESCRIPTION
  对应 SKILLS.md 第五节「文档格式: 保持原样」。校验项:
    - 标题层级序列 (# ~ ######)
    - 链接 URL 序列 (链接文字可译, URL 不得变)
    - 图片 src (markdown ![alt](src) 与 HTML <img>)
    - 围栏代码块语言标签 (```python 等)
    - Admonition 提示块类型 (!!! note 等)
    - 组件开标签 (<Info>、<Tabs> 等 Mintlify 组件)
    - 表格 (每张表的行数与列数)
    - 行内代码数量 (警告级, 请人工核对)
  代码块内部内容会被剥离后再解析, 避免代码里的 # 注释、!!! 等被误判。
  有错误时退出码为 1, 可用于翻译流水线自动拦截。

.EXAMPLE
  .\verify_structure.ps1 -Name 9_stores -Dir tmp
  .\verify_structure.ps1 -Source tmp\9_stores.md -Target tmp\9_stores.zh.md
#>
[CmdletBinding(DefaultParameterSetName = 'Pair')]
param(
    [Parameter(Mandatory = $true, ParameterSetName = 'Pair', Position = 0)][string]$Name,
    [Parameter(ParameterSetName = 'Pair')][string]$Dir = '.',
    [Parameter(Mandatory = $true, ParameterSetName = 'Files', Position = 0)][string]$Source,
    [Parameter(Mandatory = $true, ParameterSetName = 'Files', Position = 1)][string]$Target
)

$script:errCount = 0
$script:warnCount = 0

function Write-Ok([string]$m) { Write-Host "[OK]   $m" -ForegroundColor Green }
function Write-Fail([string]$m) { Write-Host "[FAIL] $m" -ForegroundColor Red; $script:errCount++ }
function Write-Warn([string]$m) { Write-Host "[WARN] $m" -ForegroundColor Yellow; $script:warnCount++ }

# 剥离围栏代码块: 返回 body 行(不含代码块内部) 与 fence 语言标签序列
function Split-Fence([string]$Text) {
    $body = New-Object System.Collections.Generic.List[string]
    $fences = New-Object System.Collections.Generic.List[string]
    $inFence = $false
    foreach ($line in ($Text -split "`r?`n")) {
        if ($line -match '^\s*(```+|~~~+)') {
            if (-not $inFence) {
                $inFence = $true
                $lang = ($line -replace '^\s*(```+|~~~+)\s*', '').Trim()
                if ($lang) { $fences.Add(($lang -split '\s+')[0]) } else { $fences.Add('') }
            }
            else { $inFence = $false }
            continue
        }
        if (-not $inFence) { $body.Add($line) }
    }
    [pscustomobject]@{ Body = $body; Fences = $fences }
}

# 标题级别序列
function Get-HeadingLevels($Body) {
    $r = @()
    foreach ($l in $Body) { if ($l -match '^(#{1,6})\s') { $r += , $Matches[1].Length } }
    , $r
}

# 链接 URL (跳过图片 ![..](..))
function Get-LinkUrls($Body) {
    $r = @()
    foreach ($l in $Body) {
        foreach ($m in [regex]::Matches($l, '(?<!\!)\[[^\]]*\]\(\s*<?([^)\s>]+)')) { $r += , $m.Groups[1].Value }
    }
    , $r
}

# 图片 src: markdown ![..](src) 与 <img src="...">
function Get-ImageSrcs($Body) {
    $r = @()
    foreach ($l in $Body) {
        foreach ($m in [regex]::Matches($l, '!\[[^\]]*\]\(\s*<?([^)\s>]+)')) { $r += , $m.Groups[1].Value }
        foreach ($m in [regex]::Matches($l, '<img[^>]*?src\s*=\s*"([^"]+)"', 'IgnoreCase')) { $r += , $m.Groups[1].Value }
    }
    , $r
}

# Admonition 类型 (!!! note 等)
function Get-Admonitions($Body) {
    $r = @()
    foreach ($l in $Body) { if ($l -match '^\s*!!!\s*([A-Za-z\-]+)') { $r += , $Matches[1].ToLower() } }
    , $r
}

# Mintlify/HTML 组件开标签 (<Info>、<Tabs ...> 等, 行首可有缩进)
function Get-Components($Body) {
    $r = @()
    foreach ($l in $Body) { if ($l -match '^\s*<([A-Z][A-Za-z0-9_]*)[\s>/]') { $r += , $Matches[1] } }
    , $r
}

# 表格: 每张表返回 @(行数, 列数)
function Get-Tables($Body) {
    $r = @()
    $n = $Body.Count
    $i = 0
    while ($i -lt $n) {
        if ($Body[$i] -match '^\s*\|') {
            $start = $i
            while ($i -lt $n -and $Body[$i] -match '^\s*\|') { $i++ }
            $rows = @($Body[$start..($i - 1)])
            $cols = 0
            foreach ($rw in $rows) {
                if ($rw -match '^\s*\|?[\s:|-]+\|?\s*$' -and $rw -match '-') {
                    $cols = ([regex]::Matches($rw, '\|')).Count - 1
                    break
                }
            }
            if ($cols -le 0) { $cols = ([regex]::Matches($rows[0], '\|')).Count - 1 }
            $r += , @($rows.Count, $cols)
        }
        else { $i++ }
    }
    , $r
}

# 行内代码数量
function Get-InlineCodeCount($Body) {
    $c = 0
    foreach ($l in $Body) { $c += ([regex]::Matches($l, '`[^`\r\n]+`')).Count }
    $c
}

# 序列对比: 数量或内容不一致即 FAIL
function Compare-Seq([string]$Label, $a, $b) {
    $aa = @($a); $bb = @($b)
    if ($aa.Count -ne $bb.Count) {
        Write-Fail "$Label 数量不一致: 原文 $($aa.Count) 项, 译文 $($bb.Count) 项"
        return
    }
    for ($i = 0; $i -lt $aa.Count; $i++) {
        if ("$($aa[$i])" -ne "$($bb[$i])") {
            Write-Fail "$Label 第 $($i + 1) 处不一致: 原文 [$($aa[$i])] vs 译文 [$($bb[$i])]"
            return
        }
    }
    Write-Ok "$Label ($($aa.Count) 项)"
}

# ---------- 入口 ----------
if ($PSCmdlet.ParameterSetName -eq 'Pair') {
    $srcPath = Join-Path $Dir ($Name + '.md')
    $tgtPath = Join-Path $Dir ($Name + '.zh.md')
}
else {
    $srcPath = $Source
    $tgtPath = $Target
}
foreach ($p in @($srcPath, $tgtPath)) {
    if (-not (Test-Path $p)) { Write-Host "错误: 未找到文件 $p" -ForegroundColor Red; exit 2 }
}

$src = Split-Fence (Get-Content -Raw -Encoding UTF8 $srcPath)
$tgt = Split-Fence (Get-Content -Raw -Encoding UTF8 $tgtPath)

Write-Host ''
Write-Host "结构校验: $(Split-Path -Leaf $srcPath)  <->  $(Split-Path -Leaf $tgtPath)"
Write-Host ('-' * 60)

Compare-Seq '标题层级序列'   (Get-HeadingLevels $src.Body) (Get-HeadingLevels $tgt.Body)
Compare-Seq '链接 URL'      (Get-LinkUrls $src.Body) (Get-LinkUrls $tgt.Body)
Compare-Seq '图片 src'      (Get-ImageSrcs $src.Body) (Get-ImageSrcs $tgt.Body)
Compare-Seq '代码块语言标签'  $src.Fences $tgt.Fences
Compare-Seq 'Admonition 类型' (Get-Admonitions $src.Body) (Get-Admonitions $tgt.Body)
Compare-Seq '组件开标签'     (Get-Components $src.Body) (Get-Components $tgt.Body)
Compare-Seq '表格 (行,列)'   (Get-Tables $src.Body) (Get-Tables $tgt.Body)

$srcInline = Get-InlineCodeCount $src.Body
$tgtInline = Get-InlineCodeCount $tgt.Body
if ($srcInline -eq $tgtInline) { Write-Ok "行内代码数量 ($srcInline 处)" }
else { Write-Warn "行内代码数量: 原文 $srcInline 处, 译文 $tgtInline 处 (请人工核对)" }

Write-Host ('-' * 60)
if ($script:errCount -gt 0) {
    Write-Host "结果: 未通过 ($($script:errCount) 个错误, $($script:warnCount) 个警告)" -ForegroundColor Red
    exit 1
}
elseif ($script:warnCount -gt 0) {
    Write-Host "结果: 通过 ($($script:warnCount) 个警告)" -ForegroundColor Yellow
}
else {
    Write-Host "结果: 通过" -ForegroundColor Green
}
