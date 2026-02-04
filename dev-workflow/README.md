# Dev Workflow Plugin

소프트웨어 개발 전체 라이프사이클을 지원하는 **12개의 전문 에이전트** 시스템입니다.

## 개요

- **기술 스택**: React + Node.js + Python
- **MCP 도구**: context7 (문서 조회), playwright (브라우저 자동화)
- **스킬 통합**:
  - frontend-design (독창적 UI 디자인)
  - test-driven-development (TDD 방법론)
  - systematic-debugging (체계적 디버깅)
- **호출 방식**: `dev` prefix로 Operator 호출 (사용자는 Operator에게만 지시)
- **품질 보증**: 모든 주요 단계(요구사항/설계/코드) 완료 후 Verifier 검증 필수
- **워크플로우**: 검증 통과 → 다음 단계 진입 / 테스트 실패 시 자동 수정 반복

## 에이전트 목록

### 핵심 에이전트 (Core)
| 에이전트 | 역할 | 모델 |
|---------|------|------|
| `dev` (operator) | 전체 프로세스 조율 및 에이전트 오케스트레이션 | sonnet |
| `analyst` | 요구사항 분석 및 명세 작성 | sonnet |
| `architect` | 시스템/아키텍처 설계 | sonnet |

### 개발 에이전트 (Development)
| 에이전트 | 역할 | 모델 |
|---------|------|------|
| `frontend-dev` | React/TypeScript 개발 + frontend-design 스킬 | sonnet |
| `backend-dev` | Node.js/Python 개발 + TDD + 체계적 디버깅 | sonnet |
| `api-designer` | REST/GraphQL API 설계 | sonnet |

### 품질 에이전트 (Quality)
| 에이전트 | 역할 | 모델 |
|---------|------|------|
| `verifier` | 요구사항/설계/코드 검증 (모든 단계) | sonnet |
| `tester` | 테스트 코드 작성 및 실행 | sonnet |
| `security-auditor` | 보안 취약점 분석 | sonnet |

### 운영 에이전트 (Operations)
| 에이전트 | 역할 | 모델 |
|---------|------|------|
| `devops` | CI/CD, 배포, 인프라 관리 | sonnet |
| `debugger` | 체계적 디버깅 및 근본 원인 분석 | sonnet |
| `documenter` | 기술 문서 및 API 문서 작성 | sonnet |

## 워크플로우

```
┌─────────────────────────────────────────────────────────────┐
│                        OPERATOR                              │
│              (전체 프로세스 조율 및 오케스트레이션)              │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
                    ┌──────────┐
                    │ ANALYST  │
                    │ 요구분석  │
                    └──────────┘
                          │
                          ▼
                    ┌──────────┐
                    │ VERIFIER │      [1단계: 요구사항 검증]
                    │요구사항검증│
                    └──────────┘
                          │
                          ▼
                    ┌──────────┐
                    │📋 사용자  │
                    │시나리오   │
                    │  확인    │
                    └──────────┘
                          │
                          ▼
                    ┌──────────┐
                    │ARCHITECT │
                    │시스템설계 │
                    └──────────┘
                          │
                          ▼
                    ┌──────────┐
                    │ VERIFIER │      [2단계: 설계 검증]
                    │ 설계검증  │
                    └──────────┘
                          │
         ┌────────────────┼────────────────┐
         ▼                                 ▼
   ┌───────────┐                    ┌─────────────┐
   │API-DESIGNER│                    │FRONTEND-DEV │ 🚀 동시
   │  API 설계  │                    │  React/TS   │    실행
   └───────────┘                    └─────────────┘
         │                                 │
         │                          ┌─────────────┐
         └──────────────────────────│BACKEND-DEV  │
                                    │Node.js/Python│
                                    └─────────────┘
                          │
                          ▼
                    ┌──────────┐
                    │ VERIFIER │      [3단계: 코드 검증]
                    │ 코드검증  │
                    └──────────┘
                          │
                          ▼
                    ┌──────────┐
                    │  TESTER  │
                    │테스트 실행│
                    └──────────┘
                          │
    ┌─────────────────────┼─────────────────────┐
    ▼                     ▼                     ▼
┌──────────┐      ┌───────────────┐      ┌──────────┐
│ VERIFIER │      │SECURITY-AUDITOR│      │ DEVOPS   │
│최종 검증  │      │   보안 감사    │      │CI/CD 배포│
│(Large만) │      │                │      │          │
└──────────┘      └───────────────┘      └──────────┘
                          │
         ┌────────────────┼────────────────┐
         ▼                                 ▼
   ┌─────────────┐                  ┌─────────────┐
   │  DEBUGGER   │                  │ DOCUMENTER  │
   │문제 해결     │                  │  문서 작성   │
   └─────────────┘                  └─────────────┘
```

## 사용법

### Operator(dev) 호출
```
dev 사용자 인증 기능을 구현해줘
dev 결제 API를 만들고 테스트해줘
dev 대시보드 페이지를 만들어줘
```

### 개별 에이전트 호출
```
analyst 이 기능의 요구사항을 분석해줘
architect 시스템 구조를 설계해줘
frontend-dev 로그인 폼을 만들어줘
tester API를 테스트해줘
```

## MCP 도구

### context7
라이브러리 문서 조회:
- `mcp__context7__resolve-library-id` - 라이브러리 ID 조회
- `mcp__context7__query-docs` - 문서 질의

### playwright
브라우저 자동화:
- `mcp__playwright__browser_navigate` - 페이지 이동
- `mcp__playwright__browser_snapshot` - 상태 캡처
- `mcp__playwright__browser_click` - 클릭
- `mcp__playwright__browser_type` - 텍스트 입력
- `mcp__playwright__browser_take_screenshot` - 스크린샷

## 스킬

### frontend-design
독창적이고 세련된 UI 디자인 생성:
- **사용 에이전트**: frontend-dev
- **기능**: 차별화된 타이포그래피, 명확한 미학적 방향성, 정교한 애니메이션
- **적용 대상**: 랜딩 페이지, 대시보드, 포트폴리오 등 디자인 중심 UI
- **특징**: 일반적인 AI 디자인 회피, 맥락에 맞는 독창적 디자인

### test-driven-development (TDD)
테스트 주도 개발 방법론:
- **사용 에이전트**: backend-dev
- **핵심 원칙**: 구현 코드 작성 전 반드시 실패하는 테스트 먼저 작성
- **사이클**: RED (실패 테스트) → Verify → GREEN (최소 구현) → Verify → REFACTOR
- **적용 대상**: 모든 기능 개발, 버그 수정, 리팩토링
- **효과**: 조기 버그 발견, 회귀 방지, 문서화, 안전한 리팩토링

### systematic-debugging
체계적 디버깅 프로세스:
- **사용 에이전트**: backend-dev, debugger
- **핵심 원칙**: 근본 원인 파악 없이 수정 금지
- **프로세스**:
  1. Phase 1: 근본 원인 조사 (에러 분석, 재현, 증거 수집)
  2. Phase 2: 패턴 분석 (작동 예제 비교)
  3. Phase 3: 가설 검증 (최소 변경으로 테스트)
  4. Phase 4: 구현 (TDD로 테스트 작성 후 수정)
- **적용 대상**: 모든 버그, 테스트 실패, 예상치 못한 동작
- **효과**: 빠른 문제 해결 (15-30분 vs 2-3시간), 신규 버그 방지

## 설치

### 자동 설치 (권장)

```bash
git clone https://github.com/YOUR_USERNAME/claude-plugins.git
cd claude-plugins
./install.sh
```

설치 스크립트는 심볼릭 링크를 사용하여 플러그인을 설치합니다. 이렇게 하면:
- 저장소를 수정하면 즉시 플러그인에 반영됩니다
- Git으로 버전 관리가 가능합니다
- 여러 프로젝트에서 동일한 플러그인을 공유할 수 있습니다

### 수동 설치

```bash
git clone https://github.com/YOUR_USERNAME/claude-plugins.git
ln -s "$(pwd)/claude-plugins/dev-workflow" ~/.claude/plugins/dev-workflow
```

## 디렉토리 구조

```
~/.claude/plugins/dev-workflow/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── 00-operator.md
│   ├── 01-analyst.md
│   ├── 02-architect.md
│   ├── 03-api-designer.md
│   ├── 04-frontend-dev.md
│   ├── 05-backend-dev.md
│   ├── 06-tester.md
│   ├── 07-security-auditor.md
│   ├── 08-verifier.md
│   ├── 09-devops.md
│   ├── 10-debugger.md
│   └── 11-documenter.md
└── README.md
```

## 플러그인 활성화

Claude Code에서 `/plugins` 명령 실행 후 `dev-workflow` 플러그인을 활성화합니다.

## 라이선스

MIT
