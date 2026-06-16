import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_feature_cli/src/configs/index.dart' show ConfigReader;
import 'package:flutter_feature_cli/src/generator/index.dart'
    show FeatureGenerator;
import 'package:flutter_feature_cli/src/templates/index.dart'
    show
        CleanArchitectureTemplate,
        MvcTemplate,
        MvvmTemplate,
        PartialCleanTemplate,
        TemplateNames;

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    exit(1);
  }

  final command = args.first;

  switch (command) {
    case 'create':
      await _handleCreate(args.skip(1).toList());
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
  try {
    final parser = ArgParser()
      ..addOption('template', abbr: 't', defaultsTo: 'partial_clean')
      ..addOption('path', abbr: 'p', defaultsTo: ConfigReader.getPath());

    final results = parser.parse(args);

    if (results.rest.isEmpty) {
      stderr.writeln('Feature name is required.');
      _printUsage();
      exit(1);
    }

    final featureName = results.rest.first;

    await FeatureGenerator({
      TemplateNames.partialClean: PartialCleanTemplate(),
      TemplateNames.cleanArchitecture: CleanArchitectureTemplate(),
      TemplateNames.mvc: MvcTemplate(),
      TemplateNames.mvvm: MvvmTemplate(),
    }).generate(
      featureName: featureName,
      templateName: results['template'] as String,
      baseFeaturesPath: results['path'] as String,
    );
  } on FormatException catch (e) {
    stderr.writeln('❌ ${e.message}');
    stderr.writeln('');
    _printUsage();
    exit(1);
  }
}

void _printUsage() {
  stdout.writeln('''
Flutter Feature CLI

Usage:
  flutter_feature_cli create <feature_name>

Options:
  --template, -t   Feature template

  --path, -p       Output path

Templates:
  partial_clean
  clean_architecture
  mvc
  mvvm

Examples:

  flutter_feature_cli create auth

  flutter_feature_cli create auth --template clean_architecture

  flutter_feature_cli create auth -t mvvm

  flutter_feature_cli create auth --path lib/src/features

  flutter_feature_cli create auth -t clean_architecture -p lib/src/features
''');
}
