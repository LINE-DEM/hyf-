# Codex 对话自动保存（提取 user_message 与 agent_message）

## 你要的“保存口径”

从 Codex 的会话文件 `~/.codex/sessions/.../rollout-*.jsonl` 中，自动提取：

- `type = event_msg` 且 `payload.type = user_message` 的 `payload.message`
- `type = event_msg` 且 `payload.type = agent_message` 的 `payload.message`

只保存 **用户消息 + 助手消息文本**，不包含工具调用与输出。

## 日志输出位置

默认写入（按日期分文件夹）：

`C:\1.HYFStudy\OB\C++\c++\待整理\AI对话\YYYY-MM-DD\codex_yyyy-MM-dd_HHmmss_sessionid.md`

也可以用环境变量覆盖：

- `CODEX_LOG_DIR=你想要的目录`

## 用法

- 仅当前会话启用：在 vault 根目录运行 `.\工具\codex-hook\codex-hook.ps1`
- 临时不记录：`.\工具\codex-hook\codex-hook.ps1 --no-log`
- 全局默认启用：运行 `.\工具\codex-hook\install-codex-hook.ps1 -AlsoInstallForWindowsPowerShell`，之后直接输入 `codex`
- 旁路原始 codex：`codex_raw`

## 相关脚本（实现点）

- 实时写入：`工具/codex-hook/tail-codex-session.ps1:1`（读取 jsonl 的 `event_msg`）
- 导出历史：`工具/codex-hook/export-codex-session.ps1:1`（优先 `event_msg`，必要时兼容旧的 `response_item message`）
- 入口包装器：`工具/codex-hook/codex-hook.ps1:1`

## 排查（不出文件/内容不对）

- 确认你是通过 hook 启动的：PowerShell 里直接运行 `codex`（或手动运行 `.\工具\codex-hook\codex-hook.ps1`）
- 确认 `~/.codex/sessions` 下有新的 `rollout-*.jsonl` 在增长
- 你需要的是 `event_msg`：在 jsonl 里能看到 `payload.type` 为 `user_message` / `agent_message`

