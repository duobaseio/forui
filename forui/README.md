<a href="https://forui.dev">
  <h1 align="center">
    <img width="400" alt="Forui" src="https://raw.githubusercontent.com/duobaseio/forui/main/docs/public/logos/light_logo.png">
  </h1>
</a>

<p align="center">
  <a href="https://github.com/duobaseio/forui/actions/workflows/forui_build.yaml"><img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/duobaseio/forui/forui_build.yaml?branch=main&style=flat&logo=github&label=main"></a>
  <a href="https://codecov.io/gh/duobaseio/forui" ><img src="https://codecov.io/gh/duobaseio/forui/branch/main/graph/badge.svg?token=YxGxA8Ydmg"/></a>
  <a href="https://pub.dev/packages/forui"><img alt="Pub Version" src="https://img.shields.io/pub/v/forui?style=flat&logo=dart&label=pub.dev&color=00589B"></a>
  <a href="https://github.com/duobaseio/forui"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/duobaseio/forui?style=flat&logo=github&color=8957e5&link=https%3A%2F%2Fgithub.com%2Fduobaseio%2Fforui"></a>
  <a href="https://discord.gg/jrw3qHksjE"><img alt="Discord" src="https://img.shields.io/discord/1268920771062009886?logo=discord&logoColor=fff&label=discord&color=%237289da"></a>
</p>

<p align="center">
  <a href="https://forui.dev/docs">📚 Documentation</a> •
  <a href="https://forui.dev/docs/widgets/layout/divider">🖼️ Widgets</a> •
  <a href="https://pub.dev/documentation/forui">🤓 API Reference</a> •
  <a href="https://github.com/orgs/duobaseio/projects/9">🗺️ Road Map</a>
</p>

<p align="center">
  Forui is a Flutter UI library that provides a set of beautifully designed, minimalistic widgets.
</p>

<br />
<div align="center">
 <img width="800" alt="Forui" src="https://raw.githubusercontent.com/duobaseio/forui/main/docs/public/banners/banner-text-130226.png">
</div>

> [!IMPORTANT]
> Forui 0.22.0+ requires Flutter **3.44.0+**. Run `flutter --version` to check your Flutter version.

## Why Choose Forui?

* 🎨 Over 40+ beautifully crafted widgets.
* ⚡ Bundled [CLI](https://forui.dev/docs/concepts/themes) to generate themes & styling boilerplate.
* ✅ [Well-tested](https://app.codecov.io/gh/duobaseio/forui).
* 🌍 I10n support.
* 🪝 First-class [Flutter Hooks](https://pub.dev/packages/flutter_hooks) integration via [`forui_hooks`](https://pub.dev/packages/forui_hooks).

## Documentation

Visit [forui.dev/docs](https://forui.dev/docs) to view the documentation.

## Flutter Hooks Integration

<a href="https://github.com/duobaseio/forui/actions/workflows/forui_hooks_build.yaml"><img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/duobaseio/forui/forui_hooks_build.yaml?branch=main&style=flat&logo=github&label=forui_hooks"></a>
<a href="https://pub.dev/packages/forui_hooks"><img alt="Pub Version" src="https://img.shields.io/pub/v/forui_hooks?style=flat&logo=dart&label=pub.dev: forui_hooks&color=00589B"></a>

Forui provides first class integration with [Flutter Hooks](https://pub.dev/packages/flutter_hooks). All controllers
are exposed as hooks in the companion `forui_hooks` package.

## Contributing

Please read the [contributing guide](https://github.com/duobaseio/forui/blob/main/CONTRIBUTING.md).

## Nightly Builds

Nightly builds are available on the `nightly` branch. To use the latest nightly build, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  forui:
    git:
      url: https://github.com/duobaseio/forui.git
      ref: nightly
      path: forui
```

Nightly builds are not guaranteed to be stable. Use at your own risk.

## License

Licensed under the [MIT License](https://github.com/duobaseio/forui/blob/main/forui/LICENSE) and [Open Font License](https://github.com/duobaseio/forui/blob/main/forui/LICENSE).

## Widgets

Forui provides the following widgets:

- Layout
  - [Divider](https://forui.dev/docs/widgets/layout/divider)
  - [Resizable](https://forui.dev/docs/widgets/layout/resizable)
  - [Scaffold](https://forui.dev/docs/widgets/layout/scaffold)
- Form
  - [Autocomplete](https://forui.dev/docs/widgets/form/autocomplete)
  - [Button](https://forui.dev/docs/widgets/form/button)
  - [Checkbox](https://forui.dev/docs/widgets/form/checkbox)
  - [Date Field](https://forui.dev/docs/widgets/form/date-field)
  - [Label](https://forui.dev/docs/widgets/form/label)
  - [Picker](https://forui.dev/docs/widgets/form/picker)
  - [Radio](https://forui.dev/docs/widgets/form/radio)
  - [Multi-select](https://forui.dev/docs/widgets/form/multi-select)
  - [OTP Field](https://forui.dev/docs/widgets/form/otp-field)
  - [Select](https://forui.dev/docs/widgets/form/select)
  - [Select Group](https://forui.dev/docs/widgets/form/select-group)
  - [Slider](https://forui.dev/docs/widgets/form/slider)
  - [Switch](https://forui.dev/docs/widgets/form/switch)
  - [Text Field](https://forui.dev/docs/widgets/form/text-field)
  - [Text Form Field](https://forui.dev/docs/widgets/form/text-form-field)
  - [Time Field](https://forui.dev/docs/widgets/form/time-field)
  - [Time Picker](https://forui.dev/docs/widgets/form/time-picker)
- Data Presentation
  - [Accordion](https://forui.dev/docs/widgets/data/accordion)
  - [Avatar](https://forui.dev/docs/widgets/data/avatar)
  - [Badge](https://forui.dev/docs/widgets/data/badge)
  - [Calendar](https://forui.dev/docs/widgets/data/calendar)
  - [Card](https://forui.dev/docs/widgets/data/card)
  - [Item](https://forui.dev/docs/widgets/data/item)
  - [Item Group](https://forui.dev/docs/widgets/data/item-group)
  - [Line Calendar](https://forui.dev/docs/widgets/data/line-calendar)
- Tile
  - [Tile](https://forui.dev/docs/widgets/tile/tile)
  - [Tile Group](https://forui.dev/docs/widgets/tile/tile-group)
  - [Select Tile Group](https://forui.dev/docs/widgets/tile/select-tile-group)
  - [Select Menu Tile](https://forui.dev/docs/widgets/tile/select-menu-tile)
- Navigation
  - [Bottom Navigation Bar](https://forui.dev/docs/widgets/navigation/bottom-navigation-bar)
  - [Breadcrumb](https://forui.dev/docs/widgets/navigation/breadcrumb)
  - [Header](https://forui.dev/docs/widgets/navigation/header)
  - [Pagination](https://forui.dev/docs/widgets/navigation/pagination)
  - [Sidebar](https://forui.dev/docs/widgets/navigation/sidebar)
  - [Tabs](https://forui.dev/docs/widgets/navigation/tabs)
- Feedback
  - [Alert](https://forui.dev/docs/widgets/feedback/alert)
  - [Progress](https://forui.dev/docs/widgets/feedback/progress)
- Overlay
  - [Dialog](https://forui.dev/docs/widgets/overlay/dialog)
  - [Sheet](https://forui.dev/docs/widgets/overlay/sheet)
  - [Persistent Sheet](https://forui.dev/docs/widgets/overlay/persistent-sheet)
  - [Popover](https://forui.dev/docs/widgets/overlay/popover)
  - [Popover Menu](https://forui.dev/docs/widgets/overlay/popover-menu)
  - [Tooltip](https://forui.dev/docs/widgets/overlay/tooltip)
  - [Toast/Sonner](https://forui.dev/docs/widgets/overlay/toast)
- Foundation
  - [Collapsible](https://forui.dev/docs/widgets/foundation/collapsible)
  - [Focused Outline](https://forui.dev/docs/widgets/foundation/focused-outline)
  - [Portal](https://forui.dev/docs/widgets/foundation/portal)
  - [Tappable](https://forui.dev/docs/widgets/foundation/tappable)
