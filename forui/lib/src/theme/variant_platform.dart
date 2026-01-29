part of 'variant.dart';

/// Represents a platform.
///
/// Platform variants are tier 0, the lowest tier. Interaction and semantic variants take precedence during resolution.
extension type const FPlatformVariant(FVariant _) implements FVariant {
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

  /// Whether the current platform is a primarily touch-based platform.
  ///
  /// This is not 100% accurate as there are hybrid devices that use both touch and keyboard/mouse input, e.g.,
  /// Windows Surface laptops.
  bool get touch => this is Touch;

  /// Whether the current platform is a primarily keyboard/mouse-based platform.
  ///
  /// This is not 100% as accurate as there are hybrid devices that use both touch and keyboard/mouse input, e.g.,
  /// Windows Surface laptops.
  bool get desktop => this is Desktop;
}

@internal
class Touch implements FVariant {
  const Touch();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.any((v) => v is Touch);

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands.add('touch');
    tiers[0] = tiers[0] + 1;
  }

  @override
  String toString() => 'touch';
}

class _Android extends Touch {
  const _Android();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Android());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands
      ..add('touch')
      ..add('android');
    tiers[0] = tiers[0] + 2;
  }

  @override
  String toString() => '{touch, android}';
}

class _Ios extends Touch {
  const _Ios();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Ios());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands
      ..add('touch')
      ..add('iOS');
    tiers[0] = tiers[0] + 2;
  }

  @override
  String toString() => '{touch, iOS}';
}

class _Fuchsia extends Touch {
  const _Fuchsia();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Fuchsia());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands
      ..add('touch')
      ..add('fuchsia');
    tiers[0] = tiers[0] + 2;
  }

  @override
  String toString() => '{touch, fuchsia}';
}

@internal
class Desktop implements FVariant {
  const Desktop();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.any((v) => v is Desktop);

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands.add('desktop');
    tiers[0] = tiers[0] + 1;
  }

  @override
  String toString() => 'desktop';
}

class _Windows extends Desktop {
  const _Windows();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Windows());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands
      ..add('desktop')
      ..add('windows');
    tiers[0] = tiers[0] + 2;
  }

  @override
  String toString() => '{desktop, windows}';
}

class _MacOS extends Desktop {
  const _MacOS();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _MacOS());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands
      ..add('desktop')
      ..add('macOS');
    tiers[0] = tiers[0] + 2;
  }

  @override
  String toString() => '{desktop, macOS}';
}

class _Linux extends Desktop {
  const _Linux();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Linux());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands
      ..add('desktop')
      ..add('linux');
    tiers[0] = tiers[0] + 2;
  }

  @override
  String toString() => '{desktop, linux}';
}

class _Web implements FVariant {
  const _Web();

  @override
  bool satisfiedBy(Set<FVariant> variants) => variants.contains(const _Web());

  @override
  void _accept(List<String> operands, List<int> tiers) {
    operands.add('web');
    tiers[0] = tiers[0] + 1;
  }

  @override
  String toString() => 'web';
}
