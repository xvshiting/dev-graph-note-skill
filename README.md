# dev-graph-note-skill

A coding agent skill that maintains a structured dev-notes knowledge base with four processing layers and bidirectional linking. It auto-creates `dev-notes/` when missing and supports project-local + global (`~/.dev-notes/`) knowledge bases.

## How it works

```
A(raw) ──整理──▶ B(refined) ──提取──▶ C(zettel) ──抽象──▶ D(methodology)
开发日志/bug记录   结构化文档         单一概念卡片         可复用检查清单/框架
```

- **raw/** — raw development logs, bug records, meeting notes
- **refined/** — structured documents distilled from raw
- **zettel/** — atomic concept cards with bidirectional links (≤300 words each)
- **methodology/** — reusable checklists and frameworks abstracted from zettels
- **INDEX.md** — entry point with overview, index, and todo aggregation

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
│   └── note-templates.md       # Note templates for each layer + INDEX.md
└── scripts/
    └── init.sh                  # Initialize dev-notes/ directory structure
```

## Quick start

After installing the skill, the agent will automatically:

1. Create `dev-notes/` in your project if it doesn't exist
2. Read `dev-notes/INDEX.md` before starting development work
3. Write notes when bugs are solved, decisions are made, or insights emerge
4. Link notes across layers with `[[...]]` syntax
5. Maintain `INDEX.md` with a todo aggregation section

You can also manually initialize:

```bash
bash /path/to/dev-graph-note-skill/scripts/init.sh .
```

## Compatibility with Obsidian

The `dev-notes/` directory is a standard Obsidian vault. Open it in Obsidian to browse, search, and visualize the bidirectional link graph — no special plugins required.

## License

MIT