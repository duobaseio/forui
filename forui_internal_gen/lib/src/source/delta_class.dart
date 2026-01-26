import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

final _constraint = RegExp(r'\[(\w+)\]');

/// Generates a delta for a style.
@internal
class DeltaClass {
  final ClassElement _class;
  final List<FieldElement> _fields;
  final Map<String, String> _sentinels;

  DeltaClass(this._class, this._sentinels) : _fields = transitiveInstanceFields(_class);

  /// Generates the sealed delta class.
  Class generateSealed() => Class(
    (c) => c
      ..docs.addAll(['/// A delta that applies modifications to a [${_class.name}].'])
      ..sealed = true
      ..name = '${_class.name}Delta'
      ..mixins.add(refer('Delta<${_class.name}>'))
      ..constructors.addAll([
        Constructor(
          (c) => c
            ..docs.addAll(['/// Creates a complete replacement for a [${_class.name}].'])
            ..constant = true
            ..factory = true
            ..name = 'replace'
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'replacement'
                  ..type = refer(_class.name!),
              ),
            )
            ..redirect = refer('_${_class.name}Replace'),
        ),
        Constructor(
          (c) => c
            ..docs.addAll(['/// Creates a partial modification of a [${_class.name}].'])
            ..constant = true
            ..factory = true
            ..name = 'merge'
            ..optionalParameters.addAll([for (final field in _fields) _parameter(field, toThis: false)])
            ..redirect = refer('_${_class.name}Merge'),
        ),
      ]),
  );

  /// Generates the private replace implementation class.
  Class generateReplace() => Class(
    (c) => c
      ..name = '_${_class.name}Replace'
      ..implements.add(refer('${_class.name}Delta'))
      ..fields.add(
        Field(
          (f) => f
            ..modifier = FieldModifier.final$
            ..type = refer(_class.name!)
            ..name = '_replacement',
        ),
      )
      ..constructors.add(
        Constructor(
          (c) => c
            ..constant = true
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..toThis = true
                  ..name = '_replacement',
              ),
            ),
        ),
      )
      ..methods.add(
        Method(
          (m) => m
            ..annotations.add(refer('override'))
            ..returns = refer(_class.name!)
            ..name = 'call'
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..type = refer(_class.name!)
                  ..name = '_',
              ),
            )
            ..lambda = true
            ..body = const Code('_replacement'),
        ),
      ),
  );

  /// Generates the private merge implementation class.
  Class generateMerge() => Class(
    (c) => c
      ..name = '_${_class.name}Merge'
      ..implements.add(refer('${_class.name}Delta'))
      ..constructors.add(
        Constructor(
          (c) => c
            ..constant = true
            ..optionalParameters.addAll([for (final field in _fields) _parameter(field, toThis: true)]),
        ),
      )
      ..fields.addAll([for (final field in _fields) _field(field)])
      ..methods.add(_call),
  );

  /// Generates a delta parameter from the field.
  Parameter _parameter(FieldElement field, {required bool toThis}) {
    final (type, _, sentinel) = _type(field);
    final parameter = ParameterBuilder()
      ..named = true
      ..name = field.name!;

    if (toThis) {
      parameter
        ..toThis = true
        ..defaultTo = sentinel == null ? null : Code(sentinel);
    } else {
      parameter.type = refer(type);
    }

    return parameter.build();
  }

  /// Generates a delta field from the field.
  Field _field(FieldElement field) {
    final (type, _, _) = _type(field);
    return Field(
      (f) => f
        ..modifier = FieldModifier.final$
        ..type = refer(type)
        ..name = field.name!,
    );
  }

  /// Generates the call method for the merge class.
  Method get _call {
    final assignments = _fields.map((field) => '${field.name!}: ${_type(field).$2}').join(',');
    return Method(
      (m) => m
        ..annotations.add(refer('override'))
        ..returns = refer(_class.name!)
        ..name = 'call'
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..type = refer(_class.name!)
              ..name = 'original',
          ),
        )
        ..lambda = true
        ..body = Code('${_class.name!}($assignments)'),
    );
  }

  /// Returns the delta type, assignment expression, and optional sentinel for a field.
  (String type, String assignment, String? sentinel) _type(FieldElement field) {
    final name = field.name!;
    final typeName = field.type.getDisplayString();

    // Nested styles
    if ((typeName.startsWith('F') && !typeName.startsWith('FInherited')) &&
        (typeName.endsWith('Style') || typeName.endsWith('Styles'))) {
      return ('${typeName}Delta?', '$name?.call(original.$name) ?? original.$name', null);
    }

    // Nested motions
    if (typeName.startsWith('F') && typeName.endsWith('Motion')) {
      return ('${typeName}Delta?', '$name?.call(original.$name) ?? original.$name', null);
    }

    // Supported Flutter in-built types
    if (typeName == 'BoxDecoration' || typeName == 'IconThemeData' || typeName == 'TextStyle') {
      return ('${typeName}Delta?', '$name?.call(original.$name) ?? original.$name', null);
    }

    // FVariants<K extends FVariantConstraint, V, D extends Delta<V>>
    if (field.type case InterfaceType(:final element, :final typeArguments) when element.name == 'FVariants') {
      // K is always an invalid type due to a circular dependency between FTappableVariantConstraint being generated
      // when build_runner is ran, and this generator requiring FTappableVariantConstraint to generate the correct delta.
      //
      // As a temporary workaround until augmentations are released, we assume that the type is in the last line of the
      // field's docs in the format: `/// * [<constraint>]`.
      final [_, v, d] = typeArguments;
      final k = _constraint.firstMatch(field.documentationComment!.split('\n').last)!.group(1)!;
      final e = k.substring(0, k.indexOf('Constraint'));

      final type = d.getDisplayString().split('<').first == 'Delta'
          ? 'FVariantsValueDelta<$k, $e, ${v.getDisplayString()}>'
          : 'FVariantsDelta<$k, $e, ${v.getDisplayString()}, ${d.getDisplayString()}>';

      return ('$type?', '$name?.call(original.$name) ?? original.$name', null);
    }

    // Nullable types with explicit sentinel values
    if (_sentinels[field.name] case final sentinel?) {
      return (typeName, '$name == $sentinel ? original.$name : $name', sentinel);
    }

    // Enums and nullable types without explicit sentinel values
    if (enumeration.isAssignableFromType(field.type) ||
        (field.type.nullabilitySuffix == .question && !_sentinels.containsKey(field.name))) {
      return ('$typeName Function()?', '$name == null ? original.$name : $name!()', null);
    }

    return ('$typeName?', '$name ?? original.$name', null);
  }
}
