---
creation_date: 2026-01-21 00:00
type: #Type/Concept
status: #Status/Active
tags: [Codex, Hook, PowerShell, Windows, Encoding, Automation]
aliases: [Codex hook, hook机制, 全局设置]
tech_stack: #Tech/System
complexity: ⭐⭐⭐
related_modules: [技术文档/CMD与PowerShell核心区别, 待整理/Codex读取文件乱码原因]
---

# Hook 是什么？在 Codex 里怎么“设置 Hook”？会全局生效吗？

## 1）Hook 是什么（通俗但精确）
**Hook（钩子）**本质就是：在系统/工具的某个“固定时刻点（事件）”上，**让你插入一段自己的逻辑**，从而改变或扩展原有行为。

你可以把 Hook 理解成两类（你熟悉的 UE/C++ 里也都有对应物）：

1. **事件型 Hook（最常见）**：系统在 *Before/After* 某件事时调用你  
   - UE：`BeginPlay()` / `Tick()` 这类“生命周期回调”本质就是 Hook（你重写/注册进去）。
   - Git：`pre-commit`、`pre-push`（提交/推送前自动跑检查）。
   - CI：build 前/后步骤。

2. **拦截型 Hook（更底层）**：把原来的函数/行为“劫持”到你的代码里  
   - 典型：API Hook、Detours、vtable hook、IAT hook 等（偏逆向/底层）。

你现在这个需求（“读文件前先判断编码再读”）属于 **事件型 Hook**：在“读取文件”这个动作前插入“编码探测/固定编码策略”。

---

## 2）Codex CLI 里有没有“官方的 Hook 设置”？
**截至本机的 Codex CLI（0.87.0）公开配置/命令行帮助里，没有暴露类似 `hooks.before_read_file` 这种“事件 Hook 系统”。**

Codex 目前你能稳定控制的主要是：
- **用户级配置**：`C:\Users\Admin\.codex\config.toml`
- **命令执行规则**（允许/阻止哪些命令）：`C:\Users\Admin\.codex\rules\default.rules`
- **Skills**（提示词层面的工作流/规范）：`C:\Users\Admin\.codex\skills\...`

> 所以严格意义上：**你不能在 Codex 里注册一个“读文件前必执行”的 Hook**（至少不是通过一个官方开关）。

---

## 3）那“怎么在 Codex 里实现 Hook 效果”？（推荐做法：Shell Profile）
虽然 Codex 没有“读文件 Hook”，但 Codex 在 Windows 上执行命令通常会启动 `powershell.exe -Command ...`（你在 `C:\Users\Admin\.codex\rules\default.rules` 里能看到类似记录）。

这意味着：**PowerShell 的 Profile 就是你的“全局 Hook 点”**：
- 每次 PowerShell 进程启动时自动执行 Profile（除非用 `-NoProfile`）
- 你可以在里面设置默认编码、默认参数等

对你的乱码问题来说，这个 Hook 是最“一劳永逸 + 运行时开销最小”的方案：
- **开销**：只在启动 PowerShell 进程时跑一次 Profile（非常小）
- **收益**：后续所有 `Get-Content` 默认 UTF-8，不再随机乱码（见：[[待整理/Codex读取文件乱码原因]]）

你机器上我已经创建了 Profile（相当于把 Hook 装好了）：
- `C:\Users\Admin\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
- 作用：把 `Get-Content` 默认编码改为 UTF-8，并统一控制台输入/输出编码

如果你要自己检查：
```powershell
$PROFILE
Test-Path $PROFILE
Get-Content $PROFILE
```

---

## 4）Skills 算不算 Hook？适合用来解决编码吗？
**Skills 更像“提示词层面的流程模板”，不是“硬性的事件 Hook”。**

- 优点：能把“怎么做事”写成固定流程（比如：读文件先探测编码、再输出）。
- 缺点：**它不是强制的**——是否触发取决于模型是否匹配到 skill 的描述/触发条件；并且每次读文件都“先探测”会带来额外命令开销。

结论：
- **想要最省事/最省开销**：用 PowerShell Profile（推荐）
- **想要兜底处理非 UTF-8 文件**：保留 skill 脚本作为 fallback（必要时手动用）

---

## 5）它会跟随 user 全局生效吗？
取决于你设置的是哪一种“Hook 点”：

### A. PowerShell Profile（推荐）
- **生效范围**：当前 Windows 用户（`Admin`）的所有 PowerShell 会话
- **是否全局**：是（跨项目/跨目录/跨工具，只要它启动 powershell 且不加 `-NoProfile`）
- **对你“CMD 打开 Codex”是否有效**：通常也有效，因为 Codex 执行命令时会另起 powershell 进程

### B. Codex 的 `config.toml / rules / skills`
- **生效范围**：同样是“当前 user 全局”（都在 `C:\Users\Admin\.codex\` 下）
- **但**：skills 不是强制事件触发；rules 只管“允许哪些命令”；都不等价于“读文件 Hook”

### C. 仓库内的规则/说明文件（如 AGENTS.md / CLAUDE.md）
- **生效范围**：仅当前仓库（或目录树）有效
- **是否全局**：否

