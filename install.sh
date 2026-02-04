#!/bin/bash

# Claude Code Dev Workflow Plugin Installer
# This script installs the dev-workflow plugin using symlinks

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the Claude directories
CLAUDE_DIR="${HOME}/.claude"
PLUGIN_NAME="dev-workflow"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/${PLUGIN_NAME}"

echo "🚀 Installing Claude Code Dev Workflow Plugin..."
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory not found: ${SOURCE_DIR}${NC}"
    exit 1
fi

# Create Claude directory if it doesn't exist
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}Creating Claude directory...${NC}"
    mkdir -p "$CLAUDE_DIR"
fi

# Function to create symlink safely
create_symlink() {
    local source=$1
    local target=$2
    local name=$3

    if [ ! -d "$source" ] && [ ! -f "$source" ]; then
        echo -e "${YELLOW}Warning: Source not found: ${source}${NC}"
        return 1
    fi

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            echo -e "${BLUE}Removing existing symlink: ${name}${NC}"
            rm "$target"
        else
            echo -e "${RED}Error: ${name} already exists (not a symlink): ${target}${NC}"
            echo -e "${YELLOW}Please remove or backup this directory manually.${NC}"
            return 1
        fi
    fi

    echo -e "${GREEN}Creating symlink: ${name}${NC}"
    ln -s "$source" "$target"
    return 0
}

# Install agents
echo ""
echo -e "${BLUE}[1/3] Installing agents...${NC}"
if create_symlink "${SOURCE_DIR}/agents" "${CLAUDE_DIR}/agents" "agents"; then
    echo -e "${GREEN}✓ Agents installed${NC}"
else
    echo -e "${RED}✗ Failed to install agents${NC}"
    exit 1
fi

# Install commands
echo ""
echo -e "${BLUE}[2/3] Installing commands...${NC}"
if create_symlink "${SOURCE_DIR}/commands" "${CLAUDE_DIR}/commands" "commands"; then
    echo -e "${GREEN}✓ Commands installed${NC}"
else
    echo -e "${RED}✗ Failed to install commands${NC}"
    exit 1
fi

# Install skills
echo ""
echo -e "${BLUE}[3/3] Installing skills...${NC}"

# Create skills directory if it doesn't exist
mkdir -p "${CLAUDE_DIR}/skills"

# Install test-driven-development skill
if create_symlink \
    "${SOURCE_DIR}/skills/test-driven-development" \
    "${CLAUDE_DIR}/skills/test-driven-development" \
    "test-driven-development"; then
    echo -e "${GREEN}✓ test-driven-development skill installed${NC}"
fi

# Install systematic-debugging skill
if create_symlink \
    "${SOURCE_DIR}/skills/systematic-debugging" \
    "${CLAUDE_DIR}/skills/systematic-debugging" \
    "systematic-debugging"; then
    echo -e "${GREEN}✓ systematic-debugging skill installed${NC}"
fi

# Verify installation
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "📍 Installation Details:"
echo "   Source: ${SOURCE_DIR}"
echo ""
echo "   Installed:"
echo "   • ~/.claude/agents → dev-workflow/agents (12 agents)"
echo "   • ~/.claude/commands → dev-workflow/commands (dev command)"
echo "   • ~/.claude/skills/test-driven-development"
echo "   • ~/.claude/skills/systematic-debugging"
echo ""
echo "📝 Next Steps:"
echo "   1. Run: claude code"
echo "   2. Check if agents are available by typing: dev"
echo ""
echo "📚 Usage Examples:"
echo "   dev 사용자 인증 기능을 구현해줘"
echo "   dev 결제 API를 만들고 테스트해줘"
echo "   dev 대시보드 페이지를 만들어줘"
echo ""
echo "🔍 Verify Installation:"
echo "   ls -la ~/.claude/agents"
echo "   ls -la ~/.claude/commands"
echo "   ls -la ~/.claude/skills"
echo ""
