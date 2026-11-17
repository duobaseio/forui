---
name: bump-flutter-tests
description: Bump the forui commit pinned in the flutter/tests customer test registry
argument-hint: "<version | commit sha>"
---

Bump `registry/forui.test` in flutter/tests to the forui commit for `$0`. `$0` is either a release version (resolves the
tag `forui/$0`) or a commit SHA on `main`.

The fork lives at `../tests` (`origin` = Pante/tests, `upstream` = flutter/tests). Never add `Co-Authored-By` or
`Generated with` lines to commits or the PR body: the Google CLA bot rejects them.

## Step 1: Resolve the commit

```
cd forui && git fetch origin --tags
git rev-parse forui/$0^{commit}          # if $0 is a version
git rev-parse $0^{commit}                # if $0 is a commit sha
git merge-base --is-ancestor <new sha> origin/main
git diff --stat <old sha> <new sha> -- customer_test.sh customer_test.bat customer_test_setup.sh customer_test_setup.bat
```

Stop if the tag or commit does not exist, or the commit is not on `origin/main`. `<old sha>` is the `checkout` line in
`registry/forui.test` (or `registry/forui.test.disabled`) on `upstream/main`, not the fork's branch. If the diff is
non-empty, mention the script changes in the PR body.

## Step 2: Update the registry

```
cd ../tests && git fetch upstream
```

- No open bump PR: `git checkout -B forui-update-hash upstream/main`.
- Open bump PR (`gh pr list -R flutter/tests --author Pante --search "forui"`): `git checkout forui-update-hash` and
  amend its single commit instead of adding a new one.

If upstream disabled the test (`registry/forui.test.disabled`), `git mv` it back to `registry/forui.test` and prefix the
commit and PR titles with `Re-enable forui.test and `.

```
sed -i '' 's/<old sha>/<new sha>/' registry/forui.test
git add registry/forui.test && git commit -m "Update git hash for duobaseio/forui"   # or --amend --no-edit
git push -u origin forui-update-hash --force-with-lease
```

## Step 3: Wait for CI

Find the main-branch "Forui Build" run for `<new sha>` and wait for it:

```
gh run list -R duobaseio/forui --commit <new sha> --workflow "Forui Build" --branch main \
  --json databaseId -q '.[0].databaseId'
gh run watch -R duobaseio/forui <run id> --exit-status
gh run view -R duobaseio/forui <run id> --json jobs -q '.jobs[] | select(.name == "Build & test (main channel)") | .url'
```

If the run fails, report which jobs failed and stop. Do not open or edit the PR with a red job.

## Step 4: Open or update the PR

Create with `gh pr create -R flutter/tests --base main --head Pante:forui-update-hash` and the title
`Update git hash for duobaseio/forui`, or `gh pr edit <number> -R flutter/tests` if one is open. Link any flutter/flutter
issue the bump fixes with `Part of <issue url>` and tick the issue checkbox. Body:

```
Updates the pinned commit for `registry/forui.test` from `<old sha (8)>` to [`<new sha (8)>`](https://github.com/duobaseio/forui/commit/<new sha>), the commit on `duobaseio/forui` main <tagged `$0` | that <one-line summary>>.

- The [main channel CI job](<job url>) for this commit passes.
- The customer test scripts (`customer_test_setup.*`, `customer_test.*`) are unchanged since the previously pinned commit.

## Pre-launch Checklist

- [x] I read the [Contributor Guide] and followed the process outlined there for submitting PRs.
- [x] I read the [Tree Hygiene] wiki page, which explains my responsibilities.
- [x] I read the [Flutter Style Guide] _recently_, and have followed its advice.
- [x] I signed the [CLA].
- [ ] I listed at least one issue that this PR fixes in the description above.
- [ ] I updated/added relevant documentation (doc comments with `///`).
- [ ] I added new tests to check the change I am making, or this PR is [test-exempt].
- [x] All existing and new tests are passing.

[Contributor Guide]: https://github.com/flutter/flutter/blob/main/docs/contributing/Tree-hygiene.md#overview
[Tree Hygiene]: https://github.com/flutter/flutter/blob/main/docs/contributing/Tree-hygiene.md
[test-exempt]: https://github.com/flutter/flutter/blob/main/docs/contributing/Tree-hygiene.md#tests
[Flutter Style Guide]: https://github.com/flutter/flutter/blob/main/docs/contributing/Style-guide-for-Flutter-repo.md
[CLA]: https://cla.developers.google.com/
```

Report the PR URL.
