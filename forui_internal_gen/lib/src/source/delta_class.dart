import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/docs.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates a delta for a style.
@internal
class DeltaClass {
  final BuildStep _step;
  final ClassElement _class;
  final List<FieldElement> _fields;
  final Map<String, String> _sentinels;

  DeltaClass(this._step, this._class, this._sentinels) : _fields = transitiveInstanceFields(_class);

  /// Generates the sealed delta class.
  Future<Class> generateSealed() async {
    final parameters = [for (final field in _fields) await _parameter(field, toThis: false)];
    return Class(
      (c) => c
        ..docs.addAll([
          '/// A delta that applies modifications to a [${_class.name}].',
          '/// ',
          '/// A [${_class.name}] is itself a [${_class.name}Delta].',
        ])
        ..sealed = true
        ..name = '${_class.name}Delta'
        ..mixins.add(refer('Delta'))
        ..constructors.addAll([
          Constructor(
            (c) => c
              ..docs.addAll(['/// Creates a delta that returns the [${_class.name}] in the current context.'])
              ..constant = true
              ..factory = true
              ..name = 'inherit'
              ..redirect = refer('_${_class.name}Inherit'),
          ),
          Constructor(
            (c) => c
              ..docs.addAll(_deltaConstructorDocs)
              ..constant = true
              ..factory = true
              ..name = 'delta'
              ..optionalParameters.addAll(parameters)
              ..redirect = refer('_${_class.name}Delta'),
          ),
        ])
        ..methods.add(
          Method(
            (m) => m
              ..annotations.add(refer('override'))
              ..returns = refer(_class.name!)
              ..name = 'call'
              ..requiredParameters.add(
                Parameter(
                  (p) => p
                    ..covariant = true
                    ..type = refer(_class.name!)
                    ..name = 'value',
                ),
              ),
          ),
        ),
    );
  }

  List<String> get _deltaConstructorDocs {
    final docs = ['/// Creates a partial modification of a [${_class.name}].', '///', '/// ## Parameters'];

    for (final field in _fields) {
      final prefix = '/// * [${_class.name}.${field.name}]';
      final summary = summarizeDocs(field.documentationComment);
      docs.add('$prefix${summary == null ? '' : ' - $summary'}');
    }

    return docs;
  }

  /// Generates the private inherit class.
  Class generateInherit() => Class(
    (c) => c
      ..name = '_${_class.name}Inherit'
      ..implements.add(refer('${_class.name}Delta'))
      ..constructors.add(Constructor((c) => c..constant = true))
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
                  ..name = 'original',
              ),
            )
            ..lambda = true
            ..body = const Code('original'),
        ),
      ),
  );

  /// Generates the private delta class.
  Future<Class> generateDelta() async {
    final parameters = [for (final field in _fields) await _parameter(field, toThis: true)];
    final fields = [for (final field in _fields) await _field(field)];
    final call = await _call();
    return Class(
      (c) => c
        ..name = '_${_class.name}Delta'
        ..implements.add(refer('${_class.name}Delta'))
        ..constructors.add(
          Constructor(
            (c) => c
              ..constant = true
              ..optionalParameters.addAll(parameters),
          ),
        )
        ..fields.addAll(fields)
        ..methods.add(call),
    );
  }

  /// Generates a delta parameter from the field.
  Future<Parameter> _parameter(FieldElement field, {required bool toThis}) async {
    final (type, _, sentinel) = await deltaField(_step, field, _sentinels, prefix: 'original', cast: true);
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
  Future<Field> _field(FieldElement field) async {
    final (type, _, _) = await deltaField(_step, field, _sentinels, prefix: 'original', cast: true);
    return Field(
      (f) => f
        ..modifier = .final$
        ..type = refer(type)
        ..name = field.name!,
    );
  }

  /// Generates the call method for the merge class.
  Future<Method> _call() async {
    final assignments = [
      for (final field in _fields)
        '${field.name!}: ${(await deltaField(_step, field, _sentinels, prefix: 'original', cast: true)).$2}',
    ].join(',');
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
}
