# Command: /generate-design-spec

## Description
Muse와 Visual Architect를 조율하여 UX 컨셉과 디자인 시스템을 생성합니다. 비즈니스 인텐트를 감각적 경험으로, 그리고 구체적인 디자인 토큰으로 변환하는 전체 프로세스를 자동화합니다.

## Prerequisites
- `specs/01_intent_map.json` (비즈니스 인텐트)
- `specs/03_structural_spec.a2ui.json` (UI 구조)
- Stitch MCP 서버 연결 (디자인 자산 접근용)

## Execution Steps

### Phase 1: UX Concept Creation (Muse)

**Agent:** Muse (UX Creative Director)

**Objective:** 비즈니스 인텐트를 감각적인 사용자 경험 시나리오로 변환

**Actions:**
1. `specs/01_intent_map.json`의 각 인텐트를 분석
2. 기술적 용어를 배제하고 "부드러운 상호작용", "흐르는 듯한 정보 연결"과 같은 감각적 표현으로 UX 시나리오 작성
3. 시각적 설계의 기준이 될 `design_brief` JSON 생성:
   - **Mood:** 전체적인 분위기 (예: Calm, Professional, Energetic)
   - **Motion:** 애니메이션의 성격 (예: Smooth, Snappy, Fluid)
   - **Hierarchy:** 정보의 시각적 우선순위
   - **Voice:** 브랜드 톤 앤 매너

**Output:** `specs/04_ux_concept.md`

**Validation:**
- [ ] 모든 인텐트가 UX 시나리오에 반영되었는가?
- [ ] `design_brief` JSON이 파일 하단에 포함되었는가?
- [ ] 기술 용어 없이 감성적 톤을 유지했는가?

---

### Phase 2: Design System Generation (Visual Architect)

**Agent:** Visual Architect (Design Systems Lead)

**Objective:** Stitch 프로젝트를 분석하여 시맨틱 디자인 시스템 `DESIGN.md` 생성

**Actions:**

#### 2.1 Asset Retrieval
```
1. mcp_stitch:list_projects → 프로젝트 ID 확보
2. mcp_stitch:get_screen → 스크린 데이터 및 스크린샷 URL 확보
3. web_fetch → HTML/CSS 소스 다운로드 및 분석
```

#### 2.2 Semantic Analysis
분석 대상:
- **Atmosphere:** 스크린샷에서 느껴지는 분위기를 형용사로 표현
- **Color System:** Hex 코드를 "Deep Muted Teal-Navy (#294056)" 형식으로 변환
- **Typography:** 폰트 크기와 weight를 시맨틱하게 표현
- **Spacing:** 간격 시스템의 일관성과 리듬 분석
- **Elevation:** 그림자와 레이어의 질감 묘사

#### 2.3 DESIGN.md Synthesis
`design-md` Skill의 구조를 준수하여 작성:
```markdown
# Design System

## Atmosphere
[감각적 분위기 설명]

## Color Palette
- Primary: Descriptive Name (Hex Code)
- Secondary: Descriptive Name (Hex Code)
...

## Typography
- Headline: [자연어 설명] (기술적 수치)
...

## Spacing & Layout
...

## Elevation & Shadows
...
```

#### 2.4 Visual Specification Mapping
`DESIGN.md`와 `03_structural_spec.a2ui.json`을 결합하여 최종 시각적 명세 생성:
```json
{
  "components": {
    "login_button": {
      "backgroundColor": "#294056",
      "textColor": "#FFFFFF",
      "borderRadius": "8px",
      "elevation": "level-2"
    }
  }
}
```

**Output:**
- `DESIGN.md` (프로젝트 루트 또는 `specs/`)
- `specs/05_visual_spec.json`

**Validation:**
- [ ] 모든 색상이 `Descriptive Name (Hex Code)` 형식인가?
- [ ] Tailwind 클래스가 자연어로 번역되었는가?
- [ ] `03_structural_spec.a2ui.json`의 모든 컴포넌트가 시각적 토큰과 매핑되었는가?

---

### Phase 3: Integration Validation

**Cross-Validation:** UX Concept ↔ Design System 일관성 검증

**Checks:**
1. **Mood Alignment:** `design_brief`의 Mood가 DESIGN.md의 Atmosphere와 일치하는가?
2. **Motion Consistency:** Motion 가이드가 실제 애니메이션 값에 반영되었는가?
3. **Component Coverage:** 모든 UI 컴포넌트가 시각적 토큰을 가지는가?

**Error Handling:**
- **Minor Issues (Warnings):** 리포트에 기록하고 계속 진행
- **Critical Issues (Errors):** 해당 Agent 재실행 (최대 3회)
- **Max Retry 초과:** 사용자에게 에스컬레이션

---

## Command Execution Flow

```
specs/01_intent_map.json + specs/03_structural_spec.a2ui.json
     ↓
[Phase 1: Muse]
     ↓
specs/04_ux_concept.md (+ design_brief JSON)
     ↓
[Phase 2: Visual Architect]
     ↓
DESIGN.md + specs/05_visual_spec.json
     ↓
[Phase 3: Integration Validation]
     ↓
Design System Package
```

---

## Usage

### Basic Usage
```bash
# Prerequisites가 준비된 경우
/generate-design-spec

# Output:
# - specs/04_ux_concept.md
# - DESIGN.md
# - specs/05_visual_spec.json
```

### With Stitch Project ID
```bash
# 특정 Stitch 프로젝트 지정
/generate-design-spec --stitch-project-id "abc123"
```

### Regenerate Only Design System
```bash
# UX 컨셉은 유지하고 디자인 시스템만 재생성
/generate-design-spec --skip-muse
```

---

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `STITCH_MCP_SERVER` | Stitch MCP 서버 URL | `auto-detect` |
| `DESIGN_OUTPUT_DIR` | 디자인 파일 출력 디렉토리 | `./specs` |
| `DESIGN_MD_LOCATION` | DESIGN.md 위치 | `./DESIGN.md` |
| `MAX_RETRY` | 검증 실패 시 최대 재시도 횟수 | `3` |

---

## Error Codes

| Code | Description | Action |
|------|-------------|--------|
| `D001` | Intent map not found | Run `/generate-ui-spec` first |
| `D002` | Structural spec not found | Run `/generate-ui-spec` first |
| `D003` | Stitch MCP connection failed | Check MCP server status |
| `D004` | design_brief missing in ux_concept.md | Re-run Muse with proper template |
| `D005` | Visual token mapping incomplete | Review component coverage |

---

## Best Practices

### 1. Sequential Pipeline
먼저 `/generate-ui-spec`으로 구조를 만든 후 `/generate-design-spec` 실행

### 2. Iterative Refinement
UX 컨셉을 먼저 검토하고, 만족스러우면 디자인 시스템 생성

### 3. Source of Truth
생성된 `DESIGN.md`를 Stitch 에이전트의 primary prompt로 활용

### 4. Version Control
각 디자인 스펙을 Git 커밋하여 디자인 진화 과정 추적

---

**Muse와 Visual Architect가 협업하여 감각적 UX와 구체적 디자인 시스템을 자동 생성합니다.**
