I'm resuming the most recent paused work.

**FIND LAST PAUSED FEATURE:**
1. Read: docs/product-system.md
2. Find features with status "Paused"
3. If multiple paused features, show list and ask which one

**IF ONE PAUSED FEATURE:**
Automatically continue with that feature using the /continue process.

**IF MULTIPLE PAUSED FEATURES:**
```
Multiple paused features found:

1. [FEAT-ID]: [Title] - Paused at Phase X
2. [FEAT-ID]: [Title] - Paused at Phase Y

Which feature would you like to resume?
```

**IF NO PAUSED FEATURES:**
```
No paused features found.

Use /deliver [feature] to start new work, or
Use /list-features to see all features.
```
