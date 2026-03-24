---
name: release-all
description: Prepare, PR, and release all packages at the same version
argument-hint: "<version>"
disable-model-invocation: true
---

Release all packages (forui_assets, forui, forui_hooks) at version $0.

## Step 1: Prepare

Run `make prepare-all v=$0`. If it fails, report the error and stop.

## Step 2: Commit & PR

1. Create a release branch: `git checkout -b release/$0`
2. Stage and commit all changes: `git add -A && git commit -m "Prepare to release $0"`
3. Push and create a PR:
   ```
   git push -u origin release/$0
   gh pr create --title "Prepare to release $0" --body "Prepare to release forui_assets, forui, and forui_hooks $0."
   ```

## Step 3: Wait for CI

Run `gh pr checks --watch`. If any check fails, report which checks failed and stop.

## Step 4: Merge

Tell me that CI passed and ask for approval to merge. Once I approve, run:
```
gh pr merge --squash --admin --delete-branch
git checkout main && git pull
```

## Step 5: Release

Run `make release-all v=$0 force=true`.
