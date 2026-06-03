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