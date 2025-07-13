#!/bin/bash

# Pre-edit validation hook enforcing optimization principles
FILE_PATH="$1"
OLD_STRING="$2"
NEW_STRING="$3"

# Log the operation
echo "[$(date)] PRE-EDIT: $FILE_PATH" >> ~/.claude/hooks/hook-log.txt

# Check if adding useState/useEffect when useQuery might be better
if echo "$NEW_STRING" | grep -q "useState\|useEffect" && [[ "$FILE_PATH" == *".tsx" ]] || [[ "$FILE_PATH" == *".ts" ]]; then
    echo "⚠️  WARNING: Adding useState/useEffect pattern."
    echo "   Optimization Principle: Leverage Convex Reactivity."
    echo "   Suggestion: Consider if useQuery would be more appropriate for data fetching."
fi

# Check if adding multiple similar functions
if echo "$NEW_STRING" | grep -q "export.*function.*use[A-Z]" && echo "$OLD_STRING" | grep -q "export.*function.*use[A-Z]"; then
    echo "⚠️  WARNING: Adding another custom hook to a file that already has one."
    echo "   Optimization Principle: Enhance existing hooks instead of creating multiple similar ones."
    echo "   Suggestion: Consider enhancing the existing hook with useMemo for computed properties."
fi

# Check for manual data synchronization
if echo "$NEW_STRING" | grep -q -E "(sync|synchronize|update.*state)" && echo "$NEW_STRING" | grep -q "useEffect"; then
    echo "⚠️  WARNING: Manual data synchronization detected."
    echo "   Optimization Principle: Let Convex handle data updates automatically."
    echo "   Suggestion: Use reactive queries instead of manual synchronization."
fi

# Suggest useMemo for computed properties
if echo "$NEW_STRING" | grep -q -E "(calculate|compute|derive)" && ! echo "$NEW_STRING" | grep -q "useMemo"; then
    echo "💡 SUGGESTION: Consider using useMemo for computed properties."
    echo "   Optimization Principle: Enhance existing hooks with computed properties using useMemo."
fi

exit 0