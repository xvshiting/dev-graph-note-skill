# dev-graph-note-skill

A coding agent skill that maintains a structured dev-notes knowledge base with four processing layers and bidirectional linking. Inspired by [Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern.

## How it works

```
A(raw) ──整理──▶ B(refined) ──提取──▶ C(zettel) ──抽象──▶ D(methodology)
开发日志/bug记录   结构化文档         单一概念卡片         可复用检查清单/框架
```

- **raw/** — raw development logs, bug records, meeting notes (immutable sources)
- **refined/** — structured documents distilled from raw (one raw → many refined possible)
- **zettel/** — atomic concept cards with bidirectional links (≤300 words each)
- **methodology/** — reusable checklists and frameworks abstracted from zettels
- **INDEX.md** — entry point with overview, index, and todo aggregation

### Key Insight: One raw → Many refined

Unlike traditional note-taking, a single raw file can be split into multiple refined documents, each focusing on a different dimension:

**Example**:
- `raw/meeting-notes.md` → `refined/decisions.md` + `refined/action-items.md` + `refined/questions.md`

This follows Karpathy's insight: knowledge is compiled once and kept current, not re-derived on every query.

Notes link across layers with `[[path/filename]]` wiki-style links. Todos live inside notes (not as separate files), keeping context with action items.

See [SKILL.md](./SKILL.md) for the full specification.

## Installation

### opencode (project-level)

Copy (or symlink) the skill into your project's `.opencode/skills/` directory:

```bash
# from your project root
mkdir -p .opencode/skills
cp -r /path/to/dev-graph-note-skill .opencode/skills/dev-graph-note-skill
```

Or add the path in `opencode.json`:

```json
{
  "skills": {
    "paths": ["/path/to/dev-graph-note-skill"]
  }
}
```

### opencode (global)

Install globally so every project gets the skill:

```bash
mkdir -p ~/.config/opencode/skills
cp -r /path/to/dev-graph-note-skill ~/.config/opencode/skills/dev-graph-note-skill
```

Or via `~/.config/opencode/opencode.json`:

```json
{
  "skills": {
    "paths": ["/path/to/dev-graph-note-skill"]
  }
}
```

### Claude Code

opencode auto-loads skills from `~/.claude/skills/`:

```bash
mkdir -p ~/.claude/skills
cp -r /path/to/dev-graph-note-skill ~/.claude/skills/dev-graph-note-skill
```

### Cursor / Windsurf / Cline (instructions mode)

These agents don't have a native skill system, but you can import SKILL.md content into their instructions file:

```bash
# Cursor
cat /path/to/dev-graph-note-skill/SKILL.md >> .cursor/rules/dev-notes.mdc

# Windsurf
cat /path/to/dev-graph-note-skill/SKILL.md >> .windsurfrules

# Cline
cat /path/to/dev-graph-note-skill/SKILL.md >> .clinerules

# GitHub Copilot
cat /path/to/dev-graph-note-skill/SKILL.md >> .github/copilot-instructions.md
```

### Remote URL

If you host this skill at a public URL, opencode can load it via:

```json
{
  "skills": {
    "urls": ["https://example.com/.well-known/skills/"]
  }
}
```

See the [opencode skill docs](https://opencode.ai) for the expected URL format.

## File structure

```
dev-graph-note-skill/
├── SKILL.md                    # Skill definition (frontmatter + instructions)
├── references/
│   ├── AGENTS.md               # AGENTS.md template — add this to your project!
│   ├── template-raw.md          # Raw note template
│   ├── template-refined.md      # Refined document template
│   ├── template-zettel.md       # Zettel (atomic note) template
│   ├── template-methodology.md  # Methodology template
│   └── template-index.md        # INDEX.md template
└── scripts/
    └── init.sh                  # Initialize dev-notes/ directory structure
```

## Quick start

> **重要**：仅安装 skill 不够。Agent 不会主动加载 skill，需要配合 AGENTS.md 指令才能确保每次开发任务都走 dev-notes 流程。见下方"关键步骤"。

### 关键步骤

Skill 是被动的——只有模型判定描述匹配时才加载，且加载后可能不执行初始化和写笔记。要确保 dev-notes 工作流生效，需要**双保险**：

1. **安装 skill**（定义规范和模板）
2. **添加 AGENTS.md 指令**（强制 agent 每次会话都检查和写入 dev-notes）

```bash
# 1. 安装 skill（选一种方式，见上方 Installation）
cp -r /path/to/dev-graph-note-skill .opencode/skills/dev-graph-note-skill

# 2. 添加 AGENTS.md 指令到你的项目（关键！）
cat dev-graph-note-skill/references/AGENTS.md >> AGENTS.md
```

AGENTS.md 模板在 `references/AGENTS.md`，它告诉 agent：
- 每次开发任务前必须检查/创建 `dev-notes/` 并读取 INDEX.md
- 遇到 bug 解决、技术决策、踩坑等场景必须写笔记
- 任务结束后更新 INDEX.md

### Without AGENTS.md

如果你只安装 skill 不加 AGENTS.md，agent 可能：
- 不自动创建 `dev-notes/` 目录
- 干活时不记笔记（专注编码任务而跳过记录步骤）

### With AGENTS.md

AGENTS.md 的指令会在每次会话中生效，agent 会：
1. 自动检查并创建 `dev-notes/` 目录结构
2. 开发前读取 INDEX.md 获取上下文
3. 在开发过程中写入笔记
4. 任务结束时更新 INDEX.md

你也可以手动初始化：

```bash
bash /path/to/dev-graph-note-skill/scripts/init.sh .
```

## Compatibility with Obsidian

The `dev-notes/` directory is a standard Obsidian vault. Open it in Obsidian to browse, search, and visualize the bidirectional link graph — no special plugins required.

## License

MIT