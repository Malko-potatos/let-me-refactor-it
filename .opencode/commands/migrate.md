# Command: migrate-screen

## Description
Orchestrates the full migration pipeline from a legacy Cordova file to a new Flutter component.

## Execution Steps
1. **Selection**: Ask the user which legacy file to migrate (using `list_legacy_files`).
2. **Mining**: Call `miner-agent` to extract A2UI intent from the selected file and save it using `save_is_spec` as `draft_a2ui.json`.
3. **Architecture**: Call `architect-agent` to refine `draft_a2ui.json` into a formal `final_is.json`.
4. **Audit**: Call `auditor-agent` to verify `final_is.json`. If it fails, loop back to Architect with findings.
5. **Synthesis**: Call `builder-agent` to generate Flutter code from `final_is.json` and save it using `write_flutter_code`.

## Usage
User types: `/migrate-screen ./legacy_src/www/old_logic.js`