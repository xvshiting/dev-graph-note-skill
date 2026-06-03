#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH="${1:-.}"
DEV_NOTES_DIR="$PROJECT_PATH/dev-notes"
GLOBAL_DEV_NOTES_DIR="$HOME/.dev-notes"

create_structure() {
    local base="$1"
    local label="$2"

    if [ -d "$base" ]; then
        echo "[$label] 已存在: $base"
    else
        mkdir -p "$base/raw" "$base/refined" "$base/zettel" "$base/methodology"
        echo "[$label] 已创建目录结构: $base"
    fi

    if [ -f "$base/INDEX.md" ]; then
        echo "[$label] INDEX.md 已存在，跳过"
    else
        cat > "$base/INDEX.md" << 'EOF'
---
updated: YYYY-MM-DD
---

# 项目开发知识库

## 项目概览

- 技术栈：（填写）
- 项目结构：（简述）

## 索引

### raw（原始记录）

### refined（精炼文档）

### zettel（原子笔记）

### methodology（方法论）

## 待办

（聚合所有含未完成 TODO 的笔记链接）

## 最近变更

- YYYY-MM-DD：初始化知识库
EOF
        echo "[$label] 已创建 INDEX.md"
    fi
}

echo "=== 初始化 dev-notes ==="
create_structure "$DEV_NOTES_DIR" "项目级"

echo ""
echo "=== 初始化全局 dev-notes ==="
create_structure "$GLOBAL_DEV_NOTES_DIR" "全局"

echo ""
echo "初始化完成！"