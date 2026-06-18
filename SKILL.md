---
name: dev-graph-note-skill
description: Use for ANY development task. Before writing code, check dev-notes/ for context. When solving bugs, making decisions, or discovering insights, write to dev-notes/. Auto-creates dev-notes/ if missing. Maintains a four-layer knowledge base (raw → refined → zettel → methodology) with bidirectional linking and project-global (~/.dev-notes/) support.
---

# Dev Graph Note Skill

项目中和跨项目的开发知识体系，四层加工 + 双链结构。

## ⚠️ 强制执行规则

本 skill 不是可选参考，以下是必须遵守的执行规则：

1. **每次开发任务开始前**：检查项目中是否存在 `dev-notes/`，不存在则立即创建目录结构和 INDEX.md
2. **每次开发任务开始前**：读取 `dev-notes/INDEX.md` 了解项目上下文和待办事项
3. **遇到触发写入的场景**（见"何时写入笔记"）**必须记笔记**，不可跳过
4. **任务完成后**：检查是否需要更新 INDEX.md 中的索引和待办

核心原则：

1. **先读后做**：开始开发任务前，先从 dev-notes 加载上下文
2. **随手记**：产生有价值的发现时，立即记录到 raw/
3. **渐进加工**：积累后提炼，不追求一步到位
4. **带上下文的 todo**：todo 附着在笔记中，不脱离知识孤立存在

---

## 初始化

如果项目中不存在 `dev-notes/` 目录，立即创建：

```
dev-notes/
├── raw/
├── refined/
├── zettel/
├── methodology/
└── INDEX.md
```

也可运行初始化脚本：`bash <skill-dir>/scripts/init.sh <project-path>`

INDEX.md 初始模板见 `references/template-index.md`。

同样，如果 `~/.dev-notes/` 不存在，用相同结构创建全局知识库。

---

## 何时读取笔记

| 场景 | 读取动作 |
|------|----------|
| 开始开发任务前 | 读 INDEX.md，搜索相关笔记 |
| 遇到 bug 时 | 搜索 raw/ 和 zettel/ 是否有类似记录 |
| 做技术决策前 | 搜索 methodology/ 和 refined/ 是否有相关文档 |
| 学习项目约定时 | 搜索 zettel/ 中的概念卡片 |
| 跨项目知识 | 搜索 ~/.dev-notes/ 中的通用方法论 |

---

## 何时写入笔记

### 必须写

| 触发条件 | 写入位置 | 说明 |
|----------|----------|------|
| 解决了一个 bug | `raw/` | 含排查过程和根因 |
| 做了架构/技术决策 | `raw/` | 含决策理由和权衡 |
| 发现非显而易见的坑 | `raw/` | 含具体现象和解决方案 |
| 调试过程中的关键发现 | `raw/` | 记录转折点 |

### 考虑写

| 触发条件 | 写入位置 | 说明 |
|----------|----------|------|
| 完成功能后有可复用经验 | `raw/` | 评估是否有参考价值 |
| 发现文档不准确 | 更新对应笔记 | 而非新建 |

### 写 todo 的时机

开发中产生的待办不是独立事项，而是笔记的一部分。在以下场景顺手记：

| 场景 | 示例 |
|------|------|
| bug 记录中发现关联问题 | "根因修复了，但错误处理也需要加强 → TODO" |
| 技术决策记录了权衡，留下后续改进项 | "当前用方案A，性能瓶颈时需考虑方案B → TODO" |
| 代码审查/阅读中发现需重构之处 | "这个模块耦合严重，需重构 → TODO" |

写法：在笔记正文中用 `## TODO` 段落，每条以 `- [ ]` 开头，完成后改为 `- [x]`。

INDEX.md 的 `## 待办` 区域聚合所有未完成 todo 的链接，方便全局扫描。

### 不需要写

- 琐碎修改（修 typo、改样式细节）
- 已有完善文档的常规操作
- 没有新学习价值的改动

### 跨项目写入

以下内容应写入 `~/.dev-notes/` 而非项目级：
- 框架/语言通用的踩坑经验
- 可迁移的调试方法论
- 通用的技术模式

---

## 何时加工笔记

不要等"整块时间整理"，在以下时机顺手加工：

| 时机 | 动作 |
|------|------|
| 同一主题积累了 3+ 篇 raw 笔记 | 整理到 `refined/`，可拆分多个 refined |
| 单篇 raw 笔记内容丰富、多主题 | 拆分成多个 `refined/`，每个聚焦一个维度 |
| 单篇 raw 笔记已有明确结论 | 可直接整理到 `refined/` |
| refined 中出现独立可引用的概念 | 提取到 `zettel/` |
| 3+ 篇 zettel 暴露了共性模式 | 抽象到 `methodology/` |
| 项目级 methodology 证明可复用 | 迁移到 `~/.dev-notes/methodology/` |

### 加工时的拆分策略

**问自己**：这个 raw 文件有哪些不同视角？

- 如果是讨论记录 → 按主题拆分（如：理念演进、练习设计、章节设计...）
- 如果是 bug 排查 → 可拆分为：根因分析、解决方案、预防措施
- 如果是技术调研 → 可拆分为：技术对比、选型决策、实现细节

**拆分时保留来源**：每个 refined 的 frontmatter 中记录 `source: "[[raw/xxx]]"`

---

## 四层加工体系

```
A(raw) ──整理──▶ B(refined) ──提取──▶ C(zettel) ──抽象──▶ D(methodology)
开发日志/bug记录   结构化文档         单一概念卡片         可复用检查清单/框架
```

| 层级 | 文件夹 | 定位 | 特征 | 命名规范 |
|------|--------|------|------|----------|
| A | `raw/` | 开发过程的原始记录 | 及时、未加工、可能粗糙 | `YYYYMMDD-主题.md` |
| B | `refined/` | 整理后的开发文档 | 结构清晰、有结论 | `主题关键词.md` |
| C | `zettel/` | 最小可知单元 | 单一概念、≤300字、可双链 | `Z-编号-概念名.md` |
| D | `methodology/` | 可操作方法论 | 检查清单、步骤、框架 | `M-编号-框架名.md` |

### ⭐ 一个 raw 可生成多个 refined（Karpathy LLM Wiki 模式）

**核心理念**：raw 是源材料，refined 是维度切分。一个 raw 文件可以从不同视角拆分成多个 refined，每个聚焦一个主题。

**示例**：
- `raw/教材理念探讨.md` (918行) → 拆分为：
  - `refined/练习设计原则-LLM时代.md` (聚焦练习设计)
  - `refined/叙事主线-七本教材对比.md` (聚焦组织逻辑)
  - `refined/十二章设计-小节分解.md` (聚焦章节结构)
  - `refined/经典内容覆盖审计.md` (聚焦内容审计)
  - `refined/教材结构模板-每节每章.md` (聚焦模板结构)

**拆分原则**：
1. 每个 refined 聚焦一个明确的主题/视角
2. 不同 refined 之间可能有交叉引用
3. raw 保持完整，refined 从中"提取+重组"
4. INDEX.md 中所有 refined 都要索引

**好处**：
- 知识是"编译"后的产物，不是每次查询都重新推导
- 交叉引用已经在 refined 层建立
- 查询时可以快速定位到相关维度

各层笔记模板：
- `references/template-raw.md`
- `references/template-refined.md`
- `references/template-zettel.md`
- `references/template-methodology.md`
- `references/template-index.md`

---

## 双链系统

语法：`[[路径/文件名]]` 或 `[[路径/文件名|显示文本]]`

| 从 | 到 | 含义 | 写法示例 |
|----|----|------|----------|
| B | A | 整理来源 | `来源：[[raw/20260603-首启白屏排查]]` |
| C | B | 提取出处 | `source: "[[refined/小程序编译踩坑清单]]"` |
| C | C | 概念关联 | `相关：[[zettel/Z-001-概念名]]` |
| D | C | 方法论依据 | `依据：[[zettel/Z-005-概念名]]` |
| 项目级 | 全局 | 跨项目引用 | `相关：[[~/.dev-notes/zettel/Z-010-React性能优化]]` |

双链是双向的——笔记A用 `[[...]]` 链接到笔记B时，在Obsidian中打开B可看到A引用了它。

---

## 全局 dev-notes

位置：`~/.dev-notes/`，结构与项目级相同。

**适用内容**：
- 框架/语言通用的踩坑和技巧
- 可迁移的调试方法论和检查清单
- 通用技术模式（如性能优化、错误处理）

**项目级与全局的关系**：
- 项目笔记用 `[[~/.dev-notes/...]]` 链接全局笔记
- 当项目级 methodology 被验证可跨项目复用时，迁移到全局
- 全局方法论优先于项目级同名内容

---

## INDEX.md 维护

INDEX.md 是知识库入口，包含：
- 项目技术栈和结构概览
- 各层笔记分类索引
- **待办聚合**：链接到所有含未完成 todo 的笔记
- 最近变更记录

每次新增、加工笔记或完成 todo 后，更新 INDEX.md 对应条目。

### 更新规则

1. **新增 raw** → 在 INDEX.md 的 raw 区添加链接
2. **新增 refined** → 在 INDEX.md 的 refined 区添加链接和简要描述
3. **新增 zettel** → 在 INDEX.md 的 zettel 区按主题分组添加
4. **完成加工** → 在"最近变更"区添加记录
5. **一个 raw 拆分多个 refined** → 在 refined 区添加所有新条目，在"最近变更"中说明拆分情况

---

## 知识库的健康检查（Lint）

定期（或每次大规模更新后）检查：

| 检查项 | 说明 |
|--------|------|
| 孤儿笔记 | 没有被任何其他笔记链接的 refined/zettel |
| 悬空链接 | `[[xxx]]` 引用了不存在的笔记 |
| 未加工的 raw | 超过 7 天且有明确结论但未整理到 refined |
| 缺失的 zettel | refined 中提及核心概念但没有对应的 zettel |
| 矛盾的记录 | 不同笔记中对同一问题的结论冲突 |

---

## 工作流示例

### 解决 bug 的完整流程

1. 读取：在 dev-notes 中搜索是否有类似 bug 记录
2. 排查：解决过程中记录关键发现到 raw/
3. 解决：在 raw 笔记中补充根因和解决方案
4. 记 todo：如果修复不彻底或发现关联问题，在笔记 `## TODO` 中记录
5. 加工：如果值得复用，整理到 refined/（可能拆分多个维度）
6. 更新：更新 INDEX.md（含待办聚合）

### 开始新功能开发

1. 读取 INDEX.md 了解项目上下文和待办事项
2. 搜索相关 zettel 和 methodology
3. 开发过程中记录决策和发现到 raw/
4. 完成后评估是否有值得加工的内容

### 从 raw 提炼多个 refined（典型流程）

1. 阅读 raw 文件，识别不同的主题维度
2. 为每个维度创建一个 refined 文件
3. 每个 refined 聚焦一个明确主题，结构清晰
4. 在 frontmatter 中记录 `source: "[[raw/xxx]]"`
5. 更新 INDEX.md，添加所有新 refined 的索引
6. 在"最近变更"中记录拆分情况

**示例**：`raw/会议记录.md` → `refined/决策点.md` + `refined/行动项.md` + `refined/问题清单.md`

---

## 与 Karpathy LLM Wiki 的对应

本 skill 的设计参考了 Karpathy 的 LLM Wiki 模式：

| Karpathy 概念 | 本 skill 对应 |
|--------------|--------------|
| Raw sources | `raw/` — 不可变的源材料 |
| The wiki | `refined/` + `zettel/` + `methodology/` — LLM 生成并维护的结构化知识 |
| The schema | `SKILL.md` + `AGENTS.md` — 告诉 LLM 如何组织和维护知识库 |
| Index | `INDEX.md` — 内容索引 |
| Log | INDEX.md 中的"最近变更"区 |
| Ingest | 读取 raw → 生成/更新 refined 和 zettel |
| Query | 先读 INDEX.md，再定位到相关笔记 |
| Lint | 定期检查孤儿笔记、悬空链接、矛盾记录 |

**核心理念**：知识库是持久的、复合的产物。交叉引用已经在 refined 层建立，不需要每次查询都重新推导。LLM 负责整理和维护，人类负责判断和探索。