# Style Generation CLI

Author: Matt (Pante)
Status: Shipped (Forui 0.11.0)

## Problem

It is really tedious to modify a widget's existing appearance. To change a widget's appearance, developers need to retrieve the current widget's style and chain several `copyWith(...)` and `trasnform(...)` calls.

To change a `FTextField`'s font size, focused and unfocused colors:
```dart
FTextFieldStyle.inherit(
  colorScheme: context.theme.colorScheme,
  typography: context.theme.typography.scale(sizeScalar: 1.2),
  style: context.theme.style,
).copyWith(
  enabledStyle: context.theme.textFieldStyle.enabledStyle.copyWith(
    focusedStyle: context.theme.textFieldStyle.enabledStyle.focusedStyle
        .copyWith(color: Colors.transparent),
    unfocusedStyle: context.theme.textFieldStyle.enabledStyle.unfocusedStyle
        .copyWith(color: Colors.transparent),
  ),
);
```

It is both cumbersome to write by hand and difficult to read due to all the noise introduced by the `copyWith(...)`s and `trasnform(...)`s.

## Proposed CLI

We believe that modifying a generated style is less tedious that manually chaining `copyWith(...)` and `trasnform(...)` calls. As such, we propose introducing a CLI that generates style "templates" in the **developer's project**. These templates can then be modified and used to style a corresponding widget.

It is important to note that the CLI does **not** aim to make styles less verbose in general, only less painful to customize.

### What is a style template?
A style template is a snippet of styling code for a particular widget. It is typically a copy of a style's `inherit(...)` constructor. This gives developers the freedom to tailor a style unique to their use-case.

<details>
  <summary>Generated `FTextFieldStyle` template</summary>

```dart
FTextFieldStyle textFieldStyle({
  required FColorScheme colorScheme,
  required FTypography typography,
  required FStyle style,
}) => FTextFieldStyle(
  keyboardAppearance: colorScheme.brightness,
  labelLayoutStyle: labelStyles(style: style).verticalStyle.layout,
  clearButtonStyle: buttonStyles(
    colorScheme: colorScheme,
    typography: typography,
    style: style,
  ).ghost.transform(
    (ghost) => ghost.copyWith(
      iconContentStyle: ghost.iconContentStyle.copyWith(
        enabledStyle: IconThemeData(
          color: colorScheme.mutedForeground,
          size: 17,
        ),
      ),
    ),
  ),
  enabledStyle: textFieldStateStyle(
    contentColor: colorScheme.primary,
    hintColor: colorScheme.mutedForeground,
    focusedBorderColor: colorScheme.primary,
    unfocusedBorderColor: colorScheme.border,
    formFieldStyle: style.enabledFormFieldStyle,
    typography: typography,
    style: style,
  ),
  disabledStyle: textFieldStateStyle(
    contentColor: colorScheme.disable(colorScheme.primary),
    hintColor: colorScheme.disable(colorScheme.border),
    focusedBorderColor: colorScheme.disable(colorScheme.border),
    unfocusedBorderColor: colorScheme.disable(colorScheme.border),
    formFieldStyle: style.disabledFormFieldStyle,
    typography: typography,
    style: style,
  ),
  errorStyle: textFieldErrorStyle(
    contentColor: colorScheme.primary,
    hintColor: colorScheme.mutedForeground,
    focusedBorderColor: colorScheme.error,
    unfocusedBorderColor: colorScheme.error,
    formFieldErrorStyle: style.errorFormFieldStyle,
    typography: typography,
    style: style,
  ),
);

FTextFieldStateStyle textFieldStateStyle({
  required Color contentColor,
  required Color hintColor,
  required Color focusedBorderColor,
  required Color unfocusedBorderColor,
  required FFormFieldStyle formFieldStyle,
  required FTypography typography,
  required FStyle style,
}) => FTextFieldStateStyle(
  labelTextStyle: formFieldStyle.labelTextStyle,
  contentTextStyle: typography.sm.copyWith(
    fontFamily: typography.defaultFontFamily,
    color: contentColor,
  ),
  hintTextStyle: typography.sm.copyWith(
    fontFamily: typography.defaultFontFamily,
    color: hintColor,
  ),
  counterTextStyle: typography.sm.copyWith(
    fontFamily: typography.defaultFontFamily,
    color: contentColor,
  ),
  descriptionTextStyle: formFieldStyle.descriptionTextStyle,
  focusedStyle: textFieldBorderStyle(color: focusedBorderColor, style: style),
  unfocusedStyle: textFieldBorderStyle(
    color: unfocusedBorderColor,
    style: style,
  ),
);

FTextFieldBorderStyle textFieldBorderStyle({
  required Color color,
  required FStyle style,
}) => FTextFieldBorderStyle(
  color: color,
  width: style.borderWidth,
  radius: style.borderRadius,
);
```

</details>

### Comparison

To modify a `FTextField`'s font size, focused and unfocused colors, the current approach requires developers to:
1. Create a `FTextFieldStyle` via `FTextFieldStyle.inherit(...)`
2. Pass a custom `FTypography` to `FTextFieldStyle.inherit(...)`
3. Call `copyWith(...)`
4. Get the current context's `FTextFieldStyle`
5. Call `copyWith(...)` again
6. Get the current context's `FTextFieldStyle` again
7. Call `copyWith(...)` yet again
8. Repeat steps 4 - 7 for the unfocused color

In constrast, the generated style template requires developers to:
1. Generate a style template via a command
2. Pass a custom `FTypography`
3. Modify the focused color
4. Modify the unfocused color

We should also note that the 2nd approach scales better when the number of modified properties increases.

### Usage

The CLI is currently available on the [`feature/cli`](https://github.com/forus-labs/forui/tree/feature/cli/forui) branch. It will be bundled with Forui. No additional set-up is required. Neither will it increase the application's bundle size.

To create a style, run the following command in your project's root directory:
```shell
dart run forui style create [styles]
```

CLI `--help`:
```shell
Usage: forui style <subcommand> [arguments]
-h, --help    Print this usage information.

Available subcommands:
  create   Create Forui widget style file(s).
  ls       List all Forui widget styles.

Run "forui help" to see global options.
```

```shell
Usage: forui style create [styles]
-h, --help      Print this usage information.
-a, --all       Create all styles.
-f, --force     Overwrite existing files if they exist.
-o, --output    The output directory or file.
                (defaults to "<project root>/lib/styles")

Run "forui help" to see global options.
```

By default, the CLI will generate one specified style template per file.

For example, `dart run forui style create ftextfieldstyle fdividerstyle` will yield:
* `lib/styles/text_field_style.dart`
* `lib/styles/divider_style.dart`

Alternatively, multiple styles can be generated in a single file by specifying an output file.

For example, `dart run forui style create ftextfieldstyle fdividerstyle -o 'lib/styles.dart'` will yield:
<details>
  <summary>Generated file</summary>

```dart
extension CustomFTextFieldStyle on Never {
  static FTextFieldStyle textFieldStyle({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) => FTextFieldStyle(
    keyboardAppearance: colorScheme.brightness,
    labelLayoutStyle: _labelStyles(style: style).verticalStyle.layout,
    clearButtonStyle: _buttonStyles(
      colorScheme: colorScheme,
      typography: typography,
      style: style,
    ).ghost.transform(
      (ghost) => ghost.copyWith(
        iconContentStyle: ghost.iconContentStyle.copyWith(
          enabledStyle: IconThemeData(
            color: colorScheme.mutedForeground,
            size: 17,
          ),
        ),
      ),
    ),
    enabledStyle: _textFieldStateStyle(
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      focusedBorderColor: colorScheme.primary,
      unfocusedBorderColor: colorScheme.border,
      formFieldStyle: style.enabledFormFieldStyle,
      typography: typography,
      style: style,
    ),
    disabledStyle: _textFieldStateStyle(
      contentColor: colorScheme.disable(colorScheme.primary),
      hintColor: colorScheme.disable(colorScheme.border),
      focusedBorderColor: colorScheme.disable(colorScheme.border),
      unfocusedBorderColor: colorScheme.disable(colorScheme.border),
      formFieldStyle: style.disabledFormFieldStyle,
      typography: typography,
      style: style,
    ),
    errorStyle: _textFieldErrorStyle(
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      focusedBorderColor: colorScheme.error,
      unfocusedBorderColor: colorScheme.error,
      formFieldErrorStyle: style.errorFormFieldStyle,
      typography: typography,
      style: style,
    ),
  );

  static FLabelStyles _labelStyles({required FStyle style}) => FLabelStyles(
    horizontalStyle: (
      layout: const FLabelLayoutStyle(
        childPadding: EdgeInsets.symmetric(horizontal: 8),
        descriptionPadding: EdgeInsets.only(top: 2),
        errorPadding: EdgeInsets.only(top: 2),
      ),
      state: _labelStateStyles(style: style),
    ),
    verticalStyle: (
      layout: const FLabelLayoutStyle(
        labelPadding: EdgeInsets.only(bottom: 5),
        descriptionPadding: EdgeInsets.only(top: 5),
        errorPadding: EdgeInsets.only(top: 5),
      ),
      state: _labelStateStyles(style: style),
    ),
  );

  static FLabelStateStyles _labelStateStyles({required FStyle style}) =>
      FLabelStateStyles(
        enabledStyle: style.enabledFormFieldStyle,
        disabledStyle: style.disabledFormFieldStyle,
        errorStyle: style.errorFormFieldStyle,
      );

  static FButtonStyles _buttonStyles({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) => FButtonStyles(
    primary: _buttonStyle(
      style: style,
      typography: typography,
      enabledBoxColor: colorScheme.primary,
      enabledHoveredBoxColor: colorScheme.hover(colorScheme.primary),
      disabledBoxColor: colorScheme.disable(colorScheme.primary),
      enabledContentColor: colorScheme.primaryForeground,
      disabledContentColor: colorScheme.disable(
        colorScheme.primaryForeground,
        colorScheme.disable(colorScheme.primary),
      ),
    ),
    secondary: _buttonStyle(
      style: style,
      typography: typography,
      enabledBoxColor: colorScheme.secondary,
      enabledHoveredBoxColor: colorScheme.hover(colorScheme.secondary),
      disabledBoxColor: colorScheme.disable(colorScheme.secondary),
      enabledContentColor: colorScheme.secondaryForeground,
      disabledContentColor: colorScheme.disable(
        colorScheme.secondaryForeground,
        colorScheme.disable(colorScheme.secondary),
      ),
    ),
    destructive: _buttonStyle(
      style: style,
      typography: typography,
      enabledBoxColor: colorScheme.destructive,
      enabledHoveredBoxColor: colorScheme.hover(colorScheme.destructive),
      disabledBoxColor: colorScheme.disable(colorScheme.destructive),
      enabledContentColor: colorScheme.destructiveForeground,
      disabledContentColor: colorScheme.disable(
        colorScheme.destructiveForeground,
        colorScheme.disable(colorScheme.destructive),
      ),
    ),
    outline: FButtonStyle(
      enabledBoxDecoration: BoxDecoration(
        border: Border.all(color: colorScheme.border),
        borderRadius: style.borderRadius,
      ),
      enabledHoverBoxDecoration: BoxDecoration(
        border: Border.all(color: colorScheme.border),
        borderRadius: style.borderRadius,
        color: colorScheme.secondary,
      ),
      disabledBoxDecoration: BoxDecoration(
        border: Border.all(color: colorScheme.disable(colorScheme.border)),
        borderRadius: style.borderRadius,
      ),
      focusedOutlineStyle: style.focusedOutlineStyle,
      contentStyle: _buttonContentStyle(
        typography: typography,
        enabled: colorScheme.secondaryForeground,
        disabled: colorScheme.disable(colorScheme.secondaryForeground),
      ),
      iconContentStyle: FButtonIconContentStyle(
        enabledStyle: IconThemeData(
          color: colorScheme.secondaryForeground,
          size: 20,
        ),
        disabledStyle: IconThemeData(
          color: colorScheme.disable(colorScheme.secondaryForeground),
          size: 20,
        ),
      ),
      tappableStyle: style.tappableStyle,
    ),
    ghost: FButtonStyle(
      enabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
      enabledHoverBoxDecoration: BoxDecoration(
        borderRadius: style.borderRadius,
        color: colorScheme.secondary,
      ),
      disabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
      focusedOutlineStyle: style.focusedOutlineStyle,
      contentStyle: _buttonContentStyle(
        typography: typography,
        enabled: colorScheme.secondaryForeground,
        disabled: colorScheme.disable(colorScheme.secondaryForeground),
      ),
      iconContentStyle: FButtonIconContentStyle(
        enabledStyle: IconThemeData(
          color: colorScheme.secondaryForeground,
          size: 20,
        ),
        disabledStyle: IconThemeData(
          color: colorScheme.disable(colorScheme.secondaryForeground),
          size: 20,
        ),
      ),
      tappableStyle: style.tappableStyle,
    ),
  );

  static FButtonStyle _buttonStyle({
    required FTypography typography,
    required FStyle style,
    required Color enabledBoxColor,
    required Color enabledHoveredBoxColor,
    required Color disabledBoxColor,
    required Color enabledContentColor,
    required Color disabledContentColor,
  }) => FButtonStyle(
    enabledBoxDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: enabledBoxColor,
    ),
    enabledHoverBoxDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: enabledHoveredBoxColor,
    ),
    disabledBoxDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: disabledBoxColor,
    ),
    focusedOutlineStyle: style.focusedOutlineStyle,
    contentStyle: _buttonContentStyle(
      typography: typography,
      enabled: enabledContentColor,
      disabled: disabledContentColor,
    ),
    iconContentStyle: FButtonIconContentStyle(
      enabledStyle: IconThemeData(color: enabledContentColor, size: 20),
      disabledStyle: IconThemeData(color: disabledContentColor, size: 20),
    ),
    tappableStyle: style.tappableStyle,
  );

  static FButtonContentStyle _buttonContentStyle({
    required FTypography typography,
    required Color enabled,
    required Color disabled,
  }) => FButtonContentStyle(
    enabledTextStyle: typography.base.copyWith(
      color: enabled,
      fontWeight: FontWeight.w500,
      height: 1,
    ),
    disabledTextStyle: typography.base.copyWith(
      color: disabled,
      fontWeight: FontWeight.w500,
      height: 1,
    ),
    enabledIconStyle: IconThemeData(color: enabled, size: 20),
    disabledIconStyle: IconThemeData(color: disabled, size: 20),
  );

  static FTextFieldStateStyle _textFieldStateStyle({
    required Color contentColor,
    required Color hintColor,
    required Color focusedBorderColor,
    required Color unfocusedBorderColor,
    required FFormFieldStyle formFieldStyle,
    required FTypography typography,
    required FStyle style,
  }) => FTextFieldStateStyle(
    labelTextStyle: formFieldStyle.labelTextStyle,
    contentTextStyle: typography.sm.copyWith(
      fontFamily: typography.defaultFontFamily,
      color: contentColor,
    ),
    hintTextStyle: typography.sm.copyWith(
      fontFamily: typography.defaultFontFamily,
      color: hintColor,
    ),
    counterTextStyle: typography.sm.copyWith(
      fontFamily: typography.defaultFontFamily,
      color: contentColor,
    ),
    descriptionTextStyle: formFieldStyle.descriptionTextStyle,
    focusedStyle: _textFieldBorderStyle(
      color: focusedBorderColor,
      style: style,
    ),
    unfocusedStyle: _textFieldBorderStyle(
      color: unfocusedBorderColor,
      style: style,
    ),
  );

  static FTextFieldBorderStyle _textFieldBorderStyle({
    required Color color,
    required FStyle style,
  }) => FTextFieldBorderStyle(
    color: color,
    width: style.borderWidth,
    radius: style.borderRadius,
  );

  static FTextFieldErrorStyle _textFieldErrorStyle({
    required FFormFieldErrorStyle formFieldErrorStyle,
    required Color contentColor,
    required Color hintColor,
    required Color focusedBorderColor,
    required Color unfocusedBorderColor,
    required FTypography typography,
    required FStyle style,
  }) => FTextFieldErrorStyle.inherit(
    formFieldErrorStyle: formFieldErrorStyle,
    contentColor: contentColor,
    hintColor: hintColor,
    focusedBorderColor: focusedBorderColor,
    unfocusedBorderColor: unfocusedBorderColor,
    typography: typography,
    style: style,
  );
}

extension CustomFDividerStyle on Never {
  static FDividerStyle dividerStyle({
    required FColorScheme colorScheme,
    required FStyle style,
    required EdgeInsetsGeometry padding,
  }) => FDividerStyle(
    color: colorScheme.secondary,
    padding: padding,
    width: style.borderWidth,
  );
}
```
</details>