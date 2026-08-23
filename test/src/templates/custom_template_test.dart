import 'dart:io';

import 'package:flutter_feature_cli/src/templates/custom_template.dart';
import 'package:test/test.dart';

void main() {
  group('CustomTemplate', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('throws when no structure is configured', () {
      expect(
        () => CustomTemplate(null).generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        throwsArgumentError,
      );
    });

    test('throws when structure is empty', () {
      expect(
        () => CustomTemplate(const {}).generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        throwsArgumentError,
      );
    });

    test('creates declared folders, including implied parents', () async {
      await CustomTemplate({
        'data/data_sources': ['{feature}_data_source.dart'],
        'presentation/widgets': <String>[],
      }).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      expect(Directory('$featurePath/data').existsSync(), true);

      expect(Directory('$featurePath/data/data_sources').existsSync(), true);

      expect(Directory('$featurePath/presentation').existsSync(), true);

      expect(
        Directory('$featurePath/presentation/widgets').existsSync(),
        true,
      );
    });

    test('substitutes {feature} and creates all expected files', () async {
      await CustomTemplate({
        'presentation/views': [
          '{feature}_view.dart',
          '{feature}_view_state.dart',
        ],
      }).generate(
        featureName: 'user_profile',
        basePath: '${tempDir.path}/user_profile',
      );

      final featurePath = '${tempDir.path}/user_profile';

      final files = [
        '$featurePath/index.dart',
        '$featurePath/presentation/index.dart',
        '$featurePath/presentation/views/index.dart',
        '$featurePath/presentation/views/user_profile_view.dart',
        '$featurePath/presentation/views/user_profile_view_state.dart',
      ];

      for (final path in files) {
        expect(File(path).existsSync(), true, reason: '$path should exist');
      }
    });

    test('creates a pascal case class stub for each file', () async {
      await CustomTemplate({
        'presentation/views': ['{feature}_view.dart'],
      }).generate(
        featureName: 'user_profile',
        basePath: '${tempDir.path}/user_profile',
      );

      final content = File(
        '${tempDir.path}/user_profile/presentation/views/user_profile_view.dart',
      ).readAsStringSync();

      expect(content.contains('class UserProfileView'), true);
    });

    test('leaf folder barrel exports its declared files', () async {
      await CustomTemplate({
        'presentation/views': [
          '{feature}_view.dart',
          '{feature}_view_state.dart',
        ],
      }).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final content = File(
        '${tempDir.path}/authentication/presentation/views/index.dart',
      ).readAsStringSync();

      expect(content.contains("export 'authentication_view.dart';"), true);

      expect(
        content.contains("export 'authentication_view_state.dart';"),
        true,
      );
    });

    test('implied parent folder barrel exports its child folder', () async {
      await CustomTemplate({
        'presentation/views': ['{feature}_view.dart'],
      }).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final content = File(
        '${tempDir.path}/authentication/presentation/index.dart',
      ).readAsStringSync();

      expect(content.contains("export 'views/index.dart';"), true);
    });

    test('root index exports every top-level folder', () async {
      await CustomTemplate({
        'data/data_sources': ['{feature}_data_source.dart'],
        'domain/entities': ['{feature}_entity.dart'],
      }).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final content = File(
        '${tempDir.path}/authentication/index.dart',
      ).readAsStringSync();

      expect(content.contains("export 'data/index.dart';"), true);

      expect(content.contains("export 'domain/index.dart';"), true);
    });

    test('folder with no declared files still gets a bare index.dart', () async {
      await CustomTemplate({
        'presentation/widgets': <String>[],
      }).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/presentation/widgets/index.dart',
      );

      expect(file.existsSync(), true);

      expect(file.readAsStringSync(), '');
    });

    test('throws for a folder path containing traversal', () {
      expect(
        () => CustomTemplate({
          '../evil': ['{feature}_x.dart'],
        }).generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        throwsArgumentError,
      );
    });

    test('throws for a folder path segment starting with a digit', () {
      expect(
        () => CustomTemplate({
          '1invalid': ['{feature}_x.dart'],
        }).generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        throwsArgumentError,
      );
    });

    test('throws for a filename with characters outside [A-Za-z0-9_]', () {
      expect(
        () => CustomTemplate({
          'presentation/views': ['{feature}-view.dart'],
        }).generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        throwsArgumentError,
      );
    });

    test('does not throw when directory already exists', () async {
      final config = {
        'presentation/views': ['{feature}_view.dart'],
      };

      await CustomTemplate(config).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      expect(
        () async => CustomTemplate(config).generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        returnsNormally,
      );
    });

    test('does not overwrite an existing file without force', () async {
      final config = {
        'presentation/views': ['{feature}_view.dart'],
      };

      await CustomTemplate(config).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/presentation/views/authentication_view.dart',
      );

      file.writeAsStringSync('// hand-edited');

      await CustomTemplate(config).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      expect(file.readAsStringSync(), '// hand-edited');
    });

    test('force overwrites an existing generated file', () async {
      final config = {
        'presentation/views': ['{feature}_view.dart'],
      };

      await CustomTemplate(config).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/presentation/views/authentication_view.dart',
      );

      file.writeAsStringSync('// hand-edited');

      await CustomTemplate(config).generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
        force: true,
      );

      expect(
        file.readAsStringSync().contains('class AuthenticationView'),
        true,
      );
    });
  });
}
