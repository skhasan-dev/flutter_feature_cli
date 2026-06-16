import 'dart:io';
import 'package:flutter_feature_cli/src/templates/index.dart'
    show FeatureTemplate;
import 'package:path/path.dart' as p;

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
  Future<void> generate({
    required String featureName,
    required String templateName,
    String baseFeaturesPath = 'lib/features',
  }) async {
    final basePath = p.join(
      Directory.current.path,
      baseFeaturesPath,
      featureName,
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

    await template.generate(featureName: featureName, basePath: basePath);

    stdout.writeln('✅ Feature "$featureName" generated successfully');
  }
}
