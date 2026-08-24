@ECHO OFF
REM This file is used by https://github.com/flutter/tests to run forui's tests as a presubmit for the flutter/flutter
REM repository.
REM Changes to this file (and any tests in this repository) are only honored after the commit hash in "forui.test" in
REM that repository has been updated.
REM Remember to also update the Posix version (customer_testing.sh) when changing this file.

CD forui || EXIT /B 1
CALL flutter pub get || EXIT /B 1
CALL dart run build_runner build --delete-conflicting-outputs || EXIT /B 1
CALL flutter analyze --no-fatal-infos || EXIT /B 1
CALL flutter test --exclude-tags golden || EXIT /B 1
