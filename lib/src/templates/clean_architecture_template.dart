import 'dart:io';

import 'package:flutter_feature_cli/src/generator/index.dart'
    show FileGenerator;
import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;

import 'feature_template.dart';

class CleanArchitectureTemplate implements FeatureTemplate {
  static const List<String> _folders = [
    'data',
    'data/data_sources',
    'data/models',
    'data/repositories',

    'domain',
    'domain/entities',
    'domain/repositories',
    'domain/use_cases',

    'presentation',
    'presentation/pages',
    'presentation/view_models',
    'presentation/widgets',
  ];

  @override
  Future<void> generate({
    required String featureName,
    required String basePath,
  }) async {
    final className = StringUtils.pascalCase(featureName);

    final dataPath = '$basePath/data';
    final domainPath = '$basePath/domain';
    final presentationPath = '$basePath/presentation';

    final dataSourcePath = '$dataPath/data_sources';
    final modelsPath = '$dataPath/models';
    final dataRepositoriesPath = '$dataPath/repositories';

    final entitiesPath = '$domainPath/entities';
    final domainRepositoriesPath = '$domainPath/repositories';
    final useCasesPath = '$domainPath/use_cases';

    final pagesPath = '$presentationPath/pages';
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
    // DOMAIN REPOSITORY
    //

    FileGenerator.create(
      '$domainRepositoriesPath/${featureName}_repository.dart',
      '''
abstract class ${className}Repository {

}
''',
    );

    FileGenerator.create('$domainRepositoriesPath/index.dart', '''
export '${featureName}_repository.dart';
''');

    //
    // DATA REPOSITORY
    //

    FileGenerator.create(
      '$dataRepositoriesPath/${featureName}_repository_impl.dart',
      '''
import '../../domain/repositories/${featureName}_repository.dart';

class ${className}RepositoryImpl
    implements ${className}Repository {

}
''',
    );

    FileGenerator.create('$dataRepositoriesPath/index.dart', '''
export '${featureName}_repository_impl.dart';
''');

    //
    // MODELS
    //

    FileGenerator.create('$modelsPath/index.dart', '');

    //
    // ENTITIES
    //

    FileGenerator.create('$entitiesPath/index.dart', '');

    //
    // USE CASES
    //

    FileGenerator.create('$useCasesPath/index.dart', '');

    //
    // PAGES
    //

    FileGenerator.create('$pagesPath/index.dart', '');

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

    FileGenerator.create('$dataPath/index.dart', '''
export 'data_sources/index.dart';
export 'models/index.dart';
export 'repositories/index.dart';
''');

    //
    // DOMAIN INDEX
    //

    FileGenerator.create('$domainPath/index.dart', '''
export 'entities/index.dart';
export 'repositories/index.dart';
export 'use_cases/index.dart';
''');

    //
    // PRESENTATION INDEX
    //

    FileGenerator.create('$presentationPath/index.dart', '''
export 'pages/index.dart';
export 'view_models/index.dart';
export 'widgets/index.dart';
''');

    //
    // FEATURE INDEX
    //

    FileGenerator.create('$basePath/index.dart', '''
export 'data/index.dart';
export 'domain/index.dart';
export 'presentation/index.dart';
''');
  }
}
