import 'dart:io';

import 'package:flutter_feature_cli/src/generator/feature_generator.dart';
import 'package:flutter_feature_cli/src/templates/index.dart';
import 'package:test/test.dart';

void main() {
  group('FeatureGenerator', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    FeatureGenerator createGenerator() {
      return FeatureGenerator({
        TemplateNames.partialClean: PartialCleanTemplate(),
        TemplateNames.cleanArchitecture: CleanArchitectureTemplate(),
        TemplateNames.mvc: MvcTemplate(),
        TemplateNames.mvvm: MvvmTemplate(),
      });
    }

    test('creates feature using partial clean template', () async {
      await createGenerator().generate(
        featureName: 'auth',
        templateName: TemplateNames.partialClean,
        baseFeaturesPath: tempDir.path,
      );

      expect(Directory('${tempDir.path}/auth/data').existsSync(), true);
    });

    test('creates feature using clean architecture template', () async {
      await createGenerator().generate(
        featureName: 'auth',
        templateName: TemplateNames.cleanArchitecture,
        baseFeaturesPath: tempDir.path,
      );

      expect(Directory('${tempDir.path}/auth/domain').existsSync(), true);
    });

    test('creates feature using mvc template', () async {
      await createGenerator().generate(
        featureName: 'auth',
        templateName: TemplateNames.mvc,
        baseFeaturesPath: tempDir.path,
      );

      expect(Directory('${tempDir.path}/auth/controllers').existsSync(), true);
    });

    test('creates feature using mvvm template', () async {
      await createGenerator().generate(
        featureName: 'auth',
        templateName: TemplateNames.mvvm,
        baseFeaturesPath: tempDir.path,
      );

      expect(Directory('${tempDir.path}/auth/view_models').existsSync(), true);
    });

    test('throws for unknown template', () {
      expect(
        () => createGenerator().generate(
          featureName: 'auth',
          templateName: 'invalid_template',
          baseFeaturesPath: tempDir.path,
        ),
        throwsArgumentError,
      );
    });
  });
}
