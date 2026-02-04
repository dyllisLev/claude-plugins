# Dev Workflow 의존성 맵

이 문서는 dev-workflow 플러그인의 전체 의존성을 설명합니다.

## 호출 체인

```
dev (명령어/스킬)
  └─→ operator (에이전트)
       ├─→ analyst (에이전트)
       ├─→ verifier (에이전트)
       ├─→ architect (에이전트)
       ├─→ api-designer (에이전트)
       ├─→ frontend-dev (에이전트)
       ├─→ backend-dev (에이전트)
       ├─→ tester (에이전트)
       ├─→ debugger (에이전트)
       ├─→ security-auditor (에이전트)
       ├─→ devops (에이전트)
       └─→ documenter (에이전트)
```

## 에이전트별 의존성

### operator (00-operator.md)
- **역할**: 전체 워크플로우 조율
- **호출하는 에이전트**: 모든 에이전트 (위 목록 참조)
- **사용하는 스킬**: 없음 (다른 에이전트에게 스킬 사용 지시)
- **사용하는 MCP**: 없음
- **특징**: Task tool로만 다른 에이전트 호출

### analyst (01-analyst.md)
- **역할**: 요구사항 분석 및 명세 작성
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**:
  - `context7` (문서 조회)
    - `mcp__context7__resolve-library-id`
    - `mcp__context7__query-docs`
  - `WebSearch`, `WebFetch`

### architect (02-architect.md)
- **역할**: 시스템 아키텍처 설계
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**:
  - `context7` (문서 조회)
    - `mcp__context7__resolve-library-id`
    - `mcp__context7__query-docs`
  - `WebSearch`, `WebFetch`

### api-designer (03-api-designer.md)
- **역할**: REST/GraphQL API 설계
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**: 없음

### frontend-dev (04-frontend-dev.md)
- **역할**: React/TypeScript UI 개발
- **호출하는 에이전트**: 없음
- **사용하는 스킬**:
  - `frontend-design` (독창적 UI 디자인)
    - 사용 시기: 랜딩 페이지, 대시보드, 포트폴리오 등
- **사용하는 MCP**:
  - `context7` (문서 조회)
    - React, Next.js, Tailwind 등
  - `playwright` (UI 확인)
    - `mcp__playwright__browser_navigate`
    - `mcp__playwright__browser_snapshot`
    - `mcp__playwright__browser_click`
    - `mcp__playwright__browser_take_screenshot`

### backend-dev (05-backend-dev.md)
- **역할**: Node.js/Python 백엔드 개발
- **호출하는 에이전트**: 없음
- **사용하는 스킬**:
  - `test-driven-development` (TDD 방법론) **필수**
    - 모든 기능 구현 전 실패하는 테스트 작성
  - `systematic-debugging` (체계적 디버깅) **필수**
    - 모든 버그 발생 시 근본 원인 분석
- **사용하는 MCP**:
  - `context7` (문서 조회)
    - Express, Fastify, Prisma, SQLAlchemy 등

### tester (06-tester.md)
- **역할**: 테스트 실행 및 검증
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**:
  - `curl` (API 테스트)
  - `playwright` (E2E 테스트)
    - `mcp__playwright__browser_navigate`
    - `mcp__playwright__browser_snapshot`
    - `mcp__playwright__browser_click`
    - `mcp__playwright__browser_type`
    - `mcp__playwright__browser_fill_form`
    - `mcp__playwright__browser_take_screenshot`
    - `mcp__playwright__browser_wait_for`

### security-auditor (07-security-auditor.md)
- **역할**: 보안 취약점 분석
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**: 없음

### verifier (08-verifier.md)
- **역할**: 요구사항/설계/코드 검증
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**: 없음

### devops (09-devops.md)
- **역할**: CI/CD, 배포, 인프라 관리
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**: 없음

### debugger (10-debugger.md)
- **역할**: 버그 원인 분석 및 해결
- **호출하는 에이전트**: 없음
- **사용하는 스킬**:
  - `systematic-debugging` (체계적 디버깅) **필수**
    - 4단계 디버깅 프로세스
- **사용하는 MCP**: 없음

### documenter (11-documenter.md)
- **역할**: 기술 문서 및 API 문서 작성
- **호출하는 에이전트**: 없음
- **사용하는 스킬**: 없음
- **사용하는 MCP**: 없음

## 스킬 의존성

### 1. test-driven-development
- **위치**: `skills/test-driven-development/`
- **파일**:
  - `SKILL.md` - 메인 스킬 정의
  - `testing-anti-patterns.md` - 안티패턴 가이드
- **사용하는 에이전트**:
  - `backend-dev` (필수)
  - `operator` (backend-dev에게 사용 지시)
- **목적**: 실패하는 테스트 먼저 작성 → 최소 구현 → 리팩토링

### 2. systematic-debugging
- **위치**: `skills/systematic-debugging/`
- **파일**:
  - `SKILL.md` - 메인 스킬 정의
  - `root-cause-tracing.md` - 근본 원인 추적 가이드
  - `defense-in-depth.md` - 심층 방어 전략
  - `condition-based-waiting.md` - 조건 기반 대기 패턴
  - `condition-based-waiting-example.ts` - 코드 예제
  - `find-polluter.sh` - 테스트 오염 탐지 스크립트
  - `test-pressure-*.md` - 테스트 압력 시나리오 (1-3)
  - `test-academic.md` - 학술적 배경
  - `CREATION-LOG.md` - 생성 로그
- **사용하는 에이전트**:
  - `backend-dev` (모든 버그 발생 시)
  - `debugger` (필수)
  - `operator` (backend-dev/debugger에게 사용 지시)
- **목적**: 4단계 프로세스로 근본 원인 파악 후 수정

### 3. frontend-design
- **위치**: 외부 (공식 marketplace)
- **사용하는 에이전트**:
  - `frontend-dev` (디자인 중심 UI 개발 시)
  - `operator` (frontend-dev에게 사용 지시)
- **목적**: 독창적이고 세련된 UI 디자인 생성

## MCP 도구 의존성

### 1. context7 (문서 조회)
- **제공 함수**:
  - `mcp__context7__resolve-library-id` - 라이브러리 ID 조회
  - `mcp__context7__query-docs` - 문서 질의
- **사용하는 에이전트**:
  - `analyst` - 관련 문서/API 조사
  - `architect` - 기술 스택 결정 시
  - `frontend-dev` - React/Next.js/Tailwind 문서 조회
  - `backend-dev` - Express/Prisma/SQLAlchemy 문서 조회
- **필수**: Yes (문서 기반 정확한 구현을 위해)

### 2. playwright (브라우저 자동화)
- **제공 함수**:
  - `mcp__playwright__browser_navigate` - 페이지 이동
  - `mcp__playwright__browser_snapshot` - 페이지 상태 캡처
  - `mcp__playwright__browser_click` - 요소 클릭
  - `mcp__playwright__browser_type` - 텍스트 입력
  - `mcp__playwright__browser_fill_form` - 폼 채우기
  - `mcp__playwright__browser_take_screenshot` - 스크린샷
  - `mcp__playwright__browser_wait_for` - 대기
- **사용하는 에이전트**:
  - `frontend-dev` - UI 확인 및 검증
  - `tester` - E2E 테스트 실행
- **필수**: Yes (프론트엔드 검증을 위해)

### 3. WebSearch & WebFetch
- **사용하는 에이전트**:
  - `analyst` - 리서치 및 정보 수집
  - `architect` - 기술 조사
- **필수**: No (보조 도구)

## 설치 요구사항 요약

### 필수 설치 항목

1. **에이전트** (12개):
   ```bash
   ~/.claude/agents/
   ├── 00-operator.md
   ├── 01-analyst.md
   ├── 02-architect.md
   ├── 03-api-designer.md
   ├── 04-frontend-dev.md
   ├── 05-backend-dev.md
   ├── 06-tester.md
   ├── 07-security-auditor.md
   ├── 08-verifier.md
   ├── 09-devops.md
   ├── 10-debugger.md
   └── 11-documenter.md
   ```

2. **명령어** (1개):
   ```bash
   ~/.claude/commands/
   └── dev.md
   ```

3. **스킬** (2개):
   ```bash
   ~/.claude/skills/
   ├── test-driven-development/
   │   ├── SKILL.md
   │   └── testing-anti-patterns.md
   └── systematic-debugging/
       ├── SKILL.md
       ├── root-cause-tracing.md
       ├── defense-in-depth.md
       ├── condition-based-waiting.md
       ├── condition-based-waiting-example.ts
       ├── find-polluter.sh
       ├── test-pressure-1.md
       ├── test-pressure-2.md
       ├── test-pressure-3.md
       ├── test-academic.md
       └── CREATION-LOG.md
   ```

4. **MCP 서버** (2개):
   - `context7` - Claude Code에서 별도 설정 필요
   - `playwright` - Claude Code에서 별도 설정 필요

### 선택 설치 항목

1. **frontend-design 스킬** - 공식 marketplace에서 설치 가능 (디자인 중심 UI 개발 시 필요)

## 워크플로우별 필요 의존성

### Small 작업 (버그 수정, 스타일 수정)
- **에이전트**: operator, 해당 개발 에이전트, tester, verifier
- **스킬**: systematic-debugging (버그 수정 시)
- **MCP**: curl 또는 playwright (테스트용)

### Medium 작업 (새 컴포넌트, 기능 수정)
- **에이전트**: operator, analyst, 개발 에이전트, tester, verifier
- **스킬**: test-driven-development (backend), frontend-design (frontend)
- **MCP**: context7, curl, playwright

### Large 작업 (새 기능, DB 변경)
- **에이전트**: 모든 12개 에이전트
- **스킬**: 모든 3개 스킬
- **MCP**: 모든 MCP 도구

## 의존성 검증 방법

```bash
# 에이전트 설치 확인
ls -la ~/.claude/agents/*.md | wc -l  # 12개여야 함

# 명령어 설치 확인
ls -la ~/.claude/commands/dev.md

# 스킬 설치 확인
ls -d ~/.claude/skills/test-driven-development
ls -d ~/.claude/skills/systematic-debugging

# MCP 서버 확인 (Claude Code 설정에서)
# Settings → MCP Servers → context7, playwright 확인
```
