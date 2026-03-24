---
name: release
description: Prepare, PR, and release a single package
argument-hint: "<package> <version>"
disable-model-invocation: true
---

Release $0 at version $1.

## Step 1: Prepare

Run `make prepare package=$0 v=$1`. If it fails, report the error and stop.

## Step 2: Commit & PR

1. Create a release branch: `git checkout -b release/$0-$1`
2. Stage and commit all changes: `git add -A && git commit -m "Prepare to release $0 $1"`
3. Push and create a PR:
   ```
   git push -u origin release/$0-$1
   gh pr create --title "Prepare to release $0 $1" --body "Prepare to release $0 $1."
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

Run `make release package=$0 v=$1 force=true`.
