# AGENTS.md — 项目级指令模板

将以下内容添加到你项目的 `AGENTS.md`（或 `.opencode/instructions`），确保 agent 每次会话都遵循 dev-notes 工作流。

---

## Dev Notes 工作流（强制）

在开始任何开发任务之前，你必须：

1. 检查项目根目录下是否存在 `dev-notes/` 目录。如果不存在，立即创建：
   ```
   dev-notes/
   ├── raw/
   ├── refined/
   ├── zettel/
   ├── methodology/
   └── INDEX.md
   ```
2. 读取 `dev-notes/INDEX.md` 了解项目上下文和待办事项。
3. 根据当前任务，在 dev-notes 中搜索相关笔记（bug 记录、技术决策、踩坑经验等）。

在开发过程中，你必须在以下场景写入笔记：

- 解决了一个 bug → 写入 `dev-notes/raw/`（含排查过程和根因）
- 做了架构或技术决策 → 写入 `dev-notes/raw/`（含决策理由和权衡）
- 发现了非显而易见的坑 → 写入 `dev-notes/raw/`（含现象和解决方案）
- 调试过程中的关键发现 → 写入 `dev-notes/raw/`

任务结束后，更新 `dev-notes/INDEX.md` 中的索引和待办区。

跨项目通用知识（框架踩坑、通用调试方法等）写入 `~/.dev-notes/`。

---

## 从 raw 提炼 refined 的规则

**重要**：一个 raw 文件可以从不同视角拆分成多个 refined，每个聚焦一个主题。

**示例**：
- `raw/会议记录.md` → `refined/决策点.md` + `refined/行动项.md` + `refined/问题清单.md`
- `raw/技术调研.md` → `refined/技术对比.md` + `refined/选型决策.md` + `refined/实现细节.md`

**拆分原则**：
1. 每个 refined 聚焦一个明确的主题/视角
2. 在 frontmatter 中记录 `source: "[[raw/xxx]]"`
3. 更新 INDEX.md，添加所有新 refined 的索引
4. 在"最近变更"中说明拆分情况
