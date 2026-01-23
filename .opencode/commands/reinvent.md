# Command: /reinvent

이 명령은 레거시 코드를 분석하여 새로운 디자인의 Flutter 앱으로 재창조합니다.

1. **Initialization:**
   - `flutter_app` 폴더가 비어있다면 `flutter create .` (shell) 실행.

2. **Phase 1: Extraction (Miner)**
   - `legacy_src` 분석 실행.
   - 산출물: `specs/01_intent_map.json`

3. **Phase 2: Ideation (Muse)**
   - `01_intent_map.json` 읽기.
   - Stitch MCP 활용 및 UX 컨셉 작성.
   - 산출물: `specs/02_ux_concept.md`
   - **Action:** `tool/generate_theme.ts` 실행하여 테마 파일 생성.

4. **Phase 3: Specification (Architect)**
   - `02_ux_concept.md` 읽기.
   - 산출물: `specs/03_ui_spec.a2ui.json`

5. **Phase 4: Construction (Builder)**
   - `03_ui_spec.a2ui.json` 기반으로 `flutter_app/lib` 코드 작성.

6. **Phase 5: Verification (Auditor)**
   - `flutter analyze` 실행 및 리포트 작성.
