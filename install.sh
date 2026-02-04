#!/bin/bash

# Claude Code Dev Workflow Plugin Installer
# This script installs the dev-workflow plugin using symlinks and configures MCP servers

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
MCP_CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

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
echo -e "${BLUE}[1/4] Installing agents...${NC}"
if create_symlink "${SOURCE_DIR}/agents" "${CLAUDE_DIR}/agents" "agents"; then
    echo -e "${GREEN}✓ Agents installed (12 agents)${NC}"
else
    echo -e "${RED}✗ Failed to install agents${NC}"
    exit 1
fi

# Install commands
echo ""
echo -e "${BLUE}[2/4] Installing commands...${NC}"
if create_symlink "${SOURCE_DIR}/commands" "${CLAUDE_DIR}/commands" "commands"; then
    echo -e "${GREEN}✓ Commands installed (dev command)${NC}"
else
    echo -e "${RED}✗ Failed to install commands${NC}"
    exit 1
fi

# Install skills
echo ""
echo -e "${BLUE}[3/4] Installing skills...${NC}"

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

# Configure MCP servers
echo ""
echo -e "${BLUE}[4/4] Configuring MCP servers...${NC}"

# Ask user if they want to configure MCP servers
echo -e "${YELLOW}MCP servers (context7, playwright) are required for dev-workflow.${NC}"
read -p "Configure MCP servers now? (Y/n): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    # Create config directory if it doesn't exist
    mkdir -p "$(dirname "$MCP_CONFIG_FILE")"

    # Check if config file exists and has MCP servers
    if [ -f "$MCP_CONFIG_FILE" ] && grep -q "mcpServers" "$MCP_CONFIG_FILE"; then
        echo -e "${YELLOW}MCP servers already configured.${NC}"
        read -p "Overwrite existing MCP configuration? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Skipping MCP configuration.${NC}"
        else
            # Create MCP config
            cat > "$MCP_CONFIG_FILE" << 'EOF'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upggr/context7-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@executeautomation/playwright-mcp-server"]
    }
  }
}
EOF
            echo -e "${GREEN}✓ MCP servers configured${NC}"
        fi
    else
        # Create MCP config
        cat > "$MCP_CONFIG_FILE" << 'EOF'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upggr/context7-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@executeautomation/playwright-mcp-server"]
    }
  }
}
EOF
        echo -e "${GREEN}✓ MCP servers configured${NC}"
    fi
else
    echo -e "${BLUE}Skipping MCP configuration. Run ./setup-mcp.sh later to configure.${NC}"
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
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo "   • MCP servers: context7, playwright"
fi
echo ""
echo "⚠️  IMPORTANT: Restart Claude app for MCP changes to take effect!"
echo "   macOS: Cmd+Q to quit, then restart"
echo ""
echo "📝 Next Steps:"
echo "   1. Restart Claude app (if MCP was configured)"
echo "   2. Run: claude code"
echo "   3. Type: dev 간단한 React 컴포넌트를 만들어줘"
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
