# Command: /build-app

## Execution Steps
1. **Phase 1: Readiness Check (Site Engineer)**
   - `flutter_app` 존재 여부 확인 및 `dart-mcp` 초기화.
2. **Phase 2: Blueprint Analysis (Lead)**
   - `specs/00`~`05` 파일을 모두 읽고 아키텍처 전략 수립.
3. **Phase 3: Core Coding (Artisan)**
   - Domain → Data → Presentation 순으로 코드 생성.
4. **Phase 4: Final Polish (Lead)**
   - 컴파일 오류 체크 및 `DESIGN.md` 준수 여부 최종 확인.