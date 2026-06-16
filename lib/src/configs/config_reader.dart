import 'dart:io';

import 'package:flutter_feature_cli/src/configs/index.dart' show CliConfig;
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
  static CliConfig getConfig() {
    final file = File('pubspec.yaml');

    if (!file.existsSync()) {
      return const CliConfig(
        path: 'lib/features',
        template: 'partial_clean',
      );
    }

    final yaml = loadYaml(file.readAsStringSync());

    final config = yaml[_configKey];

    if (config == null) {
      return const CliConfig(
        path: 'lib/features',
        template: 'partial_clean',
      );
    }

    return CliConfig(
      path: config['path']?.toString() ?? 'lib/features',
      template: config['template']?.toString() ?? 'partial_clean',
    );
  }
}
