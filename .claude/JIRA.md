# Jira tickets

- Always add the "DevOps" value to the "Components" jira field
- Always select "DevOps Infrastructure Squad" in the Squad jira field
- Ask for the sprint name to be set
- Ask if the ticket needs to be created in the DAT or IO project keys

## Field Mapping Notes

**Important**: Custom field IDs are specific to each Jira instance. The following are the correct field mappings for the Datical Jira instance:

- **Components**: Use standard `components` field with `[{"name": "DevOps"}]`
- **Sprint**: Use `customfield_10007` - requires sprint ID, not name
- **Squad**: Use `customfield_12944` - requires option ID for "DevOps Infrastructure Squad"

**Limitation**: Sprint and Squad fields require specific IDs that can't be easily determined via API. These fields should be set manually in the Jira UI after ticket creation, or the ticket creation should include a note to manually set these fields.

**Recommended approach**: Create the ticket with available fields and include instructions to manually set Sprint and Squad fields.

## Template

The ticket msut follow this template and use bullets for each section content:

## Requirement / User Story (Product Owner)
**As A**
**I Want**
**So That**

## Wireframe / UX (Product Owner)

### INFO, WARNING, and ERROR Conditions

## Security Requirement (Product Owner)

## Documentation Requirements (Product Owner)

## Acceptance Criteria (Product Owner)

## Dependencies (if applicable) (Product Owner (if you know of any) + Developer/QA)


## BRANCH RULES (Developer) 

## Implementation Details (Developer)


## Manual Test Requirements (QA)

## Automated Test Requirements (QA)


## DevOps Requirements (Developer / QA)

## DevOps Implementation (DevOps)