import 'package:code_builder/code_builder.dart';

// TODO: Remove once https://github.com/dart-lang/tools/issues/2553 is fixed.

/// A [DartEmitter] that emits constructors using dot-shorthand declarations, i.e. `factory delta(...)` and
/// `const new(...)` instead of `factory FFooDelta.delta(...)` and `const FFooDelta(...)`.
class ShorthandEmitter extends DartEmitter {
  /// A placeholder that stands in for the enclosing type's name while delegating to [DartEmitter].
  ///
  /// It is not a valid identifier, so it can never collide with the constructor's docs, parameters or body.
  static const _placeholder = r'$-type-$';

  /// Creates a [ShorthandEmitter].
  new({super.allocator, super.orderDirectives, super.useNullSafetySyntax});

  @override
  StringSink visitConstructor(Constructor spec, String clazz, [StringSink? output]) {
    final buffer = StringBuffer();
    super.visitConstructor(spec, _placeholder, buffer);

    // The placeholder is emitted as `<placeholder>.<name>` for named constructors, and `<placeholder>` for unnamed
    // ones. Unnamed constructors keep an explicit `new` since a bare `const (...)` does not parse.
    final source = spec.name == null
        ? buffer.toString().replaceFirst(_placeholder, 'new')
        : buffer.toString().replaceFirst('$_placeholder.', '');

    return (output ??= StringBuffer())..write(source);
  }
}
