part of 'variant.dart';

/// Represents a platform.
extension type const FPlatformVariant(FVariant _) implements FVariant {
  /// Matches all touch-based platforms, [android], [iOS] and [fuchsia].
  static const touch = FPlatformVariant(_Touch());

  /// The Android platform variant.
  ///
  /// More specific than [touch] in variant resolution.
  static const android = FPlatformVariant(_Android());

  /// The iOS platform variant.
  ///
  /// More specific than [touch] in variant resolution.
  static const iOS = FPlatformVariant(_Ios());

  /// The Fuchsia platform variant.
  ///
  /// More specific than [touch] in variant resolution.
  static const fuchsia = FPlatformVariant(_Fuchsia());

  /// Matches all desktop-based platforms, [windows], [macOS] and [linux].
  static const desktop = FPlatformVariant(_Desktop());

  /// The Windows platform variant.
  ///
  /// More specific than [desktop] in variant resolution.
  static const windows = FPlatformVariant(_Windows());

  /// The macOS platform variant.
  ///
  /// More specific than [desktop] in variant resolution.
  static const macOS = FPlatformVariant(_MacOS());

  /// The Linux platform variant.
  ///
  /// More specific than [desktop] in variant resolution.
  static const linux = FPlatformVariant(_Linux());

  /// The web platform variant.
  ///
  /// Standalone platform that is neither [touch] nor [desktop].
  static const web = FPlatformVariant(_Web());
}

/// ## Implementation details
/// This abuses a [language quirk](https://github.com/dart-lang/language/issues/1711#issuecomment-2715814832) to allow
/// static and instance members with the same name.
extension FPlatformVariants on FPlatformVariant {
  /// Whether the current platform is a primarily touch-based platform.
  ///
  /// This is not 100% accurate as there are hybrid devices that use both touch and keyboard/mouse input, e.g.,
  /// Windows Surface laptops.
  bool get touch => this is _Touch;

  /// Whether the current platform is a primarily keyboard/mouse-based platform.
  ///
  /// This is not 100% as accurate as there are hybrid devices that use both touch and keyboard/mouse input, e.g.,
  /// Windows Surface laptops.
  bool get desktop => this is _Desktop;
}

class _Touch implements FVariant {
  const _Touch();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.any((v) => v is _Touch);

  @override
  void _accept(List<String> operands) => operands.add('touch');

  @override
  int get _operands => 1;

  @override
  String toString() => 'touch';
}

class _Android extends _Touch {
  const _Android();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Android());

  @override
  void _accept(List<String> operands) {
    super._accept(operands);
    operands.add('android');
  }

  @override
  int get _operands => 2;

  @override
  String toString() => '{touch, android}';
}

class _Ios extends _Touch {
  const _Ios();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Ios());

  @override
  void _accept(List<String> operands) {
    super._accept(operands);
    operands.add('iOS');
  }

  @override
  int get _operands => 2;

  @override
  String toString() => '{touch, iOS}';
}

class _Fuchsia extends _Touch {
  const _Fuchsia();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Fuchsia());

  @override
  void _accept(List<String> operands) {
    super._accept(operands);
    operands.add('fuchsia');
  }

  @override
  int get _operands => 2;

  @override
  String toString() => '{touch, fuchsia}';
}

class _Desktop implements FVariant {
  const _Desktop();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.any((v) => v is _Desktop);

  @override
  void _accept(List<String> operands) => operands.add('desktop');

  @override
  int get _operands => 1;

  @override
  String toString() => 'desktop';
}

class _Windows extends _Desktop {
  const _Windows();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Windows());

  @override
  void _accept(List<String> operands) {
    super._accept(operands);
    operands.add('windows');
  }

  @override
  int get _operands => 2;

  @override
  String toString() => '{desktop, windows}';
}

class _MacOS extends _Desktop {
  const _MacOS();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _MacOS());

  @override
  void _accept(List<String> operands) {
    super._accept(operands);
    operands.add('macOS');
  }

  @override
  int get _operands => 2;

  @override
  String toString() => '{desktop, macOS}';
}

class _Linux extends _Desktop {
  const _Linux();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Linux());

  @override
  void _accept(List<String> operands) {
    super._accept(operands);
    operands.add('linux');
  }

  @override
  int get _operands => 2;

  @override
  String toString() => '{desktop, linux}';
}

class _Web implements FVariant {
  const _Web();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Web());

  @override
  void _accept(List<String> operands) => operands.add('web');

  @override
  int get _operands => 1;

  @override
  String toString() => 'web';
}
