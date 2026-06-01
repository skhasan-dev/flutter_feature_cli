import 'dart:io';

import 'package:flutter_feature_cli/flutter_feature_cli.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    exit(1);
  }

  final command = args.first;

  switch (command) {
    case 'create':
      await _handleCreate(args);
      break;

    case '--help':
    case '-h':
    case 'help':
      _printUsage();
      break;

    default:
      stderr.writeln('Unknown command: $command');
      _printUsage();
      exit(1);
  }
}

Future<void> _handleCreate(List<String> args) async {
  if (args.length < 2) {
    stderr.writeln('Feature name is required.');
    _printUsage();
    exit(1);
  }

  final featureName = args[1];

  var path = ConfigReader.getPath();

  for (final arg in args.skip(2)) {
    if (arg.startsWith('--path=')) {
      path = arg.substring('--path='.length);
    }
  }

  await FeatureGenerator().generate(
    featureName: featureName,
    baseFeaturesPath: path,
  );
}

void _printUsage() {
  stdout.writeln('''
Flutter Feature CLI

Usage:
  flutter_feature_cli create <feature_name>

Options:
  --path=<path>

Examples:
  flutter_feature_cli create auth

  flutter_feature_cli create user_profile

  flutter_feature_cli create ai_chat --path=lib/src/ai_features
''');
}
