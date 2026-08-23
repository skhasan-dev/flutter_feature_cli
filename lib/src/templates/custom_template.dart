import 'dart:io';

import 'package:flutter_feature_cli/src/generator/index.dart'
    show FileGenerator;
import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;

import 'feature_template.dart';

class _Node {
  final Map<String, _Node> children = {};
  List<String> files = const [];
}

/// Generates a feature structure declared by the user under
/// `flutter_feature_cli: custom:` in `pubspec.yaml`, mapping folder paths to
/// the explicit list of files each folder should contain.
class CustomTemplate implements FeatureTemplate {
  final Map<String, List<String>>? structure;

  static final _validFolderSegment = RegExp(r'^[A-Za-z][A-Za-z0-9_]*$');
  static final _validFileName = RegExp(r'^[A-Za-z0-9_]+\.dart$');

  const CustomTemplate(this.structure);

  @override
  Future<void> generate({
    required String featureName,
    required String basePath,
    bool force = false,
  }) async {
    final structure = this.structure;

    if (structure == null || structure.isEmpty) {
      throw ArgumentError(
        '''
❌ No custom structure configured for template "custom".

Define the folders and files to generate under `custom` in pubspec.yaml:

flutter_feature_cli:
  template: custom
  custom:
    presentation/views:
      - "{feature}_view.dart"
    domain/entities:
      - "{feature}_entity.dart"
''',
      );
    }

    final root = _buildTree(structure);

    await _generateNode(root, basePath, featureName, force);
  }

  _Node _buildTree(Map<String, List<String>> structure) {
    final root = _Node();

    for (final entry in structure.entries) {
      var node = root;

      for (final segment in _validatedSegments(entry.key)) {
        node = node.children.putIfAbsent(segment, () => _Node());
      }

      node.files = entry.value;
    }

    return root;
  }

  List<String> _validatedSegments(String folderPath) {
    final segments = folderPath.split('/');

    for (final segment in segments) {
      if (!_validFolderSegment.hasMatch(segment)) {
        throw ArgumentError(
          '''
❌ Invalid folder path "$folderPath" in custom template configuration.

Each path segment must start with a letter and contain only letters, digits,
or underscores (e.g. "presentation/views").
''',
        );
      }
    }

    return segments;
  }

  Future<void> _generateNode(
    _Node node,
    String path,
    String featureName,
    bool force,
  ) async {
    Directory(path).createSync(recursive: true);

    final exports = <String>[];

    for (final rawFileName in node.files) {
      final fileName = rawFileName.replaceAll('{feature}', featureName);

      if (!_validFileName.hasMatch(fileName)) {
        throw ArgumentError(
          '''
❌ Invalid filename "$rawFileName" in custom template configuration.

Filenames must resolve to letters, digits, and underscores, and end with
".dart" (e.g. "{feature}_view.dart").
''',
        );
      }

      final className = StringUtils.pascalCase(
        fileName.substring(0, fileName.length - '.dart'.length),
      );

      FileGenerator.create(
        '$path/$fileName',
        '''
class $className {

}
''',
        force: force,
      );

      exports.add(fileName);
    }

    for (final childName in node.children.keys) {
      await _generateNode(
        node.children[childName]!,
        '$path/$childName',
        featureName,
        force,
      );
      exports.add('$childName/index.dart');
    }

    FileGenerator.create(
      '$path/index.dart',
      exports.isEmpty
          ? ''
          : '${exports.map((e) => "export '$e';").join('\n')}\n',
      force: force,
    );
  }
}
