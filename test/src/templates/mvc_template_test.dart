import 'dart:io';

import 'package:flutter_feature_cli/src/templates/mvc_template.dart';
import 'package:test/test.dart';

void main() {
  group('MvcTemplate', () {
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

    test('creates mvc directory structure', () async {
      await MvcTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      expect(Directory('$featurePath/models').existsSync(), true);

      expect(Directory('$featurePath/controllers').existsSync(), true);

      expect(Directory('$featurePath/views').existsSync(), true);

      expect(Directory('$featurePath/widgets').existsSync(), true);
    });

    test('creates all expected files', () async {
      await MvcTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      final files = [
        '$featurePath/index.dart',
        '$featurePath/models/index.dart',
        '$featurePath/controllers/index.dart',
        '$featurePath/views/index.dart',
        '$featurePath/widgets/index.dart',
        '$featurePath/controllers/authentication_controller.dart',
      ];

      for (final path in files) {
        expect(File(path).existsSync(), true, reason: '$path should exist');
      }
    });

    test('creates pascal case controller name', () async {
      await MvcTemplate().generate(
        featureName: 'user_profile',
        basePath: '${tempDir.path}/user_profile',
      );

      final file = File(
        '${tempDir.path}/user_profile/controllers/user_profile_controller.dart',
      );

      final content = file.readAsStringSync();

      expect(content.contains('UserProfileController'), true);
    });

    test('creates controller barrel export', () async {
      await MvcTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/controllers/index.dart',
      );

      final content = file.readAsStringSync();

      expect(
        content.contains("export 'authentication_controller.dart';"),
        true,
      );
    });

    test('does not throw when directory already exists', () async {
      await MvcTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      expect(
        () async => MvcTemplate().generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        returnsNormally,
      );
    });
  });
}
