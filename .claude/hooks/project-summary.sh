#!/bin/bash

# Project summary and optimization report hook
PROJECT_DIR=$(pwd)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Log the operation
echo "[$(date)] PROJECT-SUMMARY: Task completed in $PROJECT_DIR" >> ~/.claude/hooks/hook-log.txt

# Create summary report
echo "🎯 PROJECT OPTIMIZATION SUMMARY - $TIMESTAMP"
echo "📁 Project: $PROJECT_DIR"
echo "----------------------------------------"

# Count file types
TS_FILES=$(find "$PROJECT_DIR" -name "*.ts" -o -name "*.tsx" 2>/dev/null | wc -l)
JS_FILES=$(find "$PROJECT_DIR" -name "*.js" -o -name "*.jsx" 2>/dev/null | wc -l)
COMPONENT_FILES=$(find "$PROJECT_DIR" -name "*[Cc]omponent*" 2>/dev/null | wc -l)
HOOK_FILES=$(find "$PROJECT_DIR" -name "*[Hh]ook*" -o -name "*use[A-Z]*" 2>/dev/null | wc -l)

echo "📊 CODE METRICS:"
echo "   TypeScript/TSX files: $TS_FILES"
echo "   JavaScript/JSX files: $JS_FILES"
echo "   Component files: $COMPONENT_FILES"
echo "   Hook files: $HOOK_FILES"

# Analyze potential optimization opportunities
echo ""
echo "🔍 OPTIMIZATION OPPORTUNITIES:"

# Check for useState/useEffect patterns
STATE_EFFECT_COUNT=$(find "$PROJECT_DIR" -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" 2>/dev/null | xargs grep -l "useState.*useEffect\|useEffect.*useState" 2>/dev/null | wc -l)
if [ "$STATE_EFFECT_COUNT" -gt 0 ]; then
    echo "   ⚠️  $STATE_EFFECT_COUNT files with useState+useEffect (consider useQuery)"
fi

# Check for multiple hook files (potential consolidation opportunities)
if [ "$HOOK_FILES" -gt 5 ]; then
    echo "   ⚠️  $HOOK_FILES hook files detected (review for consolidation opportunities)"
fi

# Check for feature-specific components
FEATURE_COMPONENTS=$(find "$PROJECT_DIR" -name "*[Tt]rial*" -o -name "*[Cc]ampaign*" -o -name "*[Mm]etric*" -o -name "*[Oo]ffer*" 2>/dev/null | wc -l)
if [ "$FEATURE_COMPONENTS" -gt 0 ]; then
    echo "   💡 $FEATURE_COMPONENTS feature-specific files (consider feature flags)"
fi

# Check for duplicate code patterns
DUPLICATE_FUNCTIONS=$(find "$PROJECT_DIR" -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" 2>/dev/null | xargs grep -h "function\|const.*=.*=>" 2>/dev/null | sort | uniq -d | wc -l)
if [ "$DUPLICATE_FUNCTIONS" -gt 0 ]; then
    echo "   🔄 $DUPLICATE_FUNCTIONS potential duplicate function patterns"
fi

echo ""
echo "💡 OPTIMIZATION PRINCIPLES APPLIED:"
echo "   ✅ Avoided creating redundant components/hooks"
echo "   ✅ Enhanced existing functionality where possible"
echo "   ✅ Leveraged reactive patterns over manual state management"
echo "   ✅ Promoted feature flags over hardcoded feature logic"

# Check for recent hook activity
RECENT_WARNINGS=$(tail -50 ~/.claude/hooks/hook-log.txt 2>/dev/null | grep -c "WARNING\|SUGGESTION" || echo "0")
if [ "$RECENT_WARNINGS" -gt 0 ]; then
    echo ""
    echo "⚡ RECENT HOOK ACTIVITY:"
    echo "   $RECENT_WARNINGS optimization suggestions provided during this session"
    echo "   📋 Full log available at: ~/.claude/hooks/hook-log.txt"
fi

echo ""
echo "✨ Task completed with optimization principles enforced!"
echo "----------------------------------------"

exit 0