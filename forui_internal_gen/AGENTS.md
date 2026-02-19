## Project Structure

```
forui_internal_gen/
├── lib/
│   ├── forui_internal_gen.dart           # Public API barrel export
│   └── src/
│       ├── control_generator.dart        # Generator for .control.dart files (widget controls)
│       ├── design_generator.dart         # Generator for .design.dart files (styles/variants)
│       └── source/                       # Source templates for generated code
│           ├── control_*.dart                   # Control mixin/extension templates
│           ├── design_*.dart                    # Design (style) mixin/extension templates
│           ├── delta_class.dart                 # Delta class template
│           ├── variant_extension_type.dart      # Variant/constraint extension type template
│           └── ...                              # Shared utilities (docs, types, etc.)
│
└── test/
    └── src/
        ├── control_generator_golden_test.dart   # Golden tests for control generation
        └── design_generator/
            ├── design_generator_golden_test.dart # Golden tests for design generation
            ├── golden.dart                       # Expected golden output
            └── source.dart                       # Test source input
```

## Updating Test Goldens

To update test goldens:
1. Temporarily copy the contents of `source` to `forui/lib/src/widgets/<file name>.dart` where `<file name>` is derived 
   from the `source`'s `part` directive, e.g. `part 'example.design.dart';` means the file name is `example.dart`.
2. Run `dart run build_runner build --delete-conflicting-outputs` to generate the new golden file in `forui/lib/src/widgets`.
  The golden file name is derived from the `part` directive, e.g. `part 'example.design.dart';` means the golden file name 
  is `example.design.dart`.
3. Copy the contents of the golden file and replace the `golden` variable in the test.
4. Delete the temporary files created in step 1 and 2.

