COLOR_GREEN := \033[0;32m
COLOR_BLUE := \033[0;34m
COLOR_RED := \033[0;31m
COLOR_RESET := \033[0m

.PHONY: help bootstrap bs install i generate g build_runner br l10n l snippets s prepare-all pa prepare p

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
	@echo "  prepare-all (pa)    Prepare all packages for release (v=<version>)"
	@echo "  prepare (p)         Prepare a package release (package=<name> v=<version>)"

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
	@echo "$(COLOR_BLUE)cd forui && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"
	@cd forui && dart run build_runner build --delete-conflicting-outputs
	@echo ""
	@echo "$(COLOR_BLUE)cd forui_assets && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"
	@cd forui_assets && dart run build_runner build --delete-conflicting-outputs
	@echo ""
	@echo "$(COLOR_BLUE)cd docs_snippets && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"
	@cd docs_snippets && dart run build_runner build --delete-conflicting-outputs
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
	@if [ -z "$(v)" ]; then \
		echo "$(COLOR_RED)Error: usage: make prepare-all v=<version>$(COLOR_RESET)"; \
		exit 1; \
	fi
	@$(MAKE) prepare package=forui_assets v=$(v)
	@$(MAKE) prepare package=forui v=$(v)
	@$(MAKE) prepare package=forui_hooks v=$(v)
	@echo ""
	@echo "$(COLOR_GREEN)✓ All packages prepared for $(v)$(COLOR_RESET)"
pa: prepare-all

prepare:
	@# Validate inputs
	@if [ -z "$(package)" ] || [ -z "$(v)" ]; then \
		echo "$(COLOR_RED)Error: usage: make prepare package=<forui|forui_assets|forui_hooks> v=<version>$(COLOR_RESET)"; \
		exit 1; \
	fi
	@if [ "$(package)" != "forui" ] && [ "$(package)" != "forui_assets" ] && [ "$(package)" != "forui_hooks" ]; then \
		echo "$(COLOR_RED)Error: pkg must be forui, forui_assets, or forui_hooks$(COLOR_RESET)"; \
		exit 1; \
	fi
	@# Step 1: Validate changelog
	@echo ""
	@echo "$(COLOR_BLUE)Checking changelog for $(package) $(v)$(COLOR_RESET)"
	@if ! grep -q "^## $(v)" "$(package)/CHANGELOG.md"; then \
		echo "$(COLOR_RED)Error: no '## $(v)' entry found in $(package)/CHANGELOG.md$(COLOR_RESET)"; \
		exit 1; \
	fi
	@echo "$(COLOR_GREEN)✓ Changelog entry found$(COLOR_RESET)"
	@# Step 2: Run build_runner and cli generator (forui only)
	@if [ "$(package)" = "forui" ]; then \
		echo ""; \
		echo "$(COLOR_BLUE)cd $(package) && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"; \
		cd $(package) && dart run build_runner build --delete-conflicting-outputs; \
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
	NEW_MAJOR_MINOR=$$(echo "$(v)" | sed 's/\([0-9]*\.[0-9]*\)\..*/\1/'); \
	echo ""; \
	echo "$(COLOR_BLUE)Updating $(package)/pubspec.yaml version to $(v)$(COLOR_RESET)"; \
	sed -i '' 's/^version: .*/version: $(v)/' $(package)/pubspec.yaml; \
	echo "$(COLOR_GREEN)✓ Version updated$(COLOR_RESET)"; \
	if [ "$$OLD_MAJOR_MINOR" != "$$NEW_MAJOR_MINOR" ]; then \
		echo ""; \
		echo "$(COLOR_BLUE)Minor/major version changed ($$OLD_MAJOR_MINOR → $$NEW_MAJOR_MINOR), updating dependents$(COLOR_RESET)"; \
		if [ "$(package)" = "forui_assets" ]; then \
			sed -i '' 's/forui_assets: ^.*/forui_assets: ^$(v)/' forui/pubspec.yaml; \
			echo "  Updated forui/pubspec.yaml"; \
		elif [ "$(package)" = "forui" ]; then \
			sed -i '' 's/forui: ^.*/forui: ^$(v)/' forui_hooks/pubspec.yaml; \
			echo "  Updated forui_hooks/pubspec.yaml"; \
			sed -i '' 's/forui: ^.*/forui: ^$(v)/' forui_internal_gen/pubspec.yaml; \
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
	@echo "$(COLOR_GREEN)✓ Prepare $(package) $(v) prepared$(COLOR_RESET)"
p: prepare
