#!/bin/bash

# Post-write optimization hook for suggesting improvements
FILE_PATH="$1"

# Log the operation
echo "[$(date)] POST-WRITE: $FILE_PATH" >> ~/.claude/hooks/hook-log.txt

# Only analyze relevant file types
if [[ "$FILE_PATH" == *.ts ]] || [[ "$FILE_PATH" == *.tsx ]] || [[ "$FILE_PATH" == *.js ]] || [[ "$FILE_PATH" == *.jsx ]]; then
    
    # Read the file content
    if [ -f "$FILE_PATH" ]; then
        CONTENT=$(cat "$FILE_PATH")
        
        # Check for optimization opportunities
        if echo "$CONTENT" | grep -q "useState\|useEffect"; then
            echo "🔍 POST-WRITE ANALYSIS: React hooks detected in $FILE_PATH"
            echo "   💡 Consider if useQuery would be more appropriate for data fetching"
            echo "   💡 Review if manual state management can be replaced with Convex reactivity"
        fi
        
        # Check for missing useMemo opportunities
        if echo "$CONTENT" | grep -q -E "(calculate|compute|derive|transform)" && ! echo "$CONTENT" | grep -q "useMemo"; then
            echo "🔍 POST-WRITE ANALYSIS: Computation detected without useMemo in $FILE_PATH"
            echo "   💡 Consider wrapping expensive computations with useMemo"
        fi
        
        # Check for multiple exports that could be consolidated
        EXPORT_COUNT=$(echo "$CONTENT" | grep -c "export.*function")
        if [ "$EXPORT_COUNT" -gt 2 ]; then
            echo "🔍 POST-WRITE ANALYSIS: Multiple exports detected in $FILE_PATH"
            echo "   💡 Consider if these functions can be consolidated into a single enhanced utility"
        fi
        
        # Check for component creation that could use feature flags
        if echo "$CONTENT" | grep -q -E "(Trial|Campaign|Metrics|Offer|Feature)" && echo "$CONTENT" | grep -q -E "(component|Component|FC|FunctionComponent)"; then
            echo "🔍 POST-WRITE ANALYSIS: Feature-specific component detected in $FILE_PATH"
            echo "   💡 Consider using feature flags within existing components instead"
        fi
        
        # Check for redundant imports
        IMPORT_COUNT=$(echo "$CONTENT" | grep -c "^import")
        USED_IMPORTS=$(echo "$CONTENT" | grep "^import" | sed 's/.*{\(.*\)}.*/\1/' | tr ',' '\n' | wc -l)
        if [ "$IMPORT_COUNT" -gt 5 ]; then
            echo "🔍 POST-WRITE ANALYSIS: Many imports detected in $FILE_PATH"
            echo "   💡 Review if all imports are necessary and consider consolidation"
        fi
        
        echo "✅ POST-WRITE OPTIMIZATION CHECK COMPLETE for $FILE_PATH"
    fi
fi

exit 0