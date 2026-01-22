# Codex 对话自动保存（会话级 / 全局）

目标：每次 Codex CLI 会话进行中（实时追加），把本次 **User + Assistant 文本** 导出到：

`C:\1.HYFStudy\OB\C++\c++\待整理\AI对话\YYYY-MM-DD\codex_时间_sessionid.md`

说明：当前提取口径为从 `~/.codex/sessions/.../rollout-*.jsonl` 中读取 `type=event_msg`，并抽取：
- `payload.type = user_message` 的 `payload.message`
- `payload.type = agent_message` 的 `payload.message`

## 仅当前会话启用

在你的 vault 根目录运行：

```powershell
.\工具\codex-hook\codex-hook.ps1
```

（它会启动真实的 `codex`，并在会话进行中实时写入记录；退出后停止写入并完成重命名。）

临时不记录：

```powershell
.\工具\codex-hook\codex-hook.ps1 --no-log
```

## 全局默认启用（PowerShell）

运行安装脚本（会把 hook 写入你的 PowerShell Profile）：

```powershell
.\工具\codex-hook\install-codex-hook.ps1 -AlsoInstallForWindowsPowerShell
```

安装后你直接输入 `codex` 就会自动保存对话；如需绕过 hook 用原始命令：

```powershell
codex_raw
```

## 导出单个历史会话

```powershell
.\工具\codex-hook\export-codex-session.ps1 -RolloutPath "C:\Users\<you>\.codex\sessions\...\rollout-....jsonl" -OutDir "C:\...\AI对话"
```
