COLOR_GREEN := \033[0;32m
COLOR_BLUE := \033[0;34m
COLOR_RED := \033[0;31m
COLOR_RESET := \033[0m

.PHONY: help bootstrap bs install i generate g build_runner br l10n l snippets s prepare-all pa prepare p release-all ra release r

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  bootstrap (bs)      Install dependencies and generate code"
	@echo "  install (i)         Install dependencies"
	@echo "  generate (g)        Generate all code (build_runner and l10n)"
	@echo "  build_runner (br)   Run build_runner"
	@echo "  l10n (l)            Generate localization files"
	@echo "  snippets (s)        Generate snippet JSON files"
	@echo "  prepare-all (pa)    Prepare all packages for release (version=<version>)"
	@echo "  prepare (p)         Prepare a package release (package=<name> version=<version>)"
	@echo "  release-all (ra)    Tag and release all packages (version=<version>)"
	@echo "  release (r)         Tag and create GitHub release (package=<name> version=<version>)"

bootstrap: install generate
	@echo ""
	@echo "$(COLOR_GREEN)✓ Bootstrap complete$(COLOR_RESET)"
bs: bootstrap

install:
	@echo ""
	@echo "$(COLOR_BLUE)flutter pub get$(COLOR_RESET)"
	@flutter pub get
	@echo ""
	@echo "$(COLOR_GREEN)✓ Install complete$(COLOR_RESET)"
i: install

generate: build_runner l10n snippets
	@echo ""
	@echo "$(COLOR_GREEN)✓ Generate complete$(COLOR_RESET)"
g: generate

build_runner:
	@echo ""
	@echo "$(COLOR_BLUE)cd forui && dart run build_runner build$(COLOR_RESET)"
	@cd forui && dart run build_runner build
	@echo ""
	@echo "$(COLOR_BLUE)cd forui_assets && dart run build_runner build$(COLOR_RESET)"
	@cd forui_assets && dart run build_runner build
	@echo ""
	@echo "$(COLOR_BLUE)cd docs_snippets && dart run build_runner build$(COLOR_RESET)"
	@cd docs_snippets && dart run build_runner build
	@echo ""
	@echo "$(COLOR_GREEN)✓ Build runner complete$(COLOR_RESET)"
br: build_runner

l10n:
	@echo ""
	@echo "$(COLOR_BLUE)cd forui && flutter gen-l10n$(COLOR_RESET)"
	@cd forui && flutter gen-l10n
	@echo "$(COLOR_GREEN)✓ l10n complete$(COLOR_RESET)"
l: l10n

snippets:
	@echo ""
	@echo "$(COLOR_BLUE)cd docs_snippets && dart run tool/snippet_generator/main.dart$(COLOR_RESET)"
	@cd docs_snippets && dart run tool/snippet_generator/main.dart
	@echo "$(COLOR_GREEN)✓ Snippets complete$(COLOR_RESET)"
s: snippets

prepare-all:
	@if [ -z "$(version)" ]; then \
		echo "$(COLOR_RED)Error: usage: make prepare-all version=<version>$(COLOR_RESET)"; \
		exit 1; \
	fi
	@$(MAKE) prepare package=forui_assets version=$(version)
	@$(MAKE) prepare package=forui version=$(version)
	@$(MAKE) prepare package=forui_hooks version=$(version)
	@echo ""
	@echo "$(COLOR_GREEN)✓ All packages prepared for $(version)$(COLOR_RESET)"
pa: prepare-all

prepare:
	@# Validate inputs
	@if [ -z "$(package)" ] || [ -z "$(version)" ]; then \
		echo "$(COLOR_RED)Error: usage: make prepare package=<forui|forui_assets|forui_hooks> version=<version>$(COLOR_RESET)"; \
		exit 1; \
	fi
	@if [ "$(package)" != "forui" ] && [ "$(package)" != "forui_assets" ] && [ "$(package)" != "forui_hooks" ]; then \
		echo "$(COLOR_RED)Error: package must be forui, forui_assets, or forui_hooks$(COLOR_RESET)"; \
		exit 1; \
	fi
	@# Step 1: Validate changelog
	@echo ""
	@echo "$(COLOR_BLUE)Checking changelog for $(package) $(version)$(COLOR_RESET)"
	@if ! grep -q "^## $(version)" "$(package)/CHANGELOG.md"; then \
		echo "$(COLOR_RED)Error: no '## $(version)' entry found in $(package)/CHANGELOG.md$(COLOR_RESET)"; \
		exit 1; \
	fi
	@if grep -q "^## $(version) " "$(package)/CHANGELOG.md"; then \
		SUFFIX=$$(grep "^## $(version) " "$(package)/CHANGELOG.md" | head -1 | sed 's/^## $(version) //'); \
		echo "Removing suffix '$$SUFFIX' from changelog heading"; \
		sed -i '' 's/^## $(version) .*/## $(version)/' "$(package)/CHANGELOG.md"; \
	fi
	@echo "$(COLOR_GREEN)✓ Changelog entry found$(COLOR_RESET)"
	@# Step 2: Run build_runner and cli generator (forui only)
	@if [ "$(package)" = "forui" ]; then \
		echo ""; \
		echo "$(COLOR_BLUE)cd $(package) && dart run build_runner build$(COLOR_RESET)"; \
		cd $(package) && dart run build_runner build; \
		echo "$(COLOR_GREEN)✓ Build runner complete$(COLOR_RESET)"; \
		echo ""; \
		echo "$(COLOR_BLUE)cd $(package) && dart run tool/cli_generator/main.dart$(COLOR_RESET)"; \
		cd $(package) && dart run tool/cli_generator/main.dart; \
		echo "$(COLOR_GREEN)✓ CLI generator complete$(COLOR_RESET)"; \
	fi
	@# Step 3: Analyze
	@echo ""
	@echo "$(COLOR_BLUE)cd $(package) && flutter analyze$(COLOR_RESET)"
	@cd $(package) && flutter analyze
	@echo "$(COLOR_GREEN)✓ Analysis passed$(COLOR_RESET)"
	@# Step 4 & 5: Update own version and dependent pubspecs
	@OLD_VERSION=$$(grep '^version: ' $(package)/pubspec.yaml | head -1 | sed 's/version: //'); \
	OLD_MAJOR_MINOR=$$(echo "$$OLD_VERSION" | sed 's/\([0-9]*\.[0-9]*\)\..*/\1/'); \
	NEW_MAJOR_MINOR=$$(echo "$(version)" | sed 's/\([0-9]*\.[0-9]*\)\..*/\1/'); \
	echo ""; \
	echo "$(COLOR_BLUE)Updating $(package)/pubspec.yaml version to $(version)$(COLOR_RESET)"; \
	sed -i '' 's/^version: .*/version: $(version)/' $(package)/pubspec.yaml; \
	echo "$(COLOR_GREEN)✓ Version updated$(COLOR_RESET)"; \
	if [ "$$OLD_MAJOR_MINOR" != "$$NEW_MAJOR_MINOR" ]; then \
		echo ""; \
		echo "$(COLOR_BLUE)Minor/major version changed ($$OLD_MAJOR_MINOR → $$NEW_MAJOR_MINOR), updating dependents$(COLOR_RESET)"; \
		if [ "$(package)" = "forui_assets" ]; then \
			sed -i '' 's/forui_assets: ^.*/forui_assets: ^$(version)/' forui/pubspec.yaml; \
			echo "  Updated forui/pubspec.yaml"; \
		elif [ "$(package)" = "forui" ]; then \
			sed -i '' 's/forui: ^.*/forui: ^$(version)/' forui_hooks/pubspec.yaml; \
			echo "  Updated forui_hooks/pubspec.yaml"; \
			sed -i '' 's/forui: ^.*/forui: ^$(version)/' forui_internal_gen/pubspec.yaml; \
			echo "  Updated forui_internal_gen/pubspec.yaml"; \
		fi; \
		echo "$(COLOR_GREEN)✓ Dependents updated$(COLOR_RESET)"; \
	else \
		echo ""; \
		echo "Patch release — no dependent pubspec updates needed"; \
	fi
	@# Step 6: Verify workspace resolution
	@echo ""
	@echo "$(COLOR_BLUE)dart pub get$(COLOR_RESET)"
	@dart pub get
	@echo ""
	@echo "$(COLOR_GREEN)✓ Prepare $(package) $(version) prepared$(COLOR_RESET)"
p: prepare

release-all:
	@if [ -z "$(version)" ]; then \
		echo "$(COLOR_RED)Error: usage: make release-all version=<version>$(COLOR_RESET)"; \
		exit 1; \
	fi
	@$(MAKE) release package=forui_assets version=$(version)
	@$(MAKE) release package=forui version=$(version)
	@$(MAKE) release package=forui_hooks version=$(version)
	@echo ""
	@echo "$(COLOR_GREEN)✓ All packages released for $(version)$(COLOR_RESET)"
ra: release-all

release:
	@# Validate inputs
	@if [ -z "$(package)" ] || [ -z "$(version)" ]; then \
		echo "$(COLOR_RED)Error: usage: make release package=<forui|forui_assets|forui_hooks> version=<version>$(COLOR_RESET)"; \
		exit 1; \
	fi
	@if [ "$(package)" != "forui" ] && [ "$(package)" != "forui_assets" ] && [ "$(package)" != "forui_hooks" ]; then \
		echo "$(COLOR_RED)Error: package must be forui, forui_assets, or forui_hooks$(COLOR_RESET)"; \
		exit 1; \
	fi
	@# Step 1: Validate changelog
	@echo ""
	@echo "$(COLOR_BLUE)Checking changelog for $(package) $(version)$(COLOR_RESET)"
	@if ! grep -q "^## $(version)" "$(package)/CHANGELOG.md"; then \
		echo "$(COLOR_RED)Error: no '## $(version)' entry found in $(package)/CHANGELOG.md$(COLOR_RESET)"; \
		exit 1; \
	fi
	@echo "$(COLOR_GREEN)✓ Changelog entry found$(COLOR_RESET)"
	@# Step 2: Validate HEAD is on main
	@echo ""
	@echo "$(COLOR_BLUE)Checking HEAD is on main$(COLOR_RESET)"
	@git fetch origin main --quiet
	@if ! git merge-base --is-ancestor HEAD origin/main; then \
		echo "$(COLOR_RED)Error: HEAD must be a commit on origin/main (ancestor of or equal to origin/main)$(COLOR_RESET)"; \
		exit 1; \
	fi
	@echo "$(COLOR_GREEN)✓ HEAD is on origin/main$(COLOR_RESET)"
	@# Step 3: Extract changelog, tag, and create release
	@PREV_TAG=$$(git tag -l '$(package)/*' --sort=-v:refname | grep -v '^$(package)/$(version)$$' | head -1); \
	NOTES=$$(sed -n '/^## $(version)/,/^## /{/^## $(version)/d;/^## /d;p;}' "$(package)/CHANGELOG.md" | sed '1{/^$$/d;}' | sed '$${/^$$/d;}'); \
	TITLE=$$(echo "$(package)" | tr '_' ' ' | awk '{for(i=1;i<=NF;i++) $$i=toupper(substr($$i,1,1)) substr($$i,2)}1'); \
	TITLE="$$TITLE $(version)"; \
	echo ""; \
	echo "Title:        $$TITLE"; \
	echo "Tag:          $(package)/$(version)"; \
	if [ -n "$$PREV_TAG" ]; then \
		echo "Previous tag: $$PREV_TAG"; \
	else \
		echo "Previous tag: (none)"; \
	fi; \
	echo ""; \
	echo "--- Release notes ---"; \
	echo "$$NOTES"; \
	echo "--- End release notes ---"; \
	echo ""; \
	if [ "$(force)" != "true" ]; then \
		printf "Proceed? [y/N] "; \
		read CONFIRM; \
		if [ "$$CONFIRM" != "y" ] && [ "$$CONFIRM" != "Y" ]; then \
			echo "Aborted."; \
			exit 1; \
		fi; \
	fi; \
	echo ""; \
	echo "$(COLOR_BLUE)Creating tag $(package)/$(version)$(COLOR_RESET)"; \
	git tag "$(package)/$(version)"; \
	echo "$(COLOR_GREEN)✓ Tag created$(COLOR_RESET)"; \
	echo ""; \
	echo "$(COLOR_BLUE)Pushing tag $(package)/$(version)$(COLOR_RESET)"; \
	git push origin "$(package)/$(version)"; \
	echo "$(COLOR_GREEN)✓ Tag pushed$(COLOR_RESET)"; \
	echo ""; \
	echo "$(COLOR_BLUE)Creating GitHub release: $$TITLE$(COLOR_RESET)"; \
	if [ -n "$$PREV_TAG" ]; then \
		gh release create "$(package)/$(version)" --title "$$TITLE" --notes "$$NOTES" --notes-start-tag "$$PREV_TAG"; \
	else \
		gh release create "$(package)/$(version)" --title "$$TITLE" --notes "$$NOTES"; \
	fi; \
	echo "$(COLOR_GREEN)✓ Release $(package)/$(version) created$(COLOR_RESET)"
r: release
