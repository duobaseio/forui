## Updating Test Goldens

To update test goldens:
1. Temporarily copy the contents of `source` to `forui/lib/src/widgets/<file name>.dart` where `<file name>` is derived 
   from the `source`'s `part` directive, e.g. `part 'example.design.dart';` means the file name is `example.dart`.
2. Run `dart run build_runner build --delete-conflicting-outputs` to generate the new golden file in `forui/lib/src/widgets`.
  The golden file name is derived from the `part` directive, e.g. `part 'example.design.dart';` means the golden file name 
  is `example.design.dart`.
3. Copy the contents of the golden file and replace the `golden` variable in the test.
4. Delete the temporary files created in step 1 and 2.

