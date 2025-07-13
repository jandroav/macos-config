#!/bin/bash

# Pre-write validation hook enforcing optimization principles
FILE_PATH="$1"
CONTENT="$2"

# Log the operation
echo "[$(date)] PRE-WRITE: $FILE_PATH" >> ~/.claude/hooks/hook-log.txt

# Check if creating potentially redundant files
if [[ "$FILE_PATH" == *"hook"* ]] || [[ "$FILE_PATH" == *"Hook"* ]]; then
    # Check for existing similar hooks in the project
    PROJECT_DIR=$(pwd)
    EXISTING_HOOKS=$(find "$PROJECT_DIR" -name "*hook*" -o -name "*Hook*" 2>/dev/null | wc -l)
    
    if [ "$EXISTING_HOOKS" -gt 3 ]; then
        echo "⚠️  WARNING: Found $EXISTING_HOOKS existing hooks. Consider enhancing existing hooks instead of creating new ones."
        echo "   Optimization Principle: Avoid creating redundant hooks with overlapping functionality."
        echo "   Suggestion: Review existing hooks and add computed properties using useMemo."
    fi
fi

# Check for React component anti-patterns
if echo "$CONTENT" | grep -q "useState.*useEffect"; then
    echo "⚠️  WARNING: Detected useState + useEffect pattern."
    echo "   Optimization Principle: Leverage Convex Reactivity - use useQuery instead of manual state management."
    echo "   Suggestion: Replace with useQuery for automatic data updates."
fi

# Check for multiple similar exports
EXPORT_COUNT=$(echo "$CONTENT" | grep -c "export.*function.*use[A-Z]")
if [ "$EXPORT_COUNT" -gt 1 ]; then
    echo "⚠️  WARNING: Multiple custom hooks in one file detected."
    echo "   Optimization Principle: Enhance existing hooks instead of creating multiple similar ones."
    echo "   Suggestion: Consolidate related functionality into a single enhanced hook."
fi

# Check for feature-specific components that could use feature flags
if echo "$CONTENT" | grep -q -E "(Trial|Campaign|Metrics|Offer)" && echo "$CONTENT" | grep -q "component\|Component"; then
    echo "💡 SUGGESTION: Consider using feature flags instead of creating new components."
    echo "   Optimization Principle: Add conditional rendering within existing components."
fi

exit 0