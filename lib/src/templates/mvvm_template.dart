import 'dart:io';

import 'package:flutter_feature_cli/src/generator/index.dart'
    show FileGenerator;
import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;

import 'feature_template.dart';

class MvvmTemplate implements FeatureTemplate {
  static const List<String> _folders = [
    'models',
    'view_models',
    'views',
    'widgets',
  ];

  @override
  Future<void> generate({
    required String featureName,
    required String basePath,
  }) async {
    final className = StringUtils.pascalCase(featureName);

    final modelsPath = '$basePath/models';
    final viewModelsPath = '$basePath/view_models';
    final viewsPath = '$basePath/views';
    final widgetsPath = '$basePath/widgets';

    for (final folder in _folders) {
      Directory('$basePath/$folder').createSync(recursive: true);
    }

    //
    // VIEW MODEL
    //

    FileGenerator.create('$viewModelsPath/${featureName}_view_model.dart', '''
class ${className}ViewModel {

}
''');

    FileGenerator.create('$viewModelsPath/index.dart', '''
export '${featureName}_view_model.dart';
''');

    //
    // MODELS
    //

    FileGenerator.create('$modelsPath/index.dart', '');

    //
    // VIEWS
    //

    FileGenerator.create('$viewsPath/index.dart', '');

    //
    // WIDGETS
    //

    FileGenerator.create('$widgetsPath/index.dart', '');

    //
    // ROOT INDEX
    //

    FileGenerator.create('$basePath/index.dart', '''
export 'models/index.dart';
export 'view_models/index.dart';
export 'views/index.dart';
export 'widgets/index.dart';
''');
  }
}
