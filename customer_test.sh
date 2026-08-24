#!/bin/sh
# This file is used by https://github.com/flutter/tests to run forui's tests as a presubmit for the flutter/flutter
# repository.
# Changes to this file (and any tests in this repository) are only honored after the commit hash in "forui.test" in
# that repository has been updated.
# Remember to also update the Windows version (customer_test.bat) when changing this file.

set -e

cd forui
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze --no-fatal-infos
flutter test --exclude-tags golden
