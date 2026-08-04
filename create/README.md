# Forui Create

The visual theme builder hosted at [create.forui.dev](https://create.forui.dev). Pick a base color, primary color,
fonts, icon library, and border radius, preview the result live, then copy a `dart run forui init --preset <code>`
command to scaffold the same theme in your own project.


## How it works

* The theme options and the preset codec live in `forui_cli` (`Preset`, `BaseColor`, `PrimaryColor`, `FontFamily`,
  `IconLibrary`, `Radius`). This app only wraps them; the CLI is the source of truth, so the code shown in
  "Get Code" always round-trips through `forui init`.
* The URL is the source of truth for the current selection. The selection is encoded into the `?preset=` query
  parameter, which makes every configuration linkable and shareable.
* The preview is a horizontally scrolling canvas of cards grouped into vertical tracks, each card showcasing a
  realistic slice of UI built with Forui widgets.


## Development

Bootstrap the monorepo first (`make bootstrap` from the repository root), then:

```shell
flutter run -d chrome
```

In debug mode, the app initializes [Marionette](https://pub.dev/packages/marionette_flutter) so agents can drive it.


### Tests

Code generation for `forui` must have run at least once (`dart run build_runner build` in `forui/`). Then:

```shell
flutter test
```
