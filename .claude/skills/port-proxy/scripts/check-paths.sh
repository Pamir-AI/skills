
#!/bin/bash

# check-paths.sh - Scan project for absolute path issues

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-project>"
    exit 1
fi

PROJECT_PATH="$1"

if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Directory not found: $PROJECT_PATH"
    exit 1
fi

USE_RG=false
if command -v rg >/dev/null 2>&1; then
    USE_RG=true
fi

RG_IGNORE=(--glob '!node_modules/**' --glob '!.git/**' --glob '!dist/**' --glob '!build/**')
GREP_EXCLUDES=(--exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist --exclude-dir=build)

run_search() {
    local description="$1"
    local pattern="$2"
    local glob="$3"
    local extra_filter="$4"
    local results=""

    if $USE_RG; then
        results=$(rg --no-heading --line-number "${RG_IGNORE[@]}" --glob "$glob" "$pattern" "$PROJECT_PATH" 2>/dev/null || true)
    else
        results=$(grep -R --line-number "${GREP_EXCLUDES[@]}" --include "$glob" "$pattern" "$PROJECT_PATH" 2>/dev/null || true)
    fi

    if [ -n "$extra_filter" ] && [ -n "$results" ]; then
        results=$(echo "$results" | grep -i "$extra_filter" || true)
    fi

    if [ -n "$results" ]; then
        echo "⚠️  Found ${description}:"
        echo "$results"
        echo ""
        ISSUES_FOUND=$((ISSUES_FOUND + 1))
    fi
}

echo "🔍 Checking for absolute path issues in: $PROJECT_PATH"
echo ""

ISSUES_FOUND=0

echo "📄 Checking HTML files..."
run_search "absolute href paths" 'href="/' "*.html" ""
run_search "absolute src paths" 'src="/' "*.html" ""

echo "📜 Checking JavaScript files..."
run_search "absolute fetch() paths" "fetch('[/]" "*.js" ""
run_search "potential API base assignments" '= ['"'"'"]/' "*.js" "api"

echo "────────────────────────────────────────"

if [ $ISSUES_FOUND -eq 0 ]; then
    echo "✅ No obvious path issues found!"
else
    echo "⚠️  Found $ISSUES_FOUND potential issue(s)"
    echo ""
    echo "Run fix-paths.sh to automatically fix common patterns:"
    echo "$(dirname "$0")/fix-paths.sh \"$PROJECT_PATH\" --dry-run"
fi
