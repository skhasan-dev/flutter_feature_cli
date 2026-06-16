import 'dart:io';

import 'package:flutter_feature_cli/src/configs/config_reader.dart';
import 'package:test/test.dart';

void main() {
  group('ConfigReader', () {
    late Directory tempDir;
    late Directory originalDirectory;

    setUp(() {
      originalDirectory = Directory.current;

      tempDir = Directory.systemTemp.createTempSync();

      Directory.current = tempDir;
    });

    tearDown(() {
      Directory.current = originalDirectory;

      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('returns defaults when pubspec does not exist', () {
      final config = ConfigReader.getConfig();

      expect(config.path, 'lib/features');
      expect(config.template, 'partial_clean');
    });

    test('returns defaults when config is missing', () {
      File('pubspec.yaml').writeAsStringSync('''
name: test_app
''');

      final config = ConfigReader.getConfig();

      expect(config.path, 'lib/features');
      expect(config.template, 'partial_clean');
    });

    test('returns configured path', () {
      File('pubspec.yaml').writeAsStringSync('''
name: test_app

flutter_feature_cli:
  path: lib/src/ai_features
''');

      final config = ConfigReader.getConfig();

      expect(config.path, 'lib/src/ai_features');
      expect(config.template, 'partial_clean');
    });

    test('returns configured template', () {
      File('pubspec.yaml').writeAsStringSync('''
name: test_app

flutter_feature_cli:
  template: clean_architecture
''');

      final config = ConfigReader.getConfig();

      expect(config.path, 'lib/features');
      expect(config.template, 'clean_architecture');
    });

    test('returns configured path and template', () {
      File('pubspec.yaml').writeAsStringSync('''
name: test_app

flutter_feature_cli:
  path: lib/src/features
  template: mvvm
''');

      final config = ConfigReader.getConfig();

      expect(config.path, 'lib/src/features');
      expect(config.template, 'mvvm');
    });
  });
}
