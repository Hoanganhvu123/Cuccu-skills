# protect-files.ps1 — PreToolUse hook to block edits to sensitive files
# This hook receives JSON via stdin and blocks modifications to protected files

$Input = [Console]::In.ReadToEnd()
$JsonInput = $Input | ConvertFrom-Json

# Extract file path from tool input
$FilePath = $JsonInput.tool_input.file_path
if (-not $FilePath) {
    $FilePath = $JsonInput.tool_input.path
}

if (-not $FilePath) {
    exit 0  # No file path in input, allow
}

# Protected patterns — NEVER allow AI to edit these
$ProtectedPatterns = @(
    "\.env$",
    "\.env\.local$",
    "\.env\.production$",
    "\.env\.staging$",
    "package-lock\.json$",
    "yarn\.lock$",
    "pnpm-lock\.yaml$",
    "\.git/",
    "node_modules/",
    "__pycache__/",
    "\.claude/settings\.json$",
    "\.claude/settings\.local\.json$",
    "CLAUDE\.md$"
)

foreach ($pattern in $ProtectedPatterns) {
    if ($FilePath -match $pattern) {
        [Console]::Error.WriteLine("BLOCKED: '$FilePath' matches protected pattern '$pattern'. This file should not be modified by AI agents.")
        exit 2  # Exit 2 = block the action
    }
}

exit 0  # Allow the edit
