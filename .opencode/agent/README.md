# Architect System Overview

## 전체 아키텍처

```
                    User Request
                         ↓
              ┌──────────────────────┐
              │   Chief Architect    │  (Orchestrator)
              │  chiefArchitect.md   │
              └──────────────────────┘
                         ↓
        ┌────────────────┼────────────────┐
        ↓                                  ↓
┌───────────────┐                  ┌──────────────────┐
│ Logic         │                  │ Structural       │
│ Architect     │ ← Integration → │ Architect        │
│               │    Validation    │                  │
└───────────────┘                  └──────────────────┘
        ↓                                  ↓
specs/03_logic_schema.json     specs/03_structural_spec.a2ui.json
```

## 에이전트 역할 분담

### 1. Chief Architect (Orchestrator)
**File:** `.opencode/agent/chiefArchitect.md`

**책임:**
- 전체 파이프라인 관리
- Logic & Structural Architects 조율
- 산출물 간 일관성 검증
- 최종 패키지 생성

**5 Phase Protocol:**
1. Intent Parsing & Validation
2. Logic Architecture (Delegation)
3. Structural Architecture (Delegation)
4. Integration & Validation
5. Final Assembly & Delivery

### 2. Logic Architect (State & Flow Engineer)
**File:** `.opencode/agent/logicArchitect.md`

**책임:**
- 비즈니스 로직 설계
- 상태 변수 정의 (Local/Global/Persistent)
- 액션 함수 명세
- API/Repository 매핑

**출력:** `specs/03_logic_schema.json`

**제약:** UI 요소 언급 금지, 순수 로직만 다룸

### 3. Structural Architect (Widget Tree Engineer)
**File:** `.opencode/agent/structuralArchitect.md`

**책임:**
- A2UI v0.9 프로토콜 기반 UI 구조 설계
- 인접 리스트(Adjacency List) 방식 컴포넌트 정의
- JSON 포인터를 통한 데이터 바인딩
- 표준 카탈로그 컴포넌트 활용

**출력:** `specs/03_structural_spec.a2ui.json`

**제약:** 디자인 요소 언급 금지, 기능적 배치만 다룸

## Command Pipeline

### Available Commands

| # | Command | Agent | Input | Output |
|---|---------|-------|-------|--------|
| 1 | `generate-intent-map` | Chief | User request | `01_intent_map.json` |
| 2 | `run-logic-architect` | Logic | `01_intent_map.json` | `03_logic_schema.json` |
| 3 | `run-structural-architect` | Structural | `03_logic_schema.json` | `03_structural_spec.a2ui.json` |
| 4 | `validate-integration` | Chief | Both schemas | `validation_report.json` |
| 5 | `assemble-final-output` | Chief | All specs | Final package + report |

**Details:** [`.opencode/agent/commands/architect-commands.md`](./commands/architect-commands.md)

## 사용 시나리오

### Scenario 1: 새 기능 개발 (처음부터)

```bash
# 1. 사용자 요청 입력
User: "사용자가 제품을 검색하고 상세 정보를 볼 수 있어야 합니다"

# 2. Chief Architect 실행
> generate-intent-map --from-request "사용자가 제품을 검색하고 상세 정보를 볼 수 있어야 합니다"
# Output: specs/01_intent_map.json
#   - Intents: SearchProducts, ViewProductDetail
#   - Entities: Product, SearchQuery

# 3. Logic Architect 실행
> run-logic-architect
# Output: specs/03_logic_schema.json
#   - States: searchKeyword, searchResults, selectedProduct
#   - Actions: performSearch, selectProduct
#   - Services: ProductService.search, ProductService.getDetail

# 4. Structural Architect 실행
> run-structural-architect
# Output: specs/03_structural_spec.a2ui.json
#   - Components: TextField (검색), List (결과), Card (상세)
#   - Data bindings: /searchKeyword, /searchResults, /selectedProduct

# 5. 검증
> validate-integration
# Result: VALID
#   - Data bindings: 8/8 ✓
#   - Action mappings: 3/3 ✓

# 6. 최종 패키지 생성
> assemble-final-output
# Result: specs/ 폴더에 완전한 스펙 패키지 생성
```

### Scenario 2: 기존 스펙 수정

```bash
# 기존 intent_map.json 수정 후

# 1. Logic 업데이트만 필요한 경우
> run-logic-architect --update
# 변경된 인텐트만 재처리

# 2. 검증
> validate-integration
# 불일치 발견 시 자동으로 Structural도 업데이트 제안

# 3. Structural 업데이트
> run-structural-architect --incremental
# Logic schema 변경 사항만 반영
```

### Scenario 3: 디버깅 (검증 실패)

```bash
> validate-integration

# Error: Data binding mismatch
# Component 'product_price' references undefined state '/price'
# Suggestion: Add 'price' to selectedProduct state in logic_schema.json

# 수정 필요 → Logic Architect에게 위임
> run-logic-architect --fix-state "selectedProduct.price"

# 재검증
> validate-integration
# Result: VALID ✓
```

## 데이터 흐름 예시

### SearchProducts 인텐트 전체 흐름

#### 1. Intent Definition (Chief)
```json
{
  "name": "SearchProducts",
  "purpose": "사용자가 키워드로 제품을 검색한다",
  "parameters": {
    "keyword": "String"
  }
}
```

#### 2. Logic Schema (Logic Architect)
```json
{
  "states": {
    "searchKeyword": {"type": "String", "scope": "local"},
    "searchResults": {"type": "List<Product>", "scope": "local"},
    "isSearching": {"type": "bool", "scope": "local"}
  },
  "actions": {
    "updateSearchKeyword": {
      "parameters": [{"name": "keyword", "type": "String"}],
      "stateChanges": ["searchKeyword"]
    },
    "performSearch": {
      "async": true,
      "stateChanges": ["isSearching", "searchResults"],
      "calls": ["ProductService.search"]
    }
  },
  "services": {
    "ProductService": {
      "search": {
        "endpoint": "/api/products/search",
        "parameters": {"keyword": "String"},
        "returns": "List<Product>"
      }
    }
  }
}
```

#### 3. Structural Spec (Structural Architect)
```jsonl
{"createSurface": {"surfaceId": "search_screen", "catalogId": "..."}}

{"updateComponents": {
  "components": [
    {"id": "root", "component": "Column", "children": ["search_input", "results_list"]},
    {
      "id": "search_input",
      "component": "TextField",
      "label": "검색",
      "value": {"path": "/searchKeyword"},
      "onChange": {"event": {"name": "updateSearchKeyword"}}
    },
    {
      "id": "results_list",
      "component": "List",
      "iterator": {"path": "/searchResults"},
      "child": "product_item"
    },
    {
      "id": "product_item",
      "component": "Card",
      "child": "product_name"
    },
    {
      "id": "product_name",
      "component": "Text",
      "text": {"path": "name"}
    }
  ]
}}

{"updateDataModel": {
  "path": "/",
  "value": {
    "searchKeyword": "",
    "searchResults": [],
    "isSearching": false
  }
}}
```

#### 4. Validation (Chief)
```json
{
  "status": "valid",
  "checks": {
    "dataBindings": [
      {"component": "search_input", "path": "/searchKeyword", "state": "searchKeyword", "valid": true},
      {"component": "results_list", "path": "/searchResults", "state": "searchResults", "valid": true}
    ],
    "actionMappings": [
      {"event": "updateSearchKeyword", "action": "updateSearchKeyword", "valid": true}
    ]
  }
}
```

## 확장 가능성

### 추가 가능한 Architects

1. **Style Architect**
   - Role: 디자인 시스템 적용 (색상, 폰트, 간격)
   - Input: `03_structural_spec.a2ui.json`
   - Output: `04_styled_spec.a2ui.json`

2. **Navigation Architect**
   - Role: 화면 간 전환 및 라우팅 설계
   - Input: Multiple intents
   - Output: `05_navigation_schema.json`

3. **Performance Architect**
   - Role: 렌더링 최적화, 레이지 로딩, 캐싱 전략
   - Input: All schemas
   - Output: `06_performance_optimizations.json`

### 추가 가능한 Commands

1. **`generate-test-scenarios`**
   - Logic schema와 Structural spec에서 테스트 케이스 자동 생성

2. **`export-to-platform`**
   - A2UI spec을 Flutter, React, Swift UI 코드로 변환

3. **`simulate-user-flow`**
   - Intent 시퀀스를 시뮬레이션하여 동작 검증

## 파일 구조

```
.opencode/
├── agent/
│   ├── chiefArchitect.md           # Orchestrator
│   ├── logicArchitect.md           # Logic designer
│   ├── structuralArchitect.md      # UI designer
│   └── commands/
│       └── architect-commands.md   # Command reference
├── examples/
│   ├── intent_example.json
│   ├── logic_state_variables_example.json
│   ├── logic_actions_example.json
│   ├── logic_services_example.json
│   └── logic_schema_output_example.json
└── skills/
    ├── a2ui-tree-builder/
    │   └── SKILL.md
    └── logic-state-mapper/
        └── SKILL.md

specs/
├── 00_entity_dictionary.json       # Entity definitions
├── 01_intent_map.json              # Business intents
├── 03_logic_schema.json            # State & logic
├── 03_structural_spec.a2ui.json    # UI structure
├── validation_report.json          # Integration validation
└── INTEGRATION_REPORT.md           # Final report
```

## 품질 보증

### Validation Checkpoints

| Phase | Checkpoint | Validator |
|-------|-----------|-----------|
| 1 | Intent clarity | Chief Architect |
| 2 | Logic purity (no UI) | Logic Architect |
| 3 | A2UI protocol compliance | Structural Architect |
| 4 | Data binding integrity | Chief Architect |
| 5 | Action mapping consistency | Chief Architect |
| 6 | Entity type alignment | Chief Architect |

### Quality Metrics

- **Logic Schema:**
  - UI 관련 단어 0개
  - Entity Dictionary 준수 100%
  - 타입 안전성 100%

- **Structural Spec:**
  - A2UI 프로토콜 위반 0개
  - 디자인 요소 언급 0개
  - JSON 포인터 유효성 100%

- **Integration:**
  - 데이터 바인딩 매칭 100%
  - 액션 매핑 매칭 100%

## 시작하기

### Quick Start

1. **Chief Architect 프롬프트 로드**
   ```
   AI에게 .opencode/agent/chiefArchitect.md 내용 제공
   ```

2. **사용자 요청 입력**
   ```
   "사용자가 [기능 설명]을 할 수 있어야 합니다"
   ```

3. **자동 실행**
   ```
   Chief Architect가 5 Phase Protocol 자동 실행
   → 최종 스펙 패키지 생성
   ```

### 다음 단계

- [ ] Chief Architect 프롬프트로 첫 Intent 처리해보기
- [ ] 생성된 스펙들의 일관성 확인
- [ ] Integration Report 검토
- [ ] 실제 코드 구현으로 연결

---

**이제 Intent-to-UI 자동화 파이프라인이 완성되었습니다!** 🚀
