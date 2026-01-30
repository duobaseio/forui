import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:forui_internal_gen/src/source/delta_class.dart';
import 'package:forui_internal_gen/src/source/design_functions_mixin.dart';
import 'package:forui_internal_gen/src/source/design_transformations_extension.dart';
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
      final (style, variants) = variantsAnnotation(annotated.annotation.objectValue);
      final generator = VariantExtensionType(style, variants);

      generated.addAll([
        _emitter.visitExtensionType(generator.generateVariantConstraint()).toString(),
        _emitter.visitExtensionType(generator.generateVariant()).toString(),
      ]);
    }

    // {style: {sentinelName: sentinelValue, ...}, ...}
    final sentinelValues = <String, Map<String, String>>{};
    for (final annotated in library.libraryDirectivesAnnotatedWith(sentinels)) {
      final (style, values) = sentinelsAnnotation(annotated.annotation.objectValue);
      sentinelValues[style.element.name!] = values;
    }

    for (final type in library.classes) {
      if (type.name == null || type.isSealed || type.isAbstract) {
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
          _emitter
              .visitMixin(
                await DesignFunctionsMixin(step, type, [
                  '/// Returns itself.',
                  '/// ',
                  "/// Allows [${type.name}] to replace functions that accept and return a [${type.name}], such as a style's",
                  '/// `copyWith(...)` function.',
                  '/// ',
                  '/// ## Example',
                  '/// ',
                  '/// Given:',
                  '/// ```dart',
                  '/// void copyWith(${type.name} Function(${type.name}) nestedStyle) {}',
                  '/// ```',
                  '/// ',
                  '/// The following:',
                  '/// ```dart',
                  '/// copyWith((style) => ${type.name}(...));',
                  '/// ```',
                  '/// ',
                  '/// Can be replaced with:',
                  '/// ```dart',
                  '/// copyWith(${type.name}(...));',
                  '/// ```',
                ]).generate(),
              )
              .toString(),
          _emitter.visitClass(await delta.generateSealed()).toString(),
          _emitter.visitClass(delta.generateValue()).toString(),
          _emitter.visitClass(delta.generateInherit()).toString(),
          _emitter.visitClass(await delta.generateDelta()).toString(),
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
          _emitter.visitMixin(await DesignFunctionsMixin(step, type, ['/// Returns itself.']).generate()).toString(),
          _emitter.visitClass(await delta.generateSealed()).toString(),
          _emitter.visitClass(delta.generateValue()).toString(),
          _emitter.visitClass(delta.generateInherit()).toString(),
          _emitter.visitClass(await delta.generateDelta()).toString(),
        ]);
      } else if (type.name == 'FThemeData') {
        generated.add(
          _emitter.visitMixin(await DesignFunctionsMixin(step, type, ['/// Returns itself.']).generate()).toString(),
        );
      }
    }

    return generated.join('\n');
  }
}
