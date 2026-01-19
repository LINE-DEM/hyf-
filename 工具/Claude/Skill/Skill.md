---
creation_date: 2026-01-15 14:00
type: #Type/Concept
status: #Status/Active
tags: [Claude_Code, Agent_Skill, Automation, Workflow]
aliases: [技能, 自动化技能]
tech_stack: #Tech/Claude_Code
complexity: ⭐⭐⭐⭐
related_modules: [MCP, CLAUDE.md, Cowork]
---

# Claude Code Agent Skill 完全指南

## 核心摘要

Agent Skill 是 Claude Code 的自动化工作流定义机制，通过声明式配置教会 Claude 如何处理特定类型的任务，实现从"对话式交互"到"一键执行"的效率跃升。

## 参考资源

[Agent Skill 从使用到原理，一次讲清_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1cGigBQE6n/?spm_id_from=333.788.recommend_more_video.-1&trackid=web_related-0.router-related-2206419-dk9pw.1768354329266.809&vd_source=7556e8b0664287072ced69c095b64227)

---

## 详细分析

### 1. 背景/痛点

#### 1.1 传统 AI 交互的局限性

```
场景：整理本周学习笔记

传统方式（每次都要说一遍）：
你: "帮我整理本周的学习笔记，
    1. 读取 26-01-13 到 26-01-19 的所有 .md 文件
    2. 按照主题分类（C++、UE、编译原理）
    3. 提取关键概念
    4. 生成 weekly summary
    5. 创建双向链接
    6. 更新月度进度"

Claude: [执行任务]

下周又要重复一遍完整的指令！
```

**痛点：**
- 重复性任务需要反复描述
- 无法标准化工作流
- 容易遗漏步骤
- 效率低下

#### 1.2 MCP 的局限性

![[Pasted image 20260114174948.png]]

**MCP（Model Context Protocol）的作用：**
- 给大模型提供数据源
- 连接外部系统（数据库、API、文件系统）
- 例如：查询昨天的销售记录、提取订单信息

**MCP 的局限：**
- 只解决"数据获取"问题
- 不解决"如何处理数据"问题
- 每次仍需告诉 Claude 处理逻辑

#### 1.3 为什么需要 Skill

```
对比：

MCP:     "给我数据"
Skill:   "拿到数据后，按照这个流程处理"

MCP:     数据层
Skill:   逻辑层 + 自动化层
```

---

### 2. 底层原理

#### 2.1 Skill 的本质

**Skill = 可复用的任务模板**

```typescript
// Skill 的抽象结构
interface Skill {
  metadata: {
    name: string;           // 技能名称
    trigger: string;        // 触发方式（如 /weekly-summary）
    description: string;    // 功能描述
  };

  instruction: {
    goal: string;           // 目标
    steps: string[];        // 执行步骤
    constraints: string[];  // 约束条件
  };

  resources: {
    tools: string[];        // 可用工具（Read, Write, Bash等）
    context: string[];      // 上下文文件（如 CLAUDE.md）
    examples: string[];     // 示例
  };
}
```

#### 2.2 渐进式披露（Progressive Disclosure）

![[Pasted image 20260114175146.png]]

**三层设计原则：**

1. **元数据层（Metadata）** - 最简信息
   - 在线状态
   - 一句话描述
   - 快速识别功能

2. **指令层（Instruction）** - 核心逻辑
   - SKILL.md 文件内容
   - 详细的操作步骤
   - 约束和规则

3. **资源层（Resource）** - 扩展能力
   - Reference（参考文档）
   - Script（可执行脚本）
   - 定义能力边界

**为什么需要渐进式披露？**

```
问题：如果一次性把所有信息给 Claude
→ Token 消耗大
→ 信息过载
→ 效率降低

解决：按需加载
→ 用户调用 /weekly-summary
→ Claude 只加载这个 Skill 的信息
→ 其他 Skill 不占用 Token
```

#### 2.3 Skill vs MCP 深度对比

| 维度       | MCP               | Agent Skill     |
| -------- | ----------------- | --------------- |
| **定位**   | 数据连接器             | 任务自动化引擎         |
| **作用**   | 提供数据源             | 定义处理逻辑          |
| **举例**   | 连接 Obsidian vault | 定义如何整理笔记        |
| **依赖**   | 独立使用              | 通常依赖 MCP 提供的数据  |
| **复用性**  | 数据级复用             | 工作流级复用          |
| **学习成本** | 低（只需配置连接）         | 中（需编写 Skill 定义） |

**协作关系：**

```
MCP 提供原材料
    ↓
Skill 定义加工流程
    ↓
Claude 执行并输出结果
```

---

### 3. 解决方案/实现

#### 3.1 Skill 的创建方式

##### 方式 1：通过 Claude Code CLI 创建

```bash
# 创建新 Skill
/skill create weekly-summary

# Claude 会引导你填写：
# 1. 描述
# 2. 触发命令
# 3. 执行步骤
# 4. 所需权限
```

##### 方式 2：手动创建 SKILL.md

**目录结构：**

```
.claude/
├── skills/
│   ├── weekly-summary/
│   │   ├── SKILL.md          # 技能定义
│   │   ├── examples/         # 示例
│   │   └── scripts/          # 辅助脚本（可选）
│   └── code-review/
│       └── SKILL.md
└── config.json
```

**SKILL.md 模板：**

```markdown
# weekly-summary

## Metadata
- Name: 每周学习总结生成器
- Trigger: /weekly-summary
- Description: 自动整理本周学习笔记并生成总结

## Instruction

### Goal
自动化每周学习笔记的整理、分类和总结生成流程

### Steps
1. 识别本周时间范围（周一到周日）
2. 扫描对应日期文件夹下的所有 .md 文件
3. 按照主题分类（C++、UE、编译原理、设计模式等）
4. 提取每篇笔记的核心概念
5. 生成结构化的周总结
6. 创建双向链接到原始笔记
7. 更新月度学习进度文件

### Constraints
- 只处理 markdown 文件
- 遵循 CLAUDE.md 中定义的笔记格式规范
- 保持原始笔记不被修改
- 生成的总结文件命名格式：Weekly-YYYY-Wxx.md

### Output Format
参考 Templates/AI_Refactor_Rules.md 的格式规范

## Resources

### Required Tools
- Read：读取笔记文件
- Write：创建周总结文件
- Grep：搜索关键词
- Glob：匹配文件模式

### Context Files
- CLAUDE.md：笔记格式规范
- Templates/AI_Refactor_Rules.md：模板定义
- 学习路径.md：主题分类参考

### Examples
见 examples/ 目录
```

#### 3.2 Skill 的使用方式

##### 3.2.1 基础使用

```bash
# 列出所有 Skill
/skills

# 查看 Skill 详情
/skill info weekly-summary

# 执行 Skill
/weekly-summary

# 或者用自然语言
"运行每周总结"
```

##### 3.2.2 带参数使用

```bash
# 指定日期范围
/weekly-summary --start 2026-01-06 --end 2026-01-12

# 只处理特定主题
/weekly-summary --topic C++
```

##### 3.2.3 在对话中调用

```
你: "我这周学了很多 UE 的内容，帮我总结一下"

Claude 检测到匹配 weekly-summary Skill
→ 自动执行
→ 无需完整描述流程
```

#### 3.3 Skill 的高级特性

##### 3.3.1 Skill 组合

```bash
# 定义一个 meta-skill
/skill create monthly-review

# SKILL.md 内容：
Steps:
1. 调用 /weekly-summary 生成最近 4 周的总结
2. 合并周总结内容
3. 提取关键学习成果
4. 生成月度报告
5. 更新学习进度图表
```

##### 3.3.2 条件执行

```markdown
## Instruction

### Steps
1. 检查本周是否有新笔记
   - 如果没有 → 跳过
   - 如果有 → 继续
2. 判断笔记数量
   - 少于 3 篇 → 简化版总结
   - 多于 10 篇 → 按主题分组
3. ...
```

##### 3.3.3 权限控制

```markdown
## Permissions

### Required
- Read: 整个 vault
- Write: 仅限指定输出目录

### Optional
- Bash: 用于 git 操作（自动提交总结）

### Forbidden
- 不得修改原始笔记
- 不得访问 .obsidian/workspace.json
```

---

### 4. 实战案例

#### 4.1 Obsidian 笔记整理 Skill

见 [[Obsidian笔记整理Skill]] （单独文件）

#### 4.2 C++ 学习实验 Skill

```markdown
# cpp-experiment

## Metadata
- Name: C++ 学习实验自动化
- Trigger: /cpp-exp
- Description: 编译运行 C++ 示例代码并生成实验报告

## Instruction

### Goal
自动化 C++ 学习过程中的代码实验流程

### Steps
1. 接收用户的学习主题（如"缓存局部性"）
2. 生成演示代码
3. 编译代码（gcc/g++ -O2）
4. 运行并捕获输出
5. 如果有性能测试需求，运行多次取平均值
6. 生成 markdown 实验报告
7. 保存到对应的学习笔记目录

### Output Structure
```
26-01-15/
├── cache_locality.cpp        # 源代码
├── cache_locality_report.md  # 实验报告
└── output.txt                # 运行输出
```

### Report Template
```markdown
---
creation_date: {date}
type: #Type/Experiment
tags: [C++, {topic}]
---

# {topic} 实验报告

## 实验目的
{goal}

## 实验代码
```cpp
{code}
```

## 运行结果
```
{output}
```

## 性能数据
| 指标 | 数值 |
|------|------|
{metrics}

## 分析
{analysis}

## 关联知识
- [[相关概念1]]
- [[相关概念2]]
```
```

#### 4.3 Daily Note 自动归档 Skill

```markdown
# daily-archive

## Metadata
- Name: 每日笔记归档
- Trigger: /archive-daily
- Schedule: 每天 23:00 自动执行

## Instruction

### Steps
1. 读取今天的 daily note
2. 提取待办事项状态
3. 提取学习要点
4. 更新任务看板
5. 如果有未完成任务 → 迁移到明天
6. 备份到归档目录
7. 生成今日总结
```

---

### 5. 最佳实践

#### 5.1 Skill 设计原则

**单一职责原则**
```
❌ 不好的 Skill：
/do-everything
  → 整理笔记
  → 运行代码
  → 生成报告
  → 发送邮件
  （太复杂，难以维护）

✅ 好的 Skill：
/organize-notes    # 只负责整理笔记
/run-experiment    # 只负责运行实验
/generate-report   # 只负责生成报告
```

**明确输入输出**
```markdown
## Input
- 时间范围（默认：本周）
- 主题过滤（可选）

## Output
- Weekly-{date}.md 文件
- 更新 Monthly-Progress.md
```

**错误处理**
```markdown
## Error Handling
1. 如果找不到笔记 → 提示用户并退出
2. 如果文件已存在 → 询问是否覆盖
3. 如果权限不足 → 说明需要的权限
```

#### 5.2 Skill 组织建议

```
.claude/
├── skills/
│   ├── daily/              # 每日任务
│   │   ├── daily-archive/
│   │   └── daily-summary/
│   ├── weekly/             # 每周任务
│   │   ├── weekly-summary/
│   │   └── weekly-review/
│   ├── learning/           # 学习相关
│   │   ├── cpp-experiment/
│   │   ├── ue-doc-gen/
│   │   └── concept-map/
│   └── development/        # 开发相关
│       ├── code-review/
│       └── refactor-assist/
└── templates/              # 共享模板
```

#### 5.3 Skill 测试流程

```bash
# 1. 干运行（dry-run）
/weekly-summary --dry-run
# 只显示会执行什么，不实际修改文件

# 2. 测试模式
/weekly-summary --test
# 在临时目录执行，不影响实际文件

# 3. 验证输出
diff expected-output.md actual-output.md

# 4. 正式使用
/weekly-summary
```

#### 5.4 Skill 版本管理

```markdown
# weekly-summary

## Version History

### v1.0.0 (2026-01-15)
- 初始版本
- 基础功能：扫描、分类、生成总结

### v1.1.0 (2026-01-20)
- 新增主题过滤功能
- 优化双向链接生成逻辑

### v1.2.0 (2026-01-25)
- 支持自定义时间范围
- 新增月度进度更新
```

---

## 关联知识

### 核心关联
- [[MCP]] - 数据层支撑
- [[CLAUDE.md]] - 项目规则定义
- [[Cowork]] - 协作工作流

### 应用场景
- [[Obsidian笔记整理Skill]] - 知识管理自动化
- [[C++学习实验Skill]] - 学习流程自动化
- [[UE开发辅助Skill]] - 开发效率提升

### 扩展阅读
- [[Claude_Code使用理由_针对你的场景]] - 为什么要用 Claude Code
- [[常用命令]] - Claude Code CLI 命令参考

---

## 快速开始

### 第一步：理解概念
1. 阅读本文档的"核心摘要"和"背景/痛点"部分
2. 理解 MCP vs Skill 的区别
3. 了解渐进式披露原理

### 第二步：创建第一个 Skill
1. 从简单的任务开始（如：每日总结）
2. 使用 `/skill create` 命令
3. 填写基本信息
4. 测试运行

### 第三步：逐步优化
1. 根据实际使用情况调整
2. 添加错误处理
3. 补充示例和文档
4. 版本迭代

### 第四步：构建 Skill 库
1. 针对重复性任务创建 Skill
2. 组织 Skill 目录结构
3. 建立 Skill 之间的协作
4. 定期维护和更新

---

## 附录

### A. Skill 文件规范

```yaml
# SKILL.md 文件结构规范

必需部分:
- # {skill-name}           # 一级标题：Skill 名称
- ## Metadata             # 元数据
- ## Instruction          # 核心指令
  - ### Goal              # 目标
  - ### Steps             # 步骤

推荐部分:
- ### Constraints         # 约束
- ### Output Format       # 输出格式
- ## Resources            # 资源
  - ### Required Tools    # 所需工具
  - ### Context Files     # 上下文文件

可选部分:
- ### Input               # 输入说明
- ### Error Handling      # 错误处理
- ### Examples            # 示例
- ## Permissions          # 权限控制
- ## Version History      # 版本历史
```

### B. 常见问题

**Q1: Skill 和 Slash 命令有什么区别？**
A: Slash 命令（如 `/commit`, `/test`）是 Claude Code 内置的命令，Skill 是用户自定义的命令。

**Q2: Skill 会占用很多 Token 吗？**
A: 不会。得益于渐进式披露，只有被调用的 Skill 才会加载到上下文中。

**Q3: 可以在 Skill 中调用其他 Skill 吗？**
A: 可以，这被称为 Skill 组合（Skill Composition）。

**Q4: Skill 可以访问敏感数据吗？**
A: 需要在 Permissions 部分明确声明，Claude Code 会在执行前请求用户授权。

**Q5: 如何分享 Skill？**
A: 将 `.claude/skills/` 目录打包分享，其他用户放到自己的项目中即可使用。

### C. 参考资源

- [Claude Code 官方文档](https://docs.anthropic.com/claude-code)
- [Agent Skill 视频教程](https://www.bilibili.com/video/BV1cGigBQE6n/)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)

---

## 更新日志

- 2026-01-15: 创建完整 Skill 文档
  - 添加概念解释
  - 对比 MCP vs Skill
  - 提供实战案例
  - 建立最佳实践指南
