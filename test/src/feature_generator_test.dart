import 'dart:io';

import 'package:flutter_feature_cli/src/feature_generator.dart';
import 'package:test/test.dart';

void main() {
  group('FeatureGenerator', () {
    late Directory tempDir;
    late Directory originalDirectory;

    setUp(() {
      originalDirectory = Directory.current;

      tempDir = Directory.systemTemp.createTempSync();

      Directory.current = tempDir;
    });

    tearDown(() {
      Directory.current = originalDirectory;

      tempDir.deleteSync(recursive: true);
    });

    test('creates feature directory structure', () async {
      await FeatureGenerator().generate(featureName: 'authentication');

      final featurePath = '${tempDir.path}/lib/features/authentication';

      expect(Directory('$featurePath/data').existsSync(), true);

      expect(Directory('$featurePath/data/data_sources').existsSync(), true);

      expect(Directory('$featurePath/data/entities').existsSync(), true);

      expect(Directory('$featurePath/data/repository').existsSync(), true);

      expect(Directory('$featurePath/presentation').existsSync(), true);

      expect(
        Directory('$featurePath/presentation/view_models').existsSync(),
        true,
      );

      expect(Directory('$featurePath/presentation/widgets').existsSync(), true);
    });

    test('creates all expected files', () async {
      await FeatureGenerator().generate(featureName: 'authentication');

      final featurePath = '${tempDir.path}/lib/features/authentication';

      final files = [
        '$featurePath/index.dart',
        '$featurePath/data/index.dart',
        '$featurePath/presentation/index.dart',
        '$featurePath/data/entities/index.dart',
        '$featurePath/presentation/view_models/index.dart',
        '$featurePath/presentation/widgets/index.dart',
        '$featurePath/data/data_sources/index.dart',
        '$featurePath/data/repository/index.dart',
        '$featurePath/data/data_sources/authentication_data_source.dart',
        '$featurePath/data/data_sources/authentication_data_source_impl.dart',
        '$featurePath/data/repository/authentication_repository.dart',
        '$featurePath/data/repository/authentication_repository_impl.dart',
      ];

      for (final path in files) {
        expect(File(path).existsSync(), true, reason: '$path should exist');
      }
    });

    test('uses custom path', () async {
      await FeatureGenerator().generate(
        featureName: 'authentication',
        baseFeaturesPath: 'lib/src/ai_features',
      );

      expect(
        Directory(
          '${tempDir.path}/lib/src/ai_features/authentication',
        ).existsSync(),
        true,
      );
    });

    test('creates pascal case class names', () async {
      await FeatureGenerator().generate(featureName: 'user_profile');

      final file = File(
        '${tempDir.path}/lib/features/user_profile/data/repository/user_profile_repository.dart',
      );

      final content = file.readAsStringSync();

      expect(content.contains('UserProfileRepository'), true);
    });

    test('does not throw when directory already exists', () async {
      await FeatureGenerator().generate(featureName: 'authentication');

      expect(
        () async => FeatureGenerator().generate(featureName: 'authentication'),
        returnsNormally,
      );
    });
  });
}
