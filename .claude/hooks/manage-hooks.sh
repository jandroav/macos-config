#!/bin/bash

# Claude Hooks Management Utility

HOOKS_DIR="$HOME/.claude/hooks"
SETTINGS_FILE="$HOME/.claude/settings.json"
LOG_FILE="$HOME/.claude/hooks/hook-log.txt"

show_help() {
    echo "Claude Hooks Management Utility"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  status      Show current hook status and recent activity"
    echo "  enable      Enable hooks by restoring settings.json"
    echo "  disable     Disable hooks by renaming settings.json"
    echo "  logs        Show recent hook activity logs"
    echo "  clear-logs  Clear the hook activity log"
    echo "  test        Test hook scripts for syntax errors"
    echo "  help        Show this help message"
}

show_status() {
    echo "🔧 Claude Hooks Status"
    echo "----------------------"
    
    if [ -f "$SETTINGS_FILE" ]; then
        echo "✅ Hooks: ENABLED"
        echo "📁 Settings: $SETTINGS_FILE"
    else
        echo "❌ Hooks: DISABLED"
        if [ -f "$SETTINGS_FILE.disabled" ]; then
            echo "📁 Disabled settings: $SETTINGS_FILE.disabled"
        fi
    fi
    
    if [ -f "$LOG_FILE" ]; then
        RECENT_ACTIVITY=$(tail -10 "$LOG_FILE" | wc -l)
        echo "📋 Recent activity: $RECENT_ACTIVITY entries"
    else
        echo "📋 Log file: Not found"
    fi
    
    echo ""
    echo "Hook Scripts:"
    for script in "$HOOKS_DIR"/*.sh; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            echo "  ✅ $(basename "$script")"
        elif [ -f "$script" ]; then
            echo "  ⚠️  $(basename "$script") (not executable)"
        fi
    done
}

enable_hooks() {
    if [ -f "$SETTINGS_FILE.disabled" ]; then
        mv "$SETTINGS_FILE.disabled" "$SETTINGS_FILE"
        echo "✅ Hooks enabled"
    elif [ -f "$SETTINGS_FILE" ]; then
        echo "ℹ️  Hooks already enabled"
    else
        echo "❌ No settings file found to enable"
    fi
}

disable_hooks() {
    if [ -f "$SETTINGS_FILE" ]; then
        mv "$SETTINGS_FILE" "$SETTINGS_FILE.disabled"
        echo "✅ Hooks disabled"
    else
        echo "ℹ️  Hooks already disabled"
    fi
}

show_logs() {
    if [ -f "$LOG_FILE" ]; then
        echo "📋 Recent Hook Activity:"
        echo "------------------------"
        tail -20 "$LOG_FILE"
    else
        echo "📋 No log file found"
    fi
}

clear_logs() {
    if [ -f "$LOG_FILE" ]; then
        > "$LOG_FILE"
        echo "✅ Hook logs cleared"
    else
        echo "ℹ️  No log file to clear"
    fi
}

test_hooks() {
    echo "🧪 Testing Hook Scripts:"
    echo "------------------------"
    
    for script in "$HOOKS_DIR"/*.sh; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            if bash -n "$script" 2>/dev/null; then
                echo "  ✅ $script_name: Syntax OK"
            else
                echo "  ❌ $script_name: Syntax Error"
                bash -n "$script"
            fi
        fi
    done
}

# Main command handling
case "$1" in
    "status")
        show_status
        ;;
    "enable")
        enable_hooks
        ;;
    "disable")
        disable_hooks
        ;;
    "logs")
        show_logs
        ;;
    "clear-logs")
        clear_logs
        ;;
    "test")
        test_hooks
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        if [ -z "$1" ]; then
            show_status
        else
            echo "Unknown command: $1"
            echo "Use '$0 help' for available commands"
            exit 1
        fi
        ;;
esac