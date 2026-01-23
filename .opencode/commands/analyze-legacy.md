# Command: /analyze-legacy

## Description
레거시 소스 코드를 대상으로 'Recon Squad' 파이프라인(Scout, Profiler, Miner)을 가동하여 아키텍처 지도, 엔티티 사전, NLU 기반 인텐트 맵을 생성합니다.

## Execution Steps
1. **Target Selection**: 사용자에게 분석할 레거시 디렉토리 또는 파일을 선택받습니다. (기본값: `./legacy_src`)
2. **Phase 1: Architecture Mapping (Scout)**
   - `scout-agent`를 호출하여 전체 구조를 분석합니다.
   - **Action**: `dependency-tracer` 스킬을 사용하여 호출 그래프를 생성합니다.
   - **Output**: 결과를 `specs/00_recon_report.md`에 저장합니다.
3. **Phase 2: Data Profiling (Profiler)**
   - `specs/00_recon_report.md`를 읽어 `profiler-agent`에 전달합니다.
   - **Action**: `type-converter` 스킬을 사용하여 레거시 타입을 표준화합니다.
   - **Output**: 결과를 `specs/00_entity_dictionary.json`에 저장합니다.
4. **Phase 3: Logic Mining (Miner)**
   - `miner-agent`가 앞선 두 산출물을 바탕으로 로직을 추출합니다.
   - **Action**: `logic-to-pseudo-code` 스킬로 로직을 정제하고, `validate-intent-schema`로 최종 검증합니다.
   - **Output**: 최종 인텐트 맵을 `specs/01_intent_map.json`에 저장합니다.

## Usage
- `/analyze-legacy` : 전체 `legacy_src` 분석
- `/analyze-legacy ./legacy_src/modules/auth` : 특정 모듈 집중 분석