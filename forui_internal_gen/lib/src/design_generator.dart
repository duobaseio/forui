import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:forui_internal_gen/src/source/delta_class.dart';
import 'package:forui_internal_gen/src/source/design_functions_mixin.dart';
import 'package:forui_internal_gen/src/source/design_transformations_extension.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:forui_internal_gen/src/source/variant_extension_type.dart';
import 'package:source_gen/source_gen.dart';

final _style = RegExp(r'^F(?!Inherited).*(Style|Styles)$');
final _motion = RegExp(r'^F.*(Motion)$');

/// Generates corresponding style/motion mixins and extensions that implement several commonly used operations.
class DesignGenerator extends Generator {
  final _emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

  @override
  Future<String?> generate(LibraryReader library, BuildStep step) async {
    final generated = <String>[];

    for (final annotated in library.libraryDirectivesAnnotatedWith(variants)) {
      for (final metadata in annotated.metadata2?.annotations ?? <ElementAnnotation>[]) {
        if (metadata.computeConstantValue() case final annotation? when variants.isExactlyType(annotation.type!)) {
          final (prefix, variants) = variantsAnnotation(annotation);
          final generator = VariantExtensionType(prefix, variants);
          generated.addAll([
            _emitter.visitExtensionType(generator.generateVariantConstraint()).toString(),
            _emitter.visitExtensionType(generator.generateVariant()).toString(),
          ]);
        }
      }
    }

    // {style: {sentinelName: sentinelValue, ...}, ...}
    final sentinelValues = <String, Map<String, String>>{};
    for (final annotated in library.libraryDirectivesAnnotatedWith(sentinels)) {
      for (final metadata in annotated.metadata2?.annotations ?? <ElementAnnotation>[]) {
        if (metadata.computeConstantValue() case final annotation? when sentinels.isExactlyType(annotation.type!)) {
          final (style, values) = sentinelsAnnotation(annotation);
          sentinelValues[style.element.name!] = values;
        }
      }
    }

    for (final type in library.classes) {
      if (type.name == null || type.isSealed || type.isAbstract || fVariants.isSuperTypeOf(type.thisType)) {
        continue;
      }

      if (_style.hasMatch(type.name!)) {
        final delta = DeltaClass(step, type, sentinelValues[type.name] ?? {});
        generated.addAll([
          _emitter
              .visitExtension(
                await DesignTransformationsExtension(
                  step,
                  type,
                  sentinelValues[type.name] ?? {},
                  copyWithDocsHeader: [
                    '/// Returns a copy of this [${type.name!}] with the given properties replaced.',
                    '///',
                    '/// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).',
                    '///',
                  ],
                ).generate(),
              )
              .toString(),
          _emitter.visitMixin(await DesignFunctionsMixin(step, type).generate()).toString(),
          _emitter.visitClass(await delta.generateSealed()).toString(),
          _emitter.visitClass(await delta.generateDelta()).toString(),
          _emitter.visitClass(delta.generateContext()).toString(),
        ]);
      } else if (_motion.hasMatch(type.name!)) {
        final delta = DeltaClass(step, type, sentinelValues[type.name] ?? {});

        generated.addAll([
          _emitter
              .visitExtension(
                await DesignTransformationsExtension(
                  step,
                  type,
                  sentinelValues[type.name] ?? {},
                  copyWithDocsHeader: [
                    '/// Returns a copy of this [${type.name!}] with the given properties replaced.',
                    '///',
                  ],
                ).generate(),
              )
              .toString(),
          _emitter.visitMixin(await DesignFunctionsMixin(step, type).generate()).toString(),
          _emitter.visitClass(await delta.generateSealed()).toString(),
          _emitter.visitClass(await delta.generateDelta()).toString(),
          _emitter.visitClass(delta.generateContext()).toString(),
        ]);
      } else if (type.name == 'FThemeData') {
        generated.add(_emitter.visitMixin(await FunctionsMixin(step, type).generate()).toString());
      }
    }

    return generated.join('\n');
  }
}
