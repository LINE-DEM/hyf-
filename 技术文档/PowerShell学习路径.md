---
creation_date: 2026-01-21 00:00
type: #Type/Concept
status: #Status/Active
tags: [PowerShell, 学习路径, Automation, Windows]
aliases: [PowerShell路线, PS学习路线]
tech_stack: #Tech/System #Tech/CPP #Tech/UE5
complexity: ⭐⭐⭐
related_modules: [技术文档/CMD与PowerShell核心区别, 技术文档/Codex与Claude推荐Shell选择, 待整理/Codex读取文件乱码原因]
---

# PowerShell 学习路径（按你的技术栈定制：C++/UE/编译链/Obsidian 自动化）

## 你现在的目标画像（我按这个来排优先级）
- 你是 **C++/UE 开发 + 底层视角**，会高频做：批量读写 Markdown、跑构建工具链、定位编译/链接/运行时问题、写自动化脚本。
- 你当前最痛的坑：**Windows 下 UTF-8（无 BOM）文件读取的默认编码问题**（见：[[待整理/Codex读取文件乱码原因]]）。

所以这条学习路径的排序是：**稳定文本/编码 → 管道对象化 → 脚本化自动化 → 工程化（模块/测试） → 高级（并发/远程/安全）**。

---

## Stage 0（0.5 天）：把环境一次性调对（避免“学一半卡在乱码/行为不一致”）
1. **优先装 PowerShell 7（`pwsh`）**（可选但强烈建议）：默认 UTF-8 行为更一致；以后你写的脚本更可迁移。
2. **确认并理解 3 个编码位置**（决定你会不会乱码）：
   - 终端 code page（CMD 的 `chcp`）
   - PowerShell 控制台输入/输出编码（`[Console]::InputEncoding/OutputEncoding`）
   - PowerShell 文件读写默认编码（`Get-Content/Set-Content/Out-File`）
3. **落地动作（你已经做过/建议保持）**：
   - 设置 profile，让 `Get-Content` 默认 UTF-8（对 Obsidian Vault 最省脑力、运行时开销最小）。

验收任务：
- 同一个 `.md`：`Get-Content xxx.md` 和 `Get-Content -Encoding UTF8 xxx.md` 输出一致（中文不乱码）。

---

## Stage 1（1–2 天）：PowerShell 的“核心语法/心智模型”（必须过关）
你不需要背命令，但必须建立 4 个“底层模型”：

1. **对象管道**：命令输出是对象，不是字符串  
   - `Get-Member`（看对象有什么属性/方法）
   - `Select-Object/Where-Object/Sort-Object`（对字段做过滤/投影/排序）

2. **格式化 ≠ 数据**：`Format-Table/Format-List` 只影响显示，不该参与后续计算  

3. **外部程序 vs cmdlet**：`cl.exe`/`git` 这类是外部进程，和 `Get-Process` 这种 cmdlet 不同  
   - 你需要掌握：`$LASTEXITCODE`、`$?`、`2>&1`、`|` 管道、`&` 调用运算符

4. **引用与转义规则**（比语法更重要）  
   - 单引号 vs 双引号（变量展开、转义）
   - 路径含空格/中文时怎么写（`-LiteralPath`、`Resolve-Path`）

验收任务：
- 能用一条管道把进程按 CPU 排序并取前 5：`Get-Process | Sort CPU -Desc | Select -First 5`
- 能解释为什么 `Format-Table | Export-Csv` 是错的（格式化对象不是原始对象）。

---

## Stage 2（2–4 天）：你日常会用到的“高频能力包”（直接提升产能）

### 2.1 文件与目录（Obsidian/代码仓库必备）
- `Get-ChildItem`、`Resolve-Path`、`Join-Path`
- `Test-Path`、`New-Item`、`Copy-Item`、`Move-Item`
- `Get-Content/Set-Content`（重点：`-Encoding`、`-Raw`、`-TotalCount`）
- `Select-String`（文本搜索；但你更推荐继续用 `rg` 做全文搜索）

### 2.2 文本/结构化数据（写自动化脚本离不开）
- 字符串：`-split/-replace`、正则、Here-String（`@""@`）
- JSON：`ConvertFrom-Json/ConvertTo-Json`（处理配置/日志很常见）
- CSV：`Import-Csv/Export-Csv`（简单报表/索引输出）

### 2.3 进程与工具链（C++/UE 编译系统）
- `Start-Process`（带参数、等待、拿退出码）
- `&` 调用外部程序，捕获输出，区分 stdout/stderr
- 常用：`msbuild`、`cmake`、`ninja`、`cl`、`link`、`dumpbin`、`git` 的调用与错误处理模式

验收任务（贴近你的场景）：
- 写一个脚本：扫描 Vault 下所有 `.md`，统计字数/行数/最近修改时间，导出 `notes.csv`
- 写一个脚本：一键执行 UE 工程构建（Debug/Development 两套参数），失败时打印最后 200 行日志

---

## Stage 3（3–7 天）：从“会用”到“会写脚本”（稳定、可复用、可维护）

重点按这个顺序学（少走弯路）：
1. **函数与参数**：`param()`、必填参数、默认值、`[ValidateSet()]`
2. **错误处理**：`try/catch/finally`、`$ErrorActionPreference`、`-ErrorAction Stop`
3. **输出约定**：函数尽量输出对象（而不是拼字符串），最后再统一格式化/落盘
4. **日志与可观测性**：`Write-Verbose/Write-Warning`、`-Verbose`、`Start-Transcript`
5. **性能基本功**：避免不必要的 `+=` 字符串拼接、避免重复 `Get-Content` 读大文件、优先流式处理

验收任务（你会真的用得上）：
- 写 `read-md.ps1`：读取 `.md` 时自动 UTF-8（无 BOM），支持 `-Head/-Tail`（你现在的 skill 脚本就是这个思路）
- 写 `moc-gen.ps1`：按目录生成 Obsidian MOC（索引文件），并能排除 `.obsidian/`、图片目录

---

## Stage 4（1–2 周）：工程化（让脚本像“工具”一样可靠）
1. **模块化**：把常用函数拆成模块（`*.psm1`），做到“到处可用、版本可控”
2. **配置化**：用 JSON/YAML 管参数（扫描范围、排除规则、输出路径）
3. **测试**：用 Pester 写最少量的单测（特别是：路径、编码、边界条件）
4. **发布/复用**：本地模块目录 + 版本号 + 文档化（最小必要）

验收任务：
- 把“Obsidian 笔记整理/知识地图生成”做成一个模块：`Invoke-ObVaultTools -Root <path> -Mode MOC|Stats|FixFrontmatter`

---

## Stage 5（可选，高收益但不必急）：并发/远程/安全（按需）
- 并发：`Start-Job` / Runspace（批量处理大仓库更快）
- 远程：WinRM/SSH（多机器同步/部署）
- 安全：执行策略、签名、凭据管理（企业环境会用到）

---

## 推荐资料（少而精）
- 书：*Learn PowerShell in a Month of Lunches*（适合把基础打牢）
- 官方：Microsoft Learn / PowerShell 文档（查 cmdlet 行为最权威）
- 你的最佳练习集：直接围绕本 Vault + UE 工具链写脚本（最贴近真实收益）

