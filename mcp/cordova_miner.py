# cordova_mcp.py
from mcp.server.fastmcp import FastMCP
import os
import json

# Initialize FastMCP server
mcp = FastMCP("Legacy-Harness-Tools")

# 1. Tool to list files in the legacy project
@mcp.tool()
def list_legacy_files(path: str = "legacy_src") -> list:
    """Lists all files in the legacy Cordova project directory."""
    files_list = []
    for root, dirs, files in os.walk(path):
        for file in files:
            files_list.append(os.path.join(root, file))
    return files_list

# 2. Tool to read content of a specific legacy file
@mcp.tool()
def read_legacy_file(file_path: str) -> str:
    """Reads the content of a legacy file (HTML, JS, CSS, XML)."""
    with open(file_path, 'r', encoding='utf-8') as f:
        return f.read()

# 3. Tool to save the Intermediate Specification (A2UI/IS)
@mcp.tool()
def save_is_spec(spec_name: str, content_json: str) -> str:
    """
    Saves the generated Intermediate Specification to a JSON file.
    spec_name: e.g., 'login_screen_a2ui.json'
    """
    os.makedirs("specs", exist_ok=True)
    file_path = f"specs/{spec_name}"
    
    # Ensure content is valid JSON
    data = json.loads(content_json)
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    
    return f"Successfully saved specification to {file_path}"

# 4. Tool to read a saved specification
@mcp.tool()
def read_is_spec(spec_name: str) -> str:
    """Reads a previously saved Intermediate Specification JSON."""
    file_path = f"specs/{spec_name}"
    with open(file_path, 'r', encoding='utf-8') as f:
        return f.read()

# 5. Tool to write the final Flutter code
@mcp.tool()
def write_flutter_code(file_path: str, dart_code: str) -> str:
    """Writes the synthesized Flutter/Dart code to the target directory."""
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(dart_code)
    return f"Successfully synthesized code to {file_path}"

if __name__ == "__main__":
    mcp.run()