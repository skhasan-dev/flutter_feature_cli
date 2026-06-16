import 'dart:io';

import 'package:yaml/yaml.dart';

/// Reads `flutter_feature_cli` configuration from `pubspec.yaml`.
class ConfigReader {
  static const _configKey = 'flutter_feature_cli';

  /// Returns the configured feature output path.
  ///
  /// Falls back to `lib/features` when:
  /// - `pubspec.yaml` does not exist.
  /// - `flutter_feature_cli` configuration is missing.
  /// - `path` is not specified.
  static String getPath() {
    final file = File('pubspec.yaml');

    if (!file.existsSync()) {
      return 'lib/features';
    }

    final yaml = loadYaml(file.readAsStringSync());

    final config = yaml[_configKey];

    if (config == null) {
      return 'lib/features';
    }

    return config['path']?.toString() ?? 'lib/features';
  }
}
