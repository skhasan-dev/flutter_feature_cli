import 'dart:io';

import 'package:yaml/yaml.dart';

class ConfigReader {
  static const _configKey = 'flutter_feature_cli';

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
