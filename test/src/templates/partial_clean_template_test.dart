import 'dart:io';

import 'package:flutter_feature_cli/src/templates/partial_clean_template.dart';
import 'package:test/test.dart';

void main() {
  group('PartialCleanTemplate', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('creates partial clean directory structure', () async {
      await PartialCleanTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

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
      await PartialCleanTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

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

    test('creates pascal case repository name', () async {
      await PartialCleanTemplate().generate(
        featureName: 'user_profile',
        basePath: '${tempDir.path}/user_profile',
      );

      final file = File(
        '${tempDir.path}/user_profile/data/repository/user_profile_repository.dart',
      );

      final content = file.readAsStringSync();

      expect(content.contains('UserProfileRepository'), true);
    });

    test('creates repository barrel export', () async {
      await PartialCleanTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/data/repository/index.dart',
      );

      final content = file.readAsStringSync();

      expect(
        content.contains("export 'authentication_repository.dart';"),
        true,
      );

      expect(
        content.contains("export 'authentication_repository_impl.dart';"),
        true,
      );
    });

    test('creates data source barrel export', () async {
      await PartialCleanTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/data/data_sources/index.dart',
      );

      final content = file.readAsStringSync();

      expect(
        content.contains("export 'authentication_data_source.dart';"),
        true,
      );

      expect(
        content.contains("export 'authentication_data_source_impl.dart';"),
        true,
      );
    });

    test('does not throw when directory already exists', () async {
      await PartialCleanTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      expect(
        () async => PartialCleanTemplate().generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        returnsNormally,
      );
    });
  });
}
