# Architect Commands Reference

Chief Architect가 호출하는 커맨드들의 상세 명세입니다.

---

## 1. `generate-intent-map`

### Purpose
사용자의 자연어 요청 또는 비정형 요구사항을 구조화된 `intent_map.json`으로 변환합니다.

### Input
- **User Request:** 자연어 설명, 기능 목록, 또는 사용자 스토리
- **Reference:** `specs/00_entity_dictionary.json` (존재 시)

### Process
1. 사용자 요청에서 핵심 비즈니스 인텐트 추출
2. 각 인텐트의 목적(purpose), 액터(actor), 파라미터(parameters) 정의
3. 인텐트 간 의존성 및 시퀀스 분석
4. 필요한 엔티티 식별 및 Entity Dictionary 업데이트

### Output
```json
{
  "intents": [
    {
      "name": "SearchProducts",
      "purpose": "사용자가 키워드로 제품을 검색한다",
      "actor": "User",
      "parameters": {
        "keyword": "String",
        "category": "String?"
      },
      "triggers": ["FilterResults", "ShowProductDetail"]
    }
  ],
  "entities": ["Product", "Category", "User"]
}
```

**File:** `specs/01_intent_map.json`

### Validation
- [ ] 각 인텐트가 명확한 비즈니스 가치를 가지는가?
- [ ] 파라미터 타입이 Entity Dictionary에 정의되었는가?
- [ ] 인텐트 간 순환 의존성이 없는가?

### Example Usage
```bash
# User says: "사용자가 제품을 검색하고 장바구니에 추가할 수 있어야 합니다"
> generate-intent-map --from-request "사용자가 제품을 검색하고 장바구니에 추가할 수 있어야 합니다"

# Output: specs/01_intent_map.json
# - Intents: SearchProducts, AddToCart
# - Entities: Product, CartItem
```

---

## 2. `run-logic-architect`

### Purpose
Logic Architect 에이전트를 실행하여 비즈니스 로직 및 상태 관리 스키마를 생성합니다.

### Input
- **Required:** `specs/01_intent_map.json`
- **Reference:** `specs/00_entity_dictionary.json`

### Process
Logic Architect의 4단계 프로토콜 실행:
1. **Intent Analysis:** 상태 변수 정의
2. **Action Definition:** 액션 함수 명세
3. **Service Mapping:** API/Repository 정의
4. **Schema Generation:** 최종 logic_schema.json 생성

### Output
```json
{
  "$schema": "logic_schema_v1",
  "intent": "SearchProducts",
  "stateManagement": {
    "pattern": "Provider",
    "states": { /* 상태 변수들 */ },
    "actions": { /* 액션 함수들 */ },
    "services": { /* 서비스 레이어 */ }
  },
  "dataFlow": { /* 데이터 흐름 */ },
  "entityReferences": { /* 엔티티 참조 */ }
}
```

**File:** `specs/03_logic_schema.json`

### Monitoring Points
- Step 1 완료 시: 상태 변수 목록 확인
- Step 2 완료 시: 액션 타입 시그니처 검증
- Step 3 완료 시: API 엔드포인트 정합성 확인
- Step 4 완료 시: 전체 스키마 JSON 유효성 검증

### Validation
- [ ] UI 컴포넌트 이름이 포함되지 않았는가?
- [ ] 모든 타입이 Entity Dictionary에 정의되었는가?
- [ ] 비동기 작업이 명확히 표시되었는가?

### Example Usage
```bash
> run-logic-architect --intent-map specs/01_intent_map.json

# Progress:
# [1/4] Intent Analysis... ✓
# [2/4] Action Definition... ✓
# [3/4] Service Mapping... ✓
# [4/4] Schema Generation... ✓

# Output: specs/03_logic_schema.json
```

---

## 3. `run-structural-architect`

### Purpose
Structural Architect 에이전트를 실행하여 A2UI v0.9 기반 UI 구조를 생성합니다.

### Input
- **Required:** `specs/03_logic_schema.json`
- **Reference:** A2UI Standard Catalog (`https://a2ui.dev/specification/v0_9/standard_catalog.json`)

### Process
Structural Architect의 4단계 프로토콜 실행:
1. **Hierarchy Definition:** UI 계층 구조 설계
2. **Data-Slot Allocation:** 데이터 바인딩 위치 확정
3. **Component Selection:** A2UI 컴포넌트 선택
4. **A2UI JSON Generation:** JSONL 메시지 생성

### Output
```jsonl
{"createSurface": {"surfaceId": "main_app", "catalogId": "https://a2ui.dev/specification/v0_9/standard_catalog.json"}}

{"updateComponents": {
  "surfaceId": "main_app",
  "components": [
    {"id": "root", "component": "Column", "children": ["header", "content"]},
    {"id": "header", "component": "Text", "text": "# My App"},
    {"id": "content", "component": "List", "iterator": {"path": "/items"}, "child": "item_card"}
  ]
}}

{"updateDataModel": {"surfaceId": "main_app", "path": "/items", "value": []}}
```

**File:** `specs/03_structural_spec.a2ui.json`

### Monitoring Points
- Step 1 완료 시: Root 컴포넌트 및 주요 컨테이너 확인
- Step 2 완료 시: JSON 포인터 경로 검증
- Step 3 완료 시: 컴포넌트 ID 중복 체크
- Step 4 완료 시: A2UI 프로토콜 준수 확인

### Validation
- [ ] `id: "root"` 컴포넌트가 존재하는가?
- [ ] 모든 JSON 포인터가 logic schema 데이터를 참조하는가?
- [ ] 표준 카탈로그 외 커스텀 컴포넌트가 없는가?
- [ ] 색상, 폰트 등 디자인 요소가 포함되지 않았는가?

### Example Usage
```bash
> run-structural-architect --logic-schema specs/03_logic_schema.json

# Progress:
# [1/4] Hierarchy Definition... ✓
# [2/4] Data-Slot Allocation... ✓
# [3/4] Component Selection... ✓
# [4/4] A2UI JSON Generation... ✓

# Output: specs/03_structural_spec.a2ui.json
```

---

## 4. `validate-integration`

### Purpose
Logic Schema와 Structural Spec 간의 일관성 및 정합성을 검증합니다.

### Input
- `specs/03_logic_schema.json`
- `specs/03_structural_spec.a2ui.json`
- `specs/00_entity_dictionary.json`

### Validation Checks

#### 4.1 Data Binding Integrity
- Structural spec의 모든 JSON 포인터 추출
- 각 포인터가 logic schema의 상태 변수를 올바르게 참조하는지 확인
- 예: `{"path": "/searchResults"}` → logic schema에 `searchResults` 존재 확인

#### 4.2 Action Mapping Consistency
- UI 컴포넌트의 모든 `action.event` 추출
- 각 이벤트 이름이 logic schema의 액션과 매칭되는지 확인
- 예: `{"event": {"name": "performSearch"}}` → logic schema에 `performSearch` 액션 확인

#### 4.3 Entity Type Alignment
- 양쪽 스펙에서 참조하는 엔티티 타입 추출
- Entity Dictionary와의 일치성 확인
- 예: `List<Product>` → Entity Dictionary에 `Product` 정의 확인

#### 4.4 Component-State Mapping
- 입력 컴포넌트(TextField, CheckBox 등)의 value 바인딩 검증
- 2-way 바인딩이 가능한 상태인지 확인 (mutable state)

### Output
```json
{
  "status": "valid" | "invalid",
  "summary": {
    "dataBindings": {"total": 15, "valid": 15, "invalid": 0},
    "actionMappings": {"total": 5, "valid": 5, "invalid": 0},
    "entityTypes": {"total": 3, "valid": 3, "invalid": 0}
  },
  "errors": [
    {
      "type": "DataBindingError",
      "message": "Component 'search_input' references undefined state '/unknownField'",
      "location": "structural_spec.a2ui.json:components[3]",
      "suggestion": "Add 'unknownField' to logic_schema.json states"
    }
  ],
  "warnings": [
    {
      "type": "UnusedState",
      "message": "State variable 'tempData' is defined but not used in UI",
      "location": "logic_schema.json:states.tempData"
    }
  ]
}
```

**File:** `specs/validation_report.json`

### Example Usage
```bash
> validate-integration

# Checking data bindings... ✓ 15/15
# Checking action mappings... ✓ 5/5
# Checking entity types... ✓ 3/3
# Checking component-state mapping... ✓

# Result: VALID
# All validations passed successfully.
```

### Error Handling
- **Minor Issues (Warnings):** 리포트에 기록만 하고 계속 진행
- **Critical Issues (Errors):** 해당 Architect에게 수정 요청
- **Max Retry:** 3회 반복 후 사용자에게 에스컬레이션

---

## 5. `assemble-final-output`

### Purpose
모든 스펙 파일을 취합하고 최종 Integration Report를 작성합니다.

### Input
- `specs/00_entity_dictionary.json`
- `specs/01_intent_map.json`
- `specs/03_logic_schema.json`
- `specs/03_structural_spec.a2ui.json`
- `specs/validation_report.json`

### Output Structure

#### 5.1 Specification Package
```
specs/
├── 00_entity_dictionary.json
├── 01_intent_map.json
├── 03_logic_schema.json
├── 03_structural_spec.a2ui.json
└── validation_report.json
```

#### 5.2 Integration Report
```markdown
# Integration Report

## Project Summary
- **Intent Count:** 3
- **Entity Count:** 5
- **State Variables:** 12
- **Actions:** 8
- **UI Components:** 25

## Implemented Intents
1. **SearchProducts**
   - States: searchKeyword, searchResults, isSearching
   - Actions: updateSearchKeyword, performSearch
   - UI: TextField, List, Button

2. **AddToCart**
   - States: cart, selectedProduct
   - Actions: addItem, removeItem
   - UI: Button, Text, Icon

## Data Flow Overview
[Diagram or description of data flow]

## Validation Results
✅ All validations passed
- Data Bindings: 15/15
- Action Mappings: 5/5
- Entity Types: 3/3

## Next Steps
1. Implement ProductService API
2. Add error handling for network failures
3. Consider pagination for search results

## Notes
- Performance: Consider debouncing for search input
- UX: Add loading skeleton for better perceived performance
```

**File:** `specs/INTEGRATION_REPORT.md`

### Example Usage
```bash
> assemble-final-output

# Collecting specifications...
# Generating integration report...
# Creating package structure...

# ✓ Specification package created at specs/
# ✓ Integration report: specs/INTEGRATION_REPORT.md

# Summary:
# - 3 intents implemented
# - 12 state variables defined
# - 25 UI components created
# - All validations passed
```

---

## Command Execution Flow

```
User Request
     ↓
[generate-intent-map]
     ↓
specs/01_intent_map.json
     ↓
[run-logic-architect]
     ↓
specs/03_logic_schema.json
     ↓
[run-structural-architect]
     ↓
specs/03_structural_spec.a2ui.json
     ↓
[validate-integration]
     ↓
specs/validation_report.json
     ↓
[assemble-final-output]
     ↓
Final Specification Package
```

---

## Environment Variables

Commands에서 사용 가능한 환경변수:

| Variable | Description | Default |
|----------|-------------|---------|
| `SPECS_DIR` | 스펙 파일 출력 디렉토리 | `./specs` |
| `A2UI_CATALOG_URL` | A2UI 표준 카탈로그 URL | `https://a2ui.dev/specification/v0_9/standard_catalog.json` |
| `MAX_RETRY` | 검증 실패 시 최대 재시도 횟수 | `3` |
| `VALIDATE_STRICT` | 엄격 검증 모드 (warnings도 error 처리) | `false` |

---

## Error Codes

| Code | Description | Action |
|------|-------------|--------|
| `E001` | Intent map validation failed | Review intent definitions |
| `E002` | Entity not found in dictionary | Add missing entity |
| `E003` | Logic schema validation failed | Check state/action definitions |
| `E004` | A2UI protocol violation | Review component structure |
| `E005` | Data binding mismatch | Align JSON pointers with states |
| `E006` | Action mapping not found | Add action to logic schema |
| `E007` | Entity type inconsistency | Update entity definition |

---

## Best Practices

### 1. Incremental Development
각 커맨드 실행 후 출력물을 검토하고 다음 단계로 진행하세요.

### 2s. Validation First
`validate-integration`을 자주 실행하여 조기에 불일치를 발견하세요.

### 3. Documentation
Integration Report를 팀과 공유하여 구현 가이드로 활용하세요.

---

**Chief Architect는 이 커맨드들을 순차적으로 실행하여 완성된 UI 스펙을 생성합니다.**
