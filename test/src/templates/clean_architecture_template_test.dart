import 'dart:io';

import 'package:flutter_feature_cli/src/templates/clean_architecture_template.dart';
import 'package:test/test.dart';

void main() {
  group('CleanArchitectureTemplate', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('creates clean architecture directory structure', () async {
      await CleanArchitectureTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      expect(Directory('$featurePath/data').existsSync(), true);
      expect(Directory('$featurePath/domain').existsSync(), true);
      expect(Directory('$featurePath/presentation').existsSync(), true);

      expect(Directory('$featurePath/data/data_sources').existsSync(), true);

      expect(Directory('$featurePath/data/models').existsSync(), true);

      expect(Directory('$featurePath/data/repositories').existsSync(), true);

      expect(Directory('$featurePath/domain/entities').existsSync(), true);

      expect(Directory('$featurePath/domain/repositories').existsSync(), true);

      expect(Directory('$featurePath/domain/use_cases').existsSync(), true);

      expect(Directory('$featurePath/presentation/pages').existsSync(), true);

      expect(
        Directory('$featurePath/presentation/view_models').existsSync(),
        true,
      );

      expect(Directory('$featurePath/presentation/widgets').existsSync(), true);
    });

    test('creates all expected files', () async {
      await CleanArchitectureTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      final files = [
        '$featurePath/index.dart',

        '$featurePath/data/index.dart',
        '$featurePath/domain/index.dart',
        '$featurePath/presentation/index.dart',

        '$featurePath/data/data_sources/index.dart',
        '$featurePath/data/models/index.dart',
        '$featurePath/data/repositories/index.dart',

        '$featurePath/domain/entities/index.dart',
        '$featurePath/domain/repositories/index.dart',
        '$featurePath/domain/use_cases/index.dart',

        '$featurePath/presentation/pages/index.dart',
        '$featurePath/presentation/view_models/index.dart',
        '$featurePath/presentation/widgets/index.dart',

        '$featurePath/data/data_sources/authentication_data_source.dart',
        '$featurePath/data/data_sources/authentication_data_source_impl.dart',

        '$featurePath/domain/repositories/authentication_repository.dart',

        '$featurePath/data/repositories/authentication_repository_impl.dart',
      ];

      for (final path in files) {
        expect(File(path).existsSync(), true, reason: '$path should exist');
      }
    });

    test('creates pascal case repository name', () async {
      await CleanArchitectureTemplate().generate(
        featureName: 'user_profile',
        basePath: '${tempDir.path}/user_profile',
      );

      final file = File(
        '${tempDir.path}/user_profile/domain/repositories/user_profile_repository.dart',
      );

      final content = file.readAsStringSync();

      expect(content.contains('UserProfileRepository'), true);
    });

    test('repository implementation imports domain repository', () async {
      await CleanArchitectureTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/data/repositories/authentication_repository_impl.dart',
      );

      final content = file.readAsStringSync();

      expect(
        content.contains(
          "import '../../domain/repositories/authentication_repository.dart';",
        ),
        true,
      );
    });

    test('creates repository barrel exports', () async {
      await CleanArchitectureTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final domainRepositoryIndex = File(
        '${tempDir.path}/authentication/domain/repositories/index.dart',
      );

      final dataRepositoryIndex = File(
        '${tempDir.path}/authentication/data/repositories/index.dart',
      );

      expect(
        domainRepositoryIndex.readAsStringSync().contains(
          "export 'authentication_repository.dart';",
        ),
        true,
      );

      expect(
        dataRepositoryIndex.readAsStringSync().contains(
          "export 'authentication_repository_impl.dart';",
        ),
        true,
      );
    });

    test('does not throw when directory already exists', () async {
      await CleanArchitectureTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      expect(
        () async => CleanArchitectureTemplate().generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        returnsNormally,
      );
    });
  });
}
