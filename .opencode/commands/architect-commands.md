# Command: /generate-ui-spec

## Description
사용자의 요구사항 또는 인텐트 맵을 바탕으로 'Architect Squad' 파이프라인을 가동하여 비즈니스 로직 스펙, UI 구조 스펙 및 최종 통합 리포트를 생성합니다.

## Execution Steps

### 1. Phase 1: Intent Mapping (Intent-Mapper)
- 사용자의 자연어 요청을 구조화된 인텐트 맵으로 변환합니다.
- **Action**: `validate-intent-schema` 스킬을 사용하여 인텐트의 정합성을 검증합니다.
- **Output**: `specs/01_intent_map.json`

### 2. Phase 2: Logic Design (Logic Architect)
- 인텐트 맵을 분석하여 상태 관리 및 비즈니스 로직 스키마를 설계합니다.
- **Action**: `logic-state-mapper` 스킬을 사용하여 상태 변수와 액션을 정의합니다.
- **Output**: `specs/03_logic_schema.json`

### 3. Phase 3: Structural Design (Structural Architect)
- 로직 스키마를 바탕으로 A2UI v0.9 규격의 UI 계층 구조를 생성합니다.
- **Action**: `type-converter`를 참조하여 데이터 바인딩 경로를 확정합니다.
- **Output**: `specs/03_structural_spec.a2ui.json`

### 4. Phase 4: Integration Validation (Auditor)
- 생성된 로직과 UI 스펙 간의 데이터 바인딩 및 액션 매핑 일관성을 검증합니다.
- **Action**: `validate-integration` 커맨드로 스펙 간 정합성을 체크합니다.
- **Output**: `specs/validation_report.json`

### 5. Phase 5: Final Assembly (Chief Architect)
- 모든 산출물을 취합하고 구현 가이드를 포함한 통합 리포트를 작성합니다.
- **Action**: `assemble-final-output` 커맨드를 실행합니다.
- **Output**: `specs/INTEGRATION_REPORT.md`

## Usage
- `/generate-ui-spec` : `specs/01_intent_map.json`이 존재할 경우 즉시 파이프라인 시작
- `/generate-ui-spec --from-request "사용자가 제품을 검색하고 장바구니에 추가"` : 자연어로부터 인텐트 생성 후 시작

## Environment Variables
- `MAX_RETRY`: 검증 실패 시 재시도 횟수 (기본값: 3)
- `VALIDATE_STRICT`: true 설정 시 경고(warning) 발생 시에도 중단