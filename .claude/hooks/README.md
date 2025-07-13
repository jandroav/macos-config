# Claude Code Global Hooks

This directory contains global hooks that enforce optimization principles across all projects.

## Hook Scripts

### PreToolUse Hooks
- **pre-write-validation.sh**: Validates file creation against optimization principles
- **pre-edit-validation.sh**: Validates edits for potential anti-patterns

### PostToolUse Hooks  
- **post-write-optimization.sh**: Analyzes newly created files for optimization opportunities
- **post-edit-optimization.sh**: Reviews edited files for improvements

### Stop Hooks
- **project-summary.sh**: Generates optimization summary when tasks complete

## Optimization Principles Enforced

1. **Avoid Creating Redundant Hooks**
   - Detects multiple similar custom hooks
   - Suggests consolidation opportunities

2. **Enhance Existing Hooks**
   - Promotes adding computed properties with useMemo
   - Encourages extending existing functionality

3. **Leverage Convex Reactivity**
   - Warns against useState/useEffect patterns
   - Suggests useQuery for data fetching

4. **Feature Flag Integration**
   - Detects hardcoded feature logic
   - Promotes conditional rendering over new components

## Log Files

- **hook-log.txt**: Central log of all hook activity
- Review logs to track optimization suggestions over time

## Configuration

Hooks are configured globally in `~/.claude/settings.json` and apply to all projects.

## Disabling Hooks

To temporarily disable hooks, rename or move the settings.json file:
```bash
mv ~/.claude/settings.json ~/.claude/settings.json.disabled
```