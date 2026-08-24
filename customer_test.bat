@ECHO OFF
REM This file is used by https://github.com/flutter/tests to run forui's tests as a presubmit for the flutter/flutter
REM repository.
REM Changes to this file (and any tests in this repository) are only honored after the commit hash in "forui.test" in
REM that repository has been updated.
REM Code generation happens in customer_test_setup.bat, which the registry runs first.
REM Remember to also update the Posix version (customer_test.sh) when changing this file.

CD forui || EXIT /B 1
CALL flutter analyze --no-fatal-infos || EXIT /B 1
CALL flutter test --exclude-tags golden || EXIT /B 1
