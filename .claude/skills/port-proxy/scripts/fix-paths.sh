#!/bin/bash

# fix-paths.sh - Automatically fix absolute path issues for reverse proxy

set -euo pipefail

usage() {
    cat <<'EOF'
Usage: fix-paths.sh <path-to-project> [--dry-run]

Options:
  --dry-run      Show what would be changed without modifying files
EOF
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

DRY_RUN=false
PROJECT_PATH=""

while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run)
            DRY_RUN=true
            ;;
        -*)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
        *)
            if [ -z "$PROJECT_PATH" ]; then
                PROJECT_PATH="$1"
            else
                echo "Error: multiple project paths provided"
                usage
                exit 1
            fi
            ;;
    esac
    shift
done

if [ -z "$PROJECT_PATH" ]; then
    echo "Error: project path is required"
    usage
    exit 1
fi

if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Directory not found: $PROJECT_PATH"
    exit 1
fi

if $DRY_RUN; then
    echo "🔍 DRY RUN MODE - No files will be modified"
    echo ""
fi

echo "🔧 Fixing absolute paths in: $PROJECT_PATH"
echo ""

CHANGES_MADE=0

fix_file() {
    local file="$1"
    local pattern="$2"
    local replacement="$3"
    local description="$4"

    if grep -q "$pattern" "$file" 2>/dev/null; then
        echo "  📝 $file - $description"
        if ! $DRY_RUN; then
            sed -i "s|$pattern|$replacement|g" "$file"
        fi
        CHANGES_MADE=$((CHANGES_MADE + 1))
    fi
}

find_files() {
    local ext="$1"
    find "$PROJECT_PATH" \( -name node_modules -o -name .git -o -name dist -o -name build \) -prune -o -type f -name "$ext" -print0
}

echo "📄 Fixing HTML files..."
while IFS= read -r -d '' file; do
    fix_file "$file" 'href="/' 'href="' "Fix absolute href paths"
    fix_file "$file" 'src="/' 'src="' "Fix absolute src paths"
done < <(find_files "*.html")

echo ""
echo "📜 Fixing JavaScript files..."
while IFS= read -r -d '' file; do
    fix_file "$file" "= '/" "= '" "Fix absolute string assignments"
    fix_file "$file" '= "/' '= "' "Fix absolute string assignments"
    fix_file "$file" "fetch('/" "fetch('" "Fix absolute fetch paths"
    fix_file "$file" 'fetch("/' 'fetch("' "Fix absolute fetch paths"
done < <(find_files "*.js")

echo ""
echo "────────────────────────────────────────"

if [ $CHANGES_MADE -eq 0 ]; then
    echo "✅ No changes needed - files already use relative paths!"
else
    if $DRY_RUN; then
        echo "ℹ️  Would fix $CHANGES_MADE file(s)"
        echo ""
        echo "Run without --dry-run to apply changes:"
        echo "  $(dirname "$0")/fix-paths.sh \"$PROJECT_PATH\""
    else
        echo "✅ Fixed $CHANGES_MADE file(s)!"
        echo ""
        echo "Next steps:"
        echo "  1. Test locally: http://localhost:{PORT}/"
        echo "  2. Test via proxy: https://{subdomain}.devices.pamir.ai/distiller/proxy/{PORT}/"
        echo "  3. Hard refresh browser (Ctrl+Shift+R)"
    fi
fi
