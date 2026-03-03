# Forui Widget Spotlight

A demo app for showcasing [Forui](../forui) widgets in video recordings.

## Running

```bash
cd demo && flutter run -d macos
```

## Adding Widget Pages

1. Create a new file in `lib/widgets/` (e.g. `lib/widgets/slider.dart`).
2. Export a single widget from the file.
3. Swap the import and widget reference in `lib/main.dart`.
