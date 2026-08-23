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
      custom: _readCustom(config['custom']),
    );
  }

  /// Converts the `custom` YAML block (folder path -> list of filenames)
  /// into a plain `Map<String, List<String>>`, or `null` if absent.
  static Map<String, List<String>>? _readCustom(dynamic custom) {
    if (custom == null) return null;

    if (custom is! YamlMap) {
      throw const FormatException(
        '''
❌ Invalid `custom` configuration in pubspec.yaml.

`custom` must map folder paths to a list of filenames, e.g.:

flutter_feature_cli:
  template: custom
  custom:
    presentation/views:
      - "{feature}_view.dart"
''',
      );
    }

    return custom.map((key, value) {
      if (value is! YamlList) {
        throw FormatException(
          '''
❌ Invalid `custom` configuration for "$key" in pubspec.yaml.

Expected a list of filenames, e.g.:

flutter_feature_cli:
  custom:
    $key:
      - "{feature}_$key.dart"
''',
        );
      }

      return MapEntry(
        key.toString(),
        value.map((e) => e.toString()).toList(),
      );
    });
  }
}
