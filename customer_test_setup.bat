@ECHO OFF
REM This file is used by https://github.com/flutter/tests to run forui's tests as a presubmit for the flutter/flutter
REM repository.
REM It runs before the registry's update step (flutter pub get + dart fix --apply) to generate the gitignored
REM .design.dart files. Without them, dart fix misjudges casts as unnecessary and breaks the code.
REM Remember to also update the Posix version (customer_test_setup.sh) when changing this file.

CD forui || EXIT /B 1
CALL flutter pub get || EXIT /B 1
CALL dart run build_runner build --delete-conflicting-outputs || EXIT /B 1
