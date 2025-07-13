#!/bin/bash

# Post-edit optimization hook for suggesting improvements after edits
FILE_PATH="$1"

# Log the operation
echo "[$(date)] POST-EDIT: $FILE_PATH" >> ~/.claude/hooks/hook-log.txt

# Only analyze relevant file types
if [[ "$FILE_PATH" == *.ts ]] || [[ "$FILE_PATH" == *.tsx ]] || [[ "$FILE_PATH" == *.js ]] || [[ "$FILE_PATH" == *.jsx ]]; then
    
    if [ -f "$FILE_PATH" ]; then
        CONTENT=$(cat "$FILE_PATH")
        
        # Check if file now has multiple similar functions that could be consolidated
        FUNCTION_COUNT=$(echo "$CONTENT" | grep -c "function\|const.*=.*=>")
        if [ "$FUNCTION_COUNT" -gt 3 ]; then
            echo "🔍 POST-EDIT ANALYSIS: Multiple functions detected after edit in $FILE_PATH"
            echo "   💡 Review if functions can be consolidated or extracted to utilities"
        fi
        
        # Check for state management patterns that could use Convex
        if echo "$CONTENT" | grep -q "useState.*useEffect.*fetch\|fetch.*useState.*useEffect"; then
            echo "🔍 POST-EDIT ANALYSIS: Data fetching with manual state management in $FILE_PATH"
            echo "   💡 Consider replacing with useQuery for automatic reactivity"
        fi
        
        # Check for missing memoization after complex computations
        if echo "$CONTENT" | grep -q -E "(map.*filter|reduce.*map|filter.*reduce)" && ! echo "$CONTENT" | grep -q "useMemo"; then
            echo "🔍 POST-EDIT ANALYSIS: Complex array operations without memoization in $FILE_PATH"
            echo "   💡 Consider wrapping with useMemo for performance"
        fi
        
        # Check for hardcoded feature logic that could use feature flags
        if echo "$CONTENT" | grep -q -E "(if.*trial|if.*premium|if.*beta)" && ! echo "$CONTENT" | grep -q "featureFlag\|feature_flag"; then
            echo "🔍 POST-EDIT ANALYSIS: Hardcoded feature logic detected in $FILE_PATH"
            echo "   💡 Consider using feature flags for better maintainability"
        fi
        
        # Check for duplicate code patterns
        DUPLICATE_LINES=$(echo "$CONTENT" | sort | uniq -d | wc -l)
        if [ "$DUPLICATE_LINES" -gt 2 ]; then
            echo "🔍 POST-EDIT ANALYSIS: Potential duplicate code patterns in $FILE_PATH"
            echo "   💡 Review for opportunities to extract common functionality"
        fi
        
        echo "✅ POST-EDIT OPTIMIZATION CHECK COMPLETE for $FILE_PATH"
    fi
fi

exit 0