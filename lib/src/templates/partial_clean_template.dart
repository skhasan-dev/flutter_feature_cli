import 'dart:io';

import 'package:flutter_feature_cli/src/generator/index.dart'
    show FileGenerator;
import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;

import 'feature_template.dart';

class PartialCleanTemplate implements FeatureTemplate {
  static const List<String> _folders = [
    'data',
    'data/data_sources',
    'data/entities',
    'data/repository',
    'presentation',
    'presentation/view_models',
    'presentation/widgets',
  ];

  @override
  Future<void> generate({
    required String featureName,
    required String basePath,
  }) async {
    final className = StringUtils.pascalCase(featureName);

    final presentationPath = '$basePath/presentation';

    final dataSourcePath = '$basePath/data/data_sources';
    final repositoryPath = '$basePath/data/repository';
    final entitiesPath = '$basePath/data/entities';

    final viewModelsPath = '$presentationPath/view_models';
    final widgetsPath = '$presentationPath/widgets';

    for (final folder in _folders) {
      Directory('$basePath/$folder').createSync(recursive: true);
    }

    //
    // DATA SOURCE
    //

    FileGenerator.create('$dataSourcePath/${featureName}_data_source.dart', '''
abstract class ${className}DataSource {

}
''');

    FileGenerator.create(
      '$dataSourcePath/${featureName}_data_source_impl.dart',
      '''
import '${featureName}_data_source.dart';

class ${className}DataSourceImpl
    implements ${className}DataSource {

}
''',
    );

    FileGenerator.create('$dataSourcePath/index.dart', '''
export '${featureName}_data_source.dart';
export '${featureName}_data_source_impl.dart';
''');

    //
    // REPOSITORY
    //

    FileGenerator.create('$repositoryPath/${featureName}_repository.dart', '''
abstract class ${className}Repository {

}
''');

    FileGenerator.create(
      '$repositoryPath/${featureName}_repository_impl.dart',
      '''
import '${featureName}_repository.dart';

class ${className}RepositoryImpl
    implements ${className}Repository {

}
''',
    );

    FileGenerator.create('$repositoryPath/index.dart', '''
export '${featureName}_repository.dart';
export '${featureName}_repository_impl.dart';
''');

    //
    // ENTITIES
    //

    FileGenerator.create('$entitiesPath/index.dart', '');

    //
    // VIEW MODELS
    //

    FileGenerator.create('$viewModelsPath/index.dart', '');

    //
    // WIDGETS
    //

    FileGenerator.create('$widgetsPath/index.dart', '');

    //
    // DATA INDEX
    //

    FileGenerator.create('$basePath/data/index.dart', '''
export 'data_sources/index.dart';
export 'entities/index.dart';
export 'repository/index.dart';
''');

    //
    // PRESENTATION INDEX
    //

    FileGenerator.create('$presentationPath/index.dart', '''
export 'view_models/index.dart';
export 'widgets/index.dart';
''');

    //
    // FEATURE INDEX
    //

    FileGenerator.create('$basePath/index.dart', '''
export 'data/index.dart';
export 'presentation/index.dart';
''');
  }
}
