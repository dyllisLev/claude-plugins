# Claude Code Plugins

Claude Code를 위한 커스텀 플러그인 모음입니다.

## 포함된 플러그인

### [dev-workflow](./dev-workflow)

소프트웨어 개발 전체 라이프사이클을 지원하는 **12개의 전문 에이전트** 시스템입니다.

- **12개 전문 에이전트**: Operator, Analyst, Architect, API Designer, Frontend Dev, Backend Dev, Tester, Security Auditor, Verifier, DevOps, Debugger, Documenter
- **2개 커스텀 스킬**: test-driven-development, systematic-debugging
- **기술 스택**: React + Node.js + Python
- **MCP 통합**: context7 (문서 조회), playwright (브라우저 자동화)
- **전체 의존성 맵**: [DEPENDENCIES.md](./dev-workflow/DEPENDENCIES.md) 참조

## 빠른 시작

```bash
# 1. Clone
git clone https://github.com/dyllisLev/claude-plugins.git
cd claude-plugins

# 2. 설치 (플러그인 + MCP 서버 자동 설정)
./install.sh

# 3. Claude 앱 재시작 (필수!)
# macOS: Cmd+Q로 종료 후 다시 실행

# 4. Claude Code CLI 실행
claude code
```

입력:
```
dev 간단한 React 컴포넌트를 만들어줘
```

**참고**: `claude code`는 터미널에서 실행하는 Claude의 CLI 도구입니다.

## 설치

### 자동 설치 (권장)

```bash
git clone https://github.com/dyllisLev/claude-plugins.git
cd claude-plugins
./install.sh
```

설치 스크립트가 자동으로:
1. **플러그인 설치** (심볼릭 링크)
   - `~/.claude/agents` → `dev-workflow/agents` (12개 에이전트)
   - `~/.claude/commands` → `dev-workflow/commands` (dev 명령어)
   - `~/.claude/skills/test-driven-development`
   - `~/.claude/skills/systematic-debugging`

2. **MCP 서버 설정** (선택 가능)
   - context7 (문서 조회)
   - playwright (브라우저 자동화)

설치 후 **Claude 앱을 재시작**해야 합니다 (Cmd+Q 후 재실행).

### 수동 설치

#### 1단계: 플러그인 설치

```bash
git clone https://github.com/dyllisLev/claude-plugins.git
cd claude-plugins

# 심볼릭 링크 생성
ln -s "$(pwd)/dev-workflow/agents" ~/.claude/agents
ln -s "$(pwd)/dev-workflow/commands" ~/.claude/commands
mkdir -p ~/.claude/skills
ln -s "$(pwd)/dev-workflow/skills/test-driven-development" ~/.claude/skills/test-driven-development
ln -s "$(pwd)/dev-workflow/skills/systematic-debugging" ~/.claude/skills/systematic-debugging
```

#### 2단계: MCP 서버 설정 (필수)

MCP 서버 자동 설정 (install.sh에서 건너뛴 경우):

```bash
./setup-mcp.sh
```

또는 수동 설정:

`~/Library/Application Support/Claude/claude_desktop_config.json` 파일을 편집:

```json
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
```

**중요**: 설정 후 Claude 앱을 재시작해야 MCP 서버가 활성화됩니다.

#### MCP 서버 설명

- **context7**: 라이브러리 문서 조회 (React, Next.js, Prisma 등)
  - `mcp__context7__resolve-library-id` - 라이브러리 ID 조회
  - `mcp__context7__query-docs` - 문서 질의

- **playwright**: 브라우저 자동화 및 E2E 테스트
  - `mcp__playwright__browser_navigate` - 페이지 이동
  - `mcp__playwright__browser_snapshot` - 상태 캡처
  - `mcp__playwright__browser_click` - 요소 클릭
  - `mcp__playwright__browser_take_screenshot` - 스크린샷

### (선택) frontend-design 스킬 설치

디자인 중심 UI 개발 시 추가 설치:

```bash
# Claude Code CLI에서 실행
claude code
/skills install frontend-design
```

## 사용법

Claude Code CLI를 실행:

```bash
claude code
```

> `claude code`는 터미널에서 Claude AI와 대화하며 코딩할 수 있는 CLI 도구입니다.

입력 예시:

```
dev 사용자 인증 기능을 구현해줘
dev 결제 API를 만들고 테스트해줘
dev 대시보드 페이지를 만들어줘
```

## 설치 확인

### 파일 설치 확인

```bash
# 에이전트 확인 (12개여야 함)
ls -la ~/.claude/agents/*.md | wc -l

# 명령어 확인
ls -la ~/.claude/commands/dev.md

# 스킬 확인
ls -d ~/.claude/skills/test-driven-development
ls -d ~/.claude/skills/systematic-debugging

# 심볼릭 링크 확인
ls -la ~/.claude/agents      # → dev-workflow/agents
ls -la ~/.claude/commands    # → dev-workflow/commands
```

### MCP 서버 확인

```bash
# Claude Code에서 실행
claude code

# MCP 도구 사용 가능 여부 확인
# context7 함수들이 보이는지 확인:
# - mcp__context7__resolve-library-id
# - mcp__context7__query-docs

# playwright 함수들이 보이는지 확인:
# - mcp__playwright__browser_navigate
# - mcp__playwright__browser_snapshot
# - 기타 등등
```

### 동작 확인

```bash
# Claude Code CLI 실행
claude code

# 프롬프트에서 dev 명령어 테스트
dev 간단한 React 컴포넌트를 만들어줘
```

**참고**: `claude code`는 Claude의 CLI 도구이며, 일반 "Claude" 앱과는 다릅니다.

## 장점

### 심볼릭 링크 방식
- 저장소를 수정하면 즉시 Claude Code에 반영
- Git으로 버전 관리 및 협업 가능
- 여러 프로젝트에서 동일한 플러그인 공유

### 개발 워크플로우
- TDD와 체계적 디버깅 프로세스 내장
- 모든 주요 단계에서 자동 검증
- 병렬 처리로 빠른 개발 속도

## 구조

```
claude-plugins/
├── README.md
├── install.sh
└── dev-workflow/
    ├── README.md
    ├── agents/          # 12개 에이전트
    ├── commands/        # dev 명령어
    ├── skills/          # 커스텀 스킬
    │   ├── test-driven-development/
    │   └── systematic-debugging/
    └── .claude-plugin/
        └── plugin.json
```

## 라이선스

MIT

## 기여

이슈나 PR은 언제든 환영합니다!
