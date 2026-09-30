# LangGraph 文档中译 · 术语表

> 按术语治理规程建立：**一个源词只对应一个译词**，并列出禁用译法防"同词多译"。
> 交付前必跑一致性检查：同一术语在全文出现 3 次以上却有 2 种以上译法，即为不合格。

## 术语表结构

本表分两段：

1. **保留英文（不翻译）清单**：列 `类别 | 源词 | 禁用译法`。这些词一律保留英文。
2. **需要翻译的术语表**：列 `源词 | 译词 | 禁用译法 | 说明`。这些词需统一译词，一个源词只对应一个译词。

字段含义：

- **源词**：原文形式，含大小写、单复数、连字符。
- **译词**：唯一确定的译词（仅翻译表）。
- **禁用译法**：常见错译，防"同词多译"。在不翻译清单里 = 这些中文**一律不要用来替代原文**。
- **说明**：为什么这么译 / 指向哪个对象（仅翻译表）。

## 保留英文（不翻译）清单

> 下列词一律**保留英文不译**，按保留原因分四类：
> - **核心概念**：强绑定 API 的图 / 状态 / 运行时 / 记忆 / 智能体概念。
> - **代码标识符**：类名、函数名、参数名、类型、特殊节点。
> - **产品名**：产品与平台名称。
> - **惯用保留**：技术文档惯用英文，不译更自然。
>
> 「禁用译法」= 这些中文一律不要用来替代原文（无论对错）。若确需帮助理解，可在首次出现时于括号内加注中文，但正文主体保持英文。

| 类别 | 源词 | 禁用译法 |
|---|---|---|
| 核心概念 | graph | 图表、图形 |
| 核心概念 | node | 结点、节点 |
| 核心概念 | edge | 边缘、边 |
| 核心概念 | conditional edge | 条件边、有条件边、条件分支边 |
| 核心概念 | state | 州、状况、状态 |
| 核心概念 | graph state | 图形状态、图状态 |
| 核心概念 | state schema | 状态模式、状态结构 |
| 核心概念 | state snapshot | 状态瞬象、状态快照 |
| 核心概念 | reducer | 归约器、缩减器 |
| 核心概念 | subgraph | 子图表、子图 |
| 核心概念 | runtime | 运行时间、运行时 |
| 核心概念 | checkpoint | 检验点、断点、检查点 |
| 核心概念 | checkpointer | 检查点保存器、检查点器、检查点机 |
| 核心概念 | persistence | 持续性、持久性、持久化 |
| 核心概念 | thread | 主题、线索、线程 |
| 核心概念 | interrupt | 打断、中断 |
| 核心概念 | time travel | 时间穿越、时间旅行 |
| 核心概念 | store | 商店、门店 |
| 核心概念 | memory store | 记忆库、记忆存储 |
| 核心概念 | short-term memory | 短期内存、短期记忆 |
| 核心概念 | long-term memory | 长期内存、长期记忆 |
| 核心概念 | working memory | 工作内存、工作记忆 |
| 核心概念 | semantic memory | 语义内存、语义记忆 |
| 核心概念 | episodic memory | 情景内存、情节记忆、情景记忆 |
| 核心概念 | human-in-the-loop | 人在环、人类在环、人工介入闭环、人在回路 |
| 核心概念 | tool-calling loop | 工具调用回路、工具调用循环 |
| 核心概念 | harness (agent harness) | 马具、线束、挽具 |
| 核心概念 | agent | 智能体、代理、主体 |
| 核心概念 | agentic (step) | 智能体（步骤）、代理式、主体性 |
| 核心概念 | multi-agent | 多智能体、多代理 |
| 核心概念 | subagent / sub-agent | 子智能体、子代理 |
| 核心概念 | supervisor | 监督者、监管者、主管 |
| 核心概念 | handoff / handoffs | 交接、切换、移交 |
| 核心概念 | tool | 工具 |
| 核心概念 | tool call | 工具调用 |
| 核心概念 | model | 模型 |
| 代码标识符 | thread_id | — |
| 代码标识符 | StateGraph | — |
| 代码标识符 | MessagesState | — |
| 代码标识符 | InMemorySaver | — |
| 代码标识符 | TypedDict | — |
| 代码标识符 | Command | 命令 |
| 代码标识符 | send | 发送 |
| 代码标识符 | Pregel | — |
| 代码标识符 | START / END | 开始 / 结束 |
| 产品名 | LangChain | — |
| 产品名 | LangGraph | — |
| 产品名 | LangSmith | — |
| 产品名 | Deep Agents | 深度智能体 |
| 产品名 | Agent Server | 智能体服务器 |
| 产品名 | Studio | 工作室 |
| 产品名 | LangGraph Platform | — |
| 产品名 | LangGraph Server | — |
| 产品名 | trace (n.) | 追踪记录、轨迹 |
| 惯用保留 | framework | 架构、框架 |
| 惯用保留 | prebuilt | 预建、预先构建、预构建 |
| 惯用保留 | evaluation | 评价、评估 |
| 惯用保留 | streaming | 流式传输、串流、流式 |
| 惯用保留 | stream | 流 |
| 惯用保留 | namespace | 名字空间、命名空间 |
| 惯用保留 | pull request | 拉取请求 |
| 惯用保留 | token | 令牌、词元 |
| 惯用保留 | LLM | 大语言模型 |
| 惯用保留 | prompt / prompts | 提示、提示语 |
| 惯用保留 | workflow | 工作流 |
| 惯用保留 | async | 异步 |
| 惯用保留 | embedding | 嵌入、词嵌入、向量嵌入 |
| 惯用保留 | backend | 后端、后台 |
| 惯用保留 | provider | 提供商、提供者 |

## 需要翻译的术语表

### 图与状态（graph & state）

| 源词 | 译词 | 禁用译法 | 说明 |
|---|---|---|---|
| channel | 通道 | 频道 | 状态通道（graph channel） |
| entry point | 入口 | 进入点 | 图的入口节点 |
| recursion limit | 递归限制 | 递归上限 | 递归次数上限 |
| state machine | 状态机 | — | 通用概念，区别于 graph state |

### 运行时与持久化（runtime & persistence）

| 源词 | 译词 | 禁用译法 | 说明 |
|---|---|---|---|
| durable execution | 持久化执行 | 耐用执行、耐久执行 | 持久化执行 |
| resume | 恢复 | 继续、重启 | 中断后的恢复执行 |
| pause | 暂停 | — | 暂停执行 |
| replay | 重放 | 回放、重现 | 重放历史执行 |
| forking | 分叉 | — | 状态分叉 |
| cross-thread | 跨线程 | 跨主题 | 跨线程 |
| retention policy | 保留策略 | 留存策略 | 保留策略 |
| prune | 裁剪 | 修剪、剪枝 | 裁剪历史状态 |

### 通用技术词（general）

| 源词 | 译词 | 禁用译法 | 说明 |
|---|---|---|---|
| orchestration | 编排 | 协调、编配 | 编排 |
| deterministic | 确定性（的） | 决定性的 | 确定性 |
| hand-coded | 手工编写 | 手写代码 | 手工编写 |
| bespoke | 定制 | 定做、专属 | 定制 |
| application-defined | 应用自定义的 | 应用程序定义的 | 应用自定义的 |
| key-value data | 键值数据 | 键值对数据 | 键值数据 |
| fault tolerance | 容错 | 故障容忍、错误容忍 | 容错 |
| observability | 可观测性 | 可观察性 | 可观测性 |
| tracing | 追踪 | 跟踪 | 追踪 |
| anchor (deep link) | 锚点 | 链接锚、定位点 | 锚点 |
| concurrency | 并发 | — | 并发 |
| parallelism | 并行 | — | 并行 |
| fan-out | 扇出 | — | 扇出 |
| fan-in | 扇入 | — | 扇入 |
| compile | 编译 | — | 编译（图） |
| context manager | 上下文管理器 | — | 上下文管理器 |
| hallucination | 幻觉 | 幻想 | LLM 幻觉 |
| guardrail | 护栏 | 防护栏 | 安全护栏 |
| latency | 延迟 | — | 延迟 |
| retry | 重试 | — | 重试 |
| timeout | 超时 | — | 超时 |
| fallback | 回退 | 备用 | 回退 |
| low-level | 底层 | 低级 | 如 low-level API → 底层 API |
| map-reduce | 映射归约 | — | map-reduce 模式 |
| DAG | 有向无环图 | — | 首次出现可注 DAG |
| semantic search | 语义搜索 | 语义检索 | 语义搜索 |
| semantic ranking | 语义排序 | 语义排名 | 语义排序 |

## 一致性约定

- **标点**：全用半角。
- **中英混排**：英文单词与代码标识符前后各留一个半角空格。
- **代码标识符**：`StateGraph`、`MessagesState`、`InMemorySaver`、`thread_id` 等一律不译，行内代码格式保留。
- **人称**：全文用"你"（不混用"您"），与官方英文 you 对应。
- **产品名**：LangChain / LangGraph / LangSmith / Deep Agents 保留英文。
