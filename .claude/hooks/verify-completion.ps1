# verify-completion.ps1 — Stop hook to verify task completion before allowing AI to finish
# Returns JSON verdict to stdout

$Input = [Console]::In.ReadToEnd()
$JsonInput = $Input | ConvertFrom-Json

$Cwd = $JsonInput.cwd
if (-not $Cwd) { $Cwd = Get-Location }

$Issues = @()

# Check 1: Are there uncommitted changes? (warn, don't block)
try {
    $GitStatus = git -C $Cwd status --porcelain 2>$null
    if ($GitStatus) {
        $FileCount = ($GitStatus -split "`n").Count
        $Issues += "WARNING: $FileCount uncommitted file(s) detected. Consider committing."
    }
} catch {
    # Not a git repo, skip
}

# Check 2: Look for common TODO/FIXME/HACK markers in recently modified files
try {
    $RecentFiles = git -C $Cwd diff --name-only HEAD~1 2>$null
    if ($RecentFiles) {
        foreach ($file in ($RecentFiles -split "`n")) {
            $fullPath = Join-Path $Cwd $file
            if (Test-Path $fullPath) {
                $content = Get-Content $fullPath -Raw -ErrorAction SilentlyContinue
                if ($content -match "TODO:|FIXME:|HACK:|XXX:") {
                    $Issues += "WARNING: Found TODO/FIXME/HACK markers in $file"
                }
            }
        }
    }
} catch {
    # Git not available, skip
}

# Check 3: Verify no hardcoded secrets in recent changes
try {
    $DiffOutput = git -C $Cwd diff HEAD~1 2>$null
    if ($DiffOutput) {
        $SecretPatterns = @(
            "sk-[a-zA-Z0-9]{20,}",           # OpenAI keys
            "AKIA[A-Z0-9]{16}",               # AWS access keys
            "ghp_[a-zA-Z0-9]{36}",            # GitHub tokens
            "gho_[a-zA-Z0-9]{36}",            # GitHub OAuth
            "password\s*=\s*[`"'][^`"']+[`"']",  # Hardcoded passwords
            "secret\s*=\s*[`"'][^`"']+[`"']"     # Hardcoded secrets
        )
        foreach ($pattern in $SecretPatterns) {
            if ($DiffOutput -match $pattern) {
                $Issues += "CRITICAL: Potential hardcoded secret detected matching pattern: $pattern"
            }
        }
    }
} catch {
    # Git not available, skip
}

# Return results
if ($Issues.Count -gt 0) {
    $CriticalCount = ($Issues | Where-Object { $_ -match "^CRITICAL" }).Count
    $WarningCount = ($Issues | Where-Object { $_ -match "^WARNING" }).Count
    
    $IssueList = $Issues -join "`n  - "
    $Message = "Pre-completion check found $($Issues.Count) issue(s):`n  - $IssueList"
    
    if ($CriticalCount -gt 0) {
        # Block completion for critical issues
        [Console]::Error.WriteLine($Message)
        exit 2
    } else {
        # Warnings only — allow but inject context
        Write-Output $Message
        exit 0
    }
} else {
    # All clear
    exit 0
}
