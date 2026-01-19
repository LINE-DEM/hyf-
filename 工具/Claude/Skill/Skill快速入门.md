---
creation_date: 2026-01-15 15:00
type: #Type/Tutorial
status: #Status/Active
tags: [Claude_Code, Quick_Start, Tutorial]
aliases: [快速开始, Getting Started]
tech_stack: #Tech/Claude_Code
complexity: ⭐⭐
related_modules: [Skill, Obsidian笔记整理Skill]
---

# Claude Code Skill 快速入门

## 核心摘要

5 分钟快速上手 Claude Code Skill 功能，从零到自动化你的第一个工作流。

---

## 前置条件检查

在开始之前，确保你已经：

- ✅ 安装 Claude Code CLI
- ✅ 订阅 Claude Pro（或有足够的 API 额度）
- ✅ 在当前目录有一个 Obsidian vault（或任何笔记文件夹）
- ✅ 阅读了 [[Skill]] 基础概念（可选，但推荐）

---

## 第一步：创建你的第一个 Skill（5 分钟）

### 方式 1：使用 Claude Code 引导创建（推荐）

打开 Claude Code，输入：

```
请帮我创建一个 Skill，功能是：
每天晚上整理我的 daily note，提取今天学到的关键概念，
并生成一个简短的总结。
```

Claude 会：
1. 创建 `.claude/skills/` 目录结构
2. 生成 SKILL.md 文件
3. 填写基本配置
4. 询问你的偏好设置

### 方式 2：手动创建

1. **创建目录结构**

```bash
mkdir -p .claude/skills/my-first-skill
cd .claude/skills/my-first-skill
```

2. **创建 SKILL.md 文件**

```markdown
# my-first-skill

## Metadata
- Name: 我的第一个 Skill
- Trigger: /my-first
- Description: 测试 Skill 功能

## Instruction

### Goal
在当前目录创建一个测试文件

### Steps
1. 创建文件 test-skill-output.md
2. 写入当前时间和欢迎信息
3. 列出当前目录的文件

## Resources

### Required Tools
- Write
- Bash
```

3. **测试 Skill**

回到 Claude Code，输入：

```bash
/my-first
```

或者：

```
运行我的第一个 Skill
```

如果成功，你会看到：
- 创建了 `test-skill-output.md` 文件
- 文件中包含欢迎信息和时间戳
- 列出了当前目录的文件

🎉 恭喜！你已经创建并运行了第一个 Skill！

---

## 第二步：实用 Skill 示例（10 分钟）

### 示例 1：快速笔记整理

创建一个能帮你快速整理散乱笔记的 Skill。

**场景**：你有很多 `未命名.md` 或 `temp.md` 文件，需要快速规范命名和添加 frontmatter。

**创建 Skill**：

`.claude/skills/quick-organize/SKILL.md`:

```markdown
# quick-organize

## Metadata
- Name: 快速笔记整理
- Trigger: /quick-org
- Description: 快速规范化未命名笔记

## Instruction

### Goal
找出所有未规范命名的笔记，重命名并添加 frontmatter

### Steps
1. 搜索文件名包含"未命名"、"temp"、"new"的 .md 文件
2. 读取文件内容
3. 根据内容推断主题
4. 提议新的文件名
5. 询问用户确认
6. 重命名文件
7. 添加标准的 YAML frontmatter
8. 生成整理报告

### Constraints
- 必须用户确认后才能重命名
- 保留文件的修改时间
- 备份原文件名到 frontmatter 的 aliases 字段

## Resources

### Required Tools
- Glob: 查找文件
- Read: 读取内容
- Write: 添加 frontmatter
- Bash: 重命名文件

### Context Files
- CLAUDE.md: 获取命名规范
- Templates/AI_Refactor_Rules.md: frontmatter 模板
```

**使用**：

```bash
/quick-org
```

输出示例：

```
找到 3 个未规范命名的文件：

1. 未命名.md
   内容摘要：关于 C++ 虚函数的笔记
   建议命名：虚函数详解.md
   建议位置：26-01-15/

2. temp-notes.md
   内容摘要：UE5 Actor 的生命周期
   建议命名：Actor生命周期.md
   建议位置：26-01-15/

3. new 1.md
   内容摘要：编译流程笔记
   建议命名：Visual_Studio编译流程.md
   建议位置：编译/

是否确认重命名？(y/n)
```

---

### 示例 2：代码实验自动化

**场景**：学习 C++ 时，经常需要写示例代码、编译运行、记录结果。

**创建 Skill**：

`.claude/skills/cpp-quick-test/SKILL.md`:

```markdown
# cpp-quick-test

## Metadata
- Name: C++ 快速实验
- Trigger: /cpp-test
- Description: 快速编译运行 C++ 代码并记录结果

## Instruction

### Goal
提供一个主题，自动生成示例代码、编译运行、生成实验报告

### Steps
1. 接收用户输入的主题（如"智能指针"）
2. 生成演示代码
3. 保存为 .cpp 文件
4. 编译（g++ -std=c++17 -O2）
5. 运行并捕获输出
6. 生成 markdown 实验报告
7. 保存到今天的日期文件夹

### Input
```yaml
topic: "智能指针"              # 学习主题
include_comments: true       # 代码中包含详细注释
run_count: 1                # 运行次数（性能测试可多次）
```

### Output Structure
```
26-01-15/
├── 智能指针_demo.cpp
├── 智能指针_实验报告.md
└── output.txt
```

## Resources

### Required Tools
- Write: 创建代码文件和报告
- Bash: 编译和运行
```

**使用**：

```bash
/cpp-test 智能指针
```

或者在对话中：

```
帮我做个关于智能指针的 C++ 实验
```

Claude 会自动：
1. 生成 `unique_ptr`, `shared_ptr` 的示例代码
2. 编译运行
3. 生成报告

输出的实验报告：

```markdown
---
creation_date: 2026-01-15 15:30
type: #Type/Experiment
tags: [C++, 智能指针, RAII]
---

# C++ 智能指针实验报告

## 实验目的
理解 C++11 引入的智能指针（unique_ptr, shared_ptr）的使用和内存管理机制

## 实验代码

见 [[26-01-15/智能指针_demo.cpp]]

关键代码片段：
```cpp
// unique_ptr 演示：独占所有权
std::unique_ptr<int> p1 = std::make_unique<int>(42);
// std::unique_ptr<int> p2 = p1;  // 编译错误！不可复制
std::unique_ptr<int> p2 = std::move(p1);  // 转移所有权
```

## 运行结果

```
unique_ptr value: 42
After move, p1 is null: 1
shared_ptr count: 1
After copy, count: 2
```

## 分析

### 关键发现
1. `unique_ptr` 独占资源，不可复制，只能移动
2. `shared_ptr` 使用引用计数，可安全共享
3. 使用 `make_unique` 和 `make_shared` 更安全

### 内存管理优势
- 自动释放：离开作用域自动调用析构函数
- 异常安全：即使抛出异常也能正确释放
- 避免内存泄漏：无需手动 delete

## 关联知识
- [[RAII]] - 智能指针的设计原则
- [[C++移动语义]] - unique_ptr 的移动操作
- [[引用计数]] - shared_ptr 的实现原理

---

生成时间：2026-01-15 15:32
生成工具：cpp-quick-test skill v1.0.0
```

---

### 示例 3：知识链接助手

**场景**：写笔记时，希望自动识别应该添加双向链接的概念。

**创建 Skill**：

`.claude/skills/smart-linker/SKILL.md`:

```markdown
# smart-linker

## Metadata
- Name: 智能链接助手
- Trigger: /smart-link
- Description: 自动识别笔记中应该添加链接的概念

## Instruction

### Goal
分析当前笔记，找出应该添加双向链接但尚未添加的概念

### Steps
1. 读取当前打开的笔记
2. 提取文本中的关键概念（名词、技术术语）
3. 在 vault 中搜索同名或相关的笔记
4. 列出建议添加链接的位置
5. 询问用户确认
6. 自动添加 [[链接]]

### Constraints
- 不要链接常见词汇（如"是"、"的"、"了"）
- 已经有链接的词不重复添加
- 优先链接核心概念（高频、重要的术语）

## Resources

### Required Tools
- Read, Edit, Grep, Glob
```

**使用**：

假设你正在编辑 `26-01-15/Actor组件系统.md`：

```markdown
# Actor 组件系统

Actor 是 UE5 中的基本对象，可以附加多个 Component。
每个 Component 负责特定功能，如 StaticMeshComponent 负责渲染。

Controller 可以控制 Pawn 类型的 Actor。
```

运行 `/smart-link`，Claude 会建议：

```
发现可添加链接的概念：

1. Actor → [[Actor]]（已存在笔记）
   位置：第 3 行

2. Component → [[Component]]（已存在笔记）
   位置：第 3 行，第 4 行（2处）

3. StaticMeshComponent → [[Component#StaticMeshComponent]]（章节链接）
   位置：第 4 行

4. Controller → [[Controller]]（已存在笔记）
   位置：第 6 行

5. Pawn → [[Pawn]]（已存在笔记）
   位置：第 6 行

是否添加这些链接？(y/n)
```

确认后，笔记自动变为：

```markdown
# Actor 组件系统

[[Actor]] 是 UE5 中的基本对象，可以附加多个 [[Component]]。
每个 [[Component]] 负责特定功能，如 [[Component#StaticMeshComponent|StaticMeshComponent]] 负责渲染。

[[Controller]] 可以控制 [[Pawn]] 类型的 [[Actor]]。
```

---

## 第三步：使用现成的 Skill 套件（5 分钟）

如果你已经阅读了 [[Obsidian笔记整理Skill]]，可以直接使用预定义的 4 个 Skill：

### 快速部署

1. **创建目录结构**

```bash
mkdir -p .claude/skills/weekly-summary
mkdir -p .claude/skills/note-formatter
mkdir -p .claude/skills/knowledge-graph
mkdir -p .claude/skills/daily-organizer
```

2. **复制 Skill 定义**

从 [[Obsidian笔记整理Skill]] 文档中复制对应的 SKILL.md 内容到各个目录。

3. **测试 Skill**

```bash
# 测试是否安装成功
/skills

# 应该看到：
# Available Skills:
#   - weekly-summary: 每周学习总结生成器
#   - note-formatter: 笔记格式规范化工具
#   - knowledge-graph: 知识图谱生成器
#   - daily-organizer: Daily Note 自动整理器
```

4. **立即使用**

```bash
# 整理今天的笔记
/organize-daily

# 生成本周总结
/weekly-summary

# 构建知识图谱
/build-graph

# 检查笔记格式
/format-notes --mode check
```

---

## 常见使用场景速查

### 场景 1：每天睡前例行

```bash
# 一键整理今天的学习内容
/organize-daily

# 输出：
# ✅ 今日笔记已整理
# ✅ 提取了 5 个新概念
# ✅ 3 个 TODO 已完成
# ✅ 2 个未完成任务已迁移至明日
```

### 场景 2：周日晚上回顾

```bash
# 生成本周学习总结
/weekly-summary

# 输出：
# ✅ 已生成 Weekly-2026-W03.md
# ✅ 本周学习了 15 篇笔记
# ✅ 主要主题：C++、UE5
# ✅ 已创建 12 个双向链接
```

### 场景 3：月初大扫除

```bash
# 检查笔记格式
/format-notes --mode check

# 输出：
# 🔴 发现 3 个严重问题
# 🟡 发现 8 个警告
#
# 是否自动修复？(y/n)
```

```bash
# 更新知识图谱
/build-graph

# 输出：
# ✅ 已分析 150 篇笔记
# ✅ 识别出 25 个核心概念
# ✅ 生成了 5 个主题 MOC
# ✅ 推荐学习路径已更新
```

### 场景 4：学习新概念时

```bash
# 快速实验 C++ 特性
/cpp-test 移动语义

# 输出：
# ✅ 已生成演示代码
# ✅ 编译成功
# ✅ 运行结果已保存
# ✅ 实验报告：26-01-15/移动语义_实验报告.md
```

### 场景 5：写笔记时

```
你正在写笔记...

突然需要添加很多链接？

直接说："帮我智能添加相关概念的双向链接"

Claude 会调用 smart-linker skill 自动处理
```

---

## 进阶技巧

### 技巧 1：链式调用 Skill

```bash
# 周日晚上的完整工作流
/organize-daily && /weekly-summary && /build-graph

# 或者创建一个 meta-skill
/weekly-routine
  → 调用 organize-daily
  → 调用 weekly-summary
  → 调用 format-notes (check only)
  → 调用 build-graph
  → 生成综合报告
```

### 技巧 2：Skill 参数化

在 `.claude/config.json` 中保存常用配置：

```json
{
  "skills": {
    "weekly-summary": {
      "default_range": "this-week",
      "topics": ["C++", "UE5"],
      "create_backlinks": true
    },
    "cpp-test": {
      "compiler": "g++",
      "std": "c++17",
      "optimization": "-O2"
    }
  }
}
```

然后直接运行：

```bash
/weekly-summary
# 自动使用配置文件中的参数
```

### 技巧 3：条件触发

某些 Skill 可以设置自动触发条件：

```markdown
# auto-backup

## Metadata
- Trigger: on-file-change
- Condition: file_type == "md" && file_size > 1000

## Instruction
当 .md 文件超过 1000 字时，自动备份到 .claude/backups/
```

### 技巧 4：Skill 模板化

创建 Skill 模板，快速生成新 Skill：

```bash
/skill new-from-template --template note-organizer
```

---

## 最佳实践

### ✅ 应该做的

1. **从简单开始**
   - 第一个 Skill 只做一件简单的事
   - 测试成功后再扩展功能

2. **详细的注释**
   - 在 SKILL.md 中写清楚每一步的目的
   - 记录边界情况和错误处理

3. **测试再测试**
   - 使用 `--dry-run` 模式先测试
   - 在测试数据上运行，不要直接操作重要文件

4. **版本控制**
   - 将 `.claude/` 目录纳入 git
   - 记录 Skill 的版本历史

5. **分享和复用**
   - 将好用的 Skill 分享给他人
   - 从社区获取灵感

### ❌ 不应该做的

1. **过度复杂**
   - 一个 Skill 包含太多功能
   - 难以维护和调试

2. **跳过测试**
   - 直接在重要数据上运行未测试的 Skill
   - 不做备份就批量修改文件

3. **忽略权限**
   - 给 Skill 过高的权限
   - 不明确声明需要的权限

4. **硬编码路径**
   - 在 Skill 中写死文件路径
   - 应该使用相对路径或配置文件

---

## 故障排查

### 问题 1：Skill 无法执行

**检查清单**：
- [ ] SKILL.md 文件是否存在于正确的目录？
- [ ] 文件格式是否正确（markdown）？
- [ ] Metadata 部分是否完整？
- [ ] Trigger 命令是否以 `/` 开头？

**调试命令**：
```bash
/skill info {skill-name}
# 查看 Skill 详细信息和可能的错误
```

### 问题 2：权限被拒绝

**症状**：执行 Skill 时提示 "Permission denied"

**解决**：
1. 检查 Skill 的 Permissions 部分
2. 在执行时选择"Allow"或"Allow always"
3. 或在 `.claude/config.json` 中添加：

```json
{
  "permissions": {
    "weekly-summary": {
      "read": "allow",
      "write": "allow:Summaries/"
    }
  }
}
```

### 问题 3：输出不符合预期

**调试步骤**：
1. 使用 `--verbose` 模式查看详细日志
2. 检查 Context Files 是否正确加载
3. 验证输入参数格式
4. 简化 Skill 逐步测试

---

## 学习路径

### 新手（第 1 周）
- ✅ 创建第一个简单 Skill
- ✅ 使用现成的 daily-organizer
- ✅ 理解 Skill 的基本结构

### 进阶（第 2-3 周）
- ✅ 创建 3-5 个实用 Skill
- ✅ 学会参数化配置
- ✅ 组合多个 Skill

### 高级（第 4+ 周）
- ✅ 创建 meta-skill
- ✅ 实现条件触发
- ✅ 贡献到社区

---

## 资源链接

### 官方文档
- [Claude Code 官方文档](https://docs.anthropic.com/claude-code)
- [Skill API 参考](https://docs.anthropic.com/claude-code/skills)

### 社区资源
- [Skill 模板库](https://github.com/claude-code-skills)
- [最佳实践集合](https://github.com/claude-code-skills/best-practices)

### 相关笔记
- [[Skill]] - 完整的 Skill 概念指南
- [[Obsidian笔记整理Skill]] - 4 个实用 Skill 套件
- [[Claude_Code使用理由_针对你的场景]] - 为什么要用 Claude Code

---

## 下一步

完成快速入门后，你可以：

1. **立即开始使用**
   - 部署 [[Obsidian笔记整理Skill]] 套件
   - 运行 `/organize-daily` 体验自动化

2. **深入学习**
   - 阅读 [[Skill]] 了解底层原理
   - 学习高级特性（条件执行、Skill 组合）

3. **自定义扩展**
   - 根据自己的需求修改现有 Skill
   - 创建针对自己工作流的 Skill

4. **加入社区**
   - 分享你的 Skill
   - 学习他人的最佳实践

---

## 总结

### 核心要点

1. **Skill = 自动化工作流**
   - 把重复的任务定义成 Skill
   - 一次定义，无限复用

2. **从简单开始**
   - 第一个 Skill 只做一件事
   - 逐步增加复杂度

3. **测试很重要**
   - 使用 `--dry-run` 模式
   - 小范围测试后再大规模使用

4. **组合的力量**
   - 多个简单 Skill 组合
   - 实现复杂的自动化流程

### 时间投资 vs 收益

| 投入 | 产出 |
|------|------|
| 5 分钟学习 | 创建第一个 Skill |
| 30 分钟实践 | 自动化日常任务 |
| 2 小时深入 | 建立完整的知识管理系统 |
| 持续使用 | 每天节省 30-60 分钟 |

**投资回报率**：极高！

---

**现在就开始吧！运行你的第一个 Skill：**

```bash
/my-first
```

或者：

```
帮我创建一个简单的 Skill，测试一下功能
```

🚀 祝你在自动化的道路上越走越远！
