import 'dart:io';
import 'package:flutter_feature_cli/src/templates/index.dart'
    show FeatureTemplate;
import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;
import 'package:path/path.dart' as p;

/// Matches a safe, single-segment feature name: starts with a letter,
/// followed by letters, digits, underscores, or hyphens. Rejects empty
/// input, path separators, and `..` traversal in the same pass.
final _validFeatureName = RegExp(r'^[A-Za-z][A-Za-z0-9_-]*$');

/// Generates a Flutter feature directory structure.
class FeatureGenerator {
  final Map<String, FeatureTemplate> templates;

  FeatureGenerator(this.templates);

  /// Creates a feature module with the given [featureName].
  ///
  /// The generated structure includes:
  /// - Data sources
  /// - Entities
  /// - Repositories
  /// - View models
  /// - Widgets
  /// - Barrel exports (`index.dart`)
  ///
  /// By default features are created in `lib/features`,
  /// unless a custom [baseFeaturesPath] is provided.
  ///
  /// Existing generated files are left untouched unless [force] is `true`.
  Future<void> generate({
    required String featureName,
    required String templateName,
    String baseFeaturesPath = 'lib/features',
    bool force = false,
  }) async {
    if (!_validFeatureName.hasMatch(featureName)) {
      throw ArgumentError(
        '''
❌ Invalid feature name "$featureName".

Feature names must start with a letter and contain only letters, digits,
underscores, or hyphens (e.g. "user_profile", "user-profile", "userProfile").
''',
      );
    }

    final normalizedName = StringUtils.snakeCase(featureName);

    final basePath = p.join(
      Directory.current.path,
      baseFeaturesPath,
      normalizedName,
    );

    final template = templates[templateName];

    if (template == null) {
      throw ArgumentError(
        '''
❌ Unknown template "$templateName".

Available templates:
${templates.keys.map((e) => ' - $e').join('\n')}

You can configure a default template in pubspec.yaml:

flutter_feature_cli:
  template: ${templates.keys.first}
''',
      );
    }

    await template.generate(
      featureName: normalizedName,
      basePath: basePath,
      force: force,
    );

    stdout.writeln('✅ Feature "$normalizedName" generated successfully');
  }
}
