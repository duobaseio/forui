import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
class DesignFunctionsMixin extends FunctionsMixin {
  /// The generated call function's docs.
  @protected
  final List<String> callDocs;

  /// Creates a new [DesignFunctionsMixin].
  DesignFunctionsMixin(super.step, super.element, this.callDocs);

  /// Generates a mixin.
  @override
  Future<Mixin> generate() async =>
      (MixinBuilder()
            ..name = '_\$${element.name}Functions'
            ..on = refer('Diagnosticable')
            ..methods.addAll([...await getters, if (fields.isNotEmpty) debugFillProperties, equals, hash]))
          .build();
}
