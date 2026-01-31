import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
class DesignFunctionsMixin extends FunctionsMixin {
  /// Creates a new [DesignFunctionsMixin].
  DesignFunctionsMixin(super.step, super.element);

  /// Generates a mixin.
  @override
  Future<Mixin> generate() async =>
      (MixinBuilder()
            ..name = '_\$${element.name}Functions'
            ..implements.add(refer('${element.name}Delta'))
            ..on = refer('Diagnosticable')
            ..methods.addAll([_call, ...await getters, if (fields.isNotEmpty) debugFillProperties, equals, hash]))
          .build();

  Method get _call => Method(
    (m) => m
      ..docs.addAll(['/// Returns itself.'])
      ..annotations.add(refer('override'))
      ..returns = refer(element.name!)
      ..name = 'call'
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..covariant = true
            ..type = refer(element.name!)
            ..name = '_',
        ),
      )
      ..lambda = true
      ..body = Code('this as ${element.name}'),
  );
}
