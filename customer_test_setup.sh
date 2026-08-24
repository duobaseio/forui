#!/bin/sh
# This file is used by https://github.com/flutter/tests to run forui's tests as a presubmit for the flutter/flutter
# repository.
# It runs before the registry's update step (flutter pub get + dart fix --apply) to generate the gitignored
# .design.dart files. Without them, dart fix misjudges casts as unnecessary and breaks the code.
# Remember to also update the Windows version (customer_test_setup.bat) when changing this file.

set -e

cd forui
flutter pub get
dart run build_runner build --delete-conflicting-outputs
