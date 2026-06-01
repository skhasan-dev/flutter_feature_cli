import 'dart:io';

import 'package:flutter_feature_cli/src/config_reader.dart';
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
      tempDir.deleteSync(recursive: true);
    });

    test('returns default path when pubspec does not exist', () {
      expect(ConfigReader.getPath(), 'lib/features');
    });

    test('returns default path when config is missing', () {
      File('pubspec.yaml').writeAsStringSync('''
name: test_app
''');

      expect(ConfigReader.getPath(), 'lib/features');
    });

    test('returns configured path', () {
      File('pubspec.yaml').writeAsStringSync('''
name: test_app

flutter_feature_cli:
  path: lib/src/ai_features
''');

      expect(ConfigReader.getPath(), 'lib/src/ai_features');
    });
  });
}
