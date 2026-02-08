Showing lessons filtered by: $ARGUMENTS

**READ:**
Read: docs/learning/lessons.md

**IF TAGS PROVIDED ($ARGUMENTS is not empty):**

Filter lessons by tags matching "$ARGUMENTS" and present:
```
Lessons tagged with: $ARGUMENTS

┌──────┬──────────────┬─────────────────────────────────────┐
│ ID   │ Date         │ Title                               │
├──────┼──────────────┼─────────────────────────────────────┤
│ L001 │ 2024-01-15   │ [Lesson title]                      │
│ L002 │ 2024-01-20   │ [Lesson title]                      │
└──────┴──────────────┴─────────────────────────────────────┘

Total: X lessons found

---

L001: [Title]
Context: [Context]
Lesson: [What we learned]
Tags: [tags]

---

L002: [Title]
...
```

**IF NO TAGS PROVIDED:**

Show all lessons grouped by tag:
```
All Lessons by Category

## Architecture (X lessons)
- L001: [Title]
- L003: [Title]

## Testing (X lessons)
- L002: [Title]

## Performance (X lessons)
- L004: [Title]

Total: X lessons
```

**IF NO LESSONS FOUND:**
```
No lessons found matching "$ARGUMENTS".

Available tags: [list all existing tags]

Use /show-lessons [tag] to filter by tag.
```
