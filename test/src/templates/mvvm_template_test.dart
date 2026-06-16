import 'dart:io';

import 'package:flutter_feature_cli/src/templates/mvvm_template.dart';
import 'package:test/test.dart';

void main() {
  group('MvvmTemplate', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('creates mvvm directory structure', () async {
      await MvvmTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      expect(Directory('$featurePath/models').existsSync(), true);

      expect(Directory('$featurePath/view_models').existsSync(), true);

      expect(Directory('$featurePath/views').existsSync(), true);

      expect(Directory('$featurePath/widgets').existsSync(), true);
    });

    test('creates all expected files', () async {
      await MvvmTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final featurePath = '${tempDir.path}/authentication';

      final files = [
        '$featurePath/index.dart',
        '$featurePath/models/index.dart',
        '$featurePath/view_models/index.dart',
        '$featurePath/views/index.dart',
        '$featurePath/widgets/index.dart',
        '$featurePath/view_models/authentication_view_model.dart',
      ];

      for (final path in files) {
        expect(File(path).existsSync(), true, reason: '$path should exist');
      }
    });

    test('creates pascal case view model name', () async {
      await MvvmTemplate().generate(
        featureName: 'user_profile',
        basePath: '${tempDir.path}/user_profile',
      );

      final file = File(
        '${tempDir.path}/user_profile/view_models/user_profile_view_model.dart',
      );

      final content = file.readAsStringSync();

      expect(content.contains('UserProfileViewModel'), true);
    });

    test('creates view model barrel export', () async {
      await MvvmTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      final file = File(
        '${tempDir.path}/authentication/view_models/index.dart',
      );

      final content = file.readAsStringSync();

      expect(
        content.contains("export 'authentication_view_model.dart';"),
        true,
      );
    });

    test('does not throw when directory already exists', () async {
      await MvvmTemplate().generate(
        featureName: 'authentication',
        basePath: '${tempDir.path}/authentication',
      );

      expect(
        () async => MvvmTemplate().generate(
          featureName: 'authentication',
          basePath: '${tempDir.path}/authentication',
        ),
        returnsNormally,
      );
    });
  });
}
