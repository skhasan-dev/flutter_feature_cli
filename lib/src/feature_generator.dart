import 'dart:io';
import 'package:path/path.dart' as p;

class FeatureGenerator {
  Future<void> generate({
    required String featureName,
    String baseFeaturesPath = 'lib/features',
  }) async {
    final className = _pascalCase(featureName);

    final basePath = p.join(
      Directory.current.path,
      baseFeaturesPath,
      featureName,
    );

    final folders = [
      'data',
      'data/data_sources',
      'data/entities',
      'data/repository',
      'presentation',
      'presentation/view_models',
      'presentation/widgets',
    ];

    for (final folder in folders) {
      Directory('$basePath/$folder').createSync(recursive: true);
    }

    //
    // DATA SOURCE
    //

    _createFile(
      '$basePath/data/data_sources/${featureName}_data_source.dart',
      '''
abstract class ${className}DataSource {

}
''',
    );

    _createFile(
      '$basePath/data/data_sources/${featureName}_data_source_impl.dart',
      '''
import '${featureName}_data_source.dart';

class ${className}DataSourceImpl
    implements ${className}DataSource {

}
''',
    );

    _createFile('$basePath/data/data_sources/index.dart', '''
export '${featureName}_data_source.dart';
export '${featureName}_data_source_impl.dart';
''');

    //
    // REPOSITORY
    //

    _createFile('$basePath/data/repository/${featureName}_repository.dart', '''
abstract class ${className}Repository {

}
''');

    _createFile(
      '$basePath/data/repository/${featureName}_repository_impl.dart',
      '''
import '${featureName}_repository.dart';

class ${className}RepositoryImpl
    implements ${className}Repository {

}
''',
    );

    _createFile('$basePath/data/repository/index.dart', '''
export '${featureName}_repository.dart';
export '${featureName}_repository_impl.dart';
''');

    //
    // ENTITIES
    //

    _createFile('$basePath/data/entities/index.dart', '');

    //
    // VIEW MODELS
    //

    _createFile('$basePath/presentation/view_models/index.dart', '');

    //
    // WIDGETS
    //

    _createFile('$basePath/presentation/widgets/index.dart', '');

    //
    // DATA INDEX
    //

    _createFile('$basePath/data/index.dart', '''
export 'data_sources/index.dart';
export 'entities/index.dart';
export 'repository/index.dart';
''');

    //
    // PRESENTATION INDEX
    //

    _createFile('$basePath/presentation/index.dart', '''
export 'view_models/index.dart';
export 'widgets/index.dart';
''');

    //
    // FEATURE INDEX
    //

    _createFile('$basePath/index.dart', '''
export 'data/index.dart';
export 'presentation/index.dart';
''');

    stdout.writeln('✅ Feature "$featureName" generated successfully');
  }

  void _createFile(String filePath, String content) {
    final file = File(filePath);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    file.writeAsStringSync(content);
  }

  String _pascalCase(String text) {
    return text
        .split('_')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join();
  }
}
