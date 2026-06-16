import 'dart:io';

import 'package:flutter_feature_cli/src/generator/index.dart'
    show FileGenerator;
import 'package:flutter_feature_cli/src/templates/index.dart'
    show FeatureTemplate;
import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;

class MvcTemplate implements FeatureTemplate {
  static const List<String> _folders = [
    'models',
    'controllers',
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
    final controllersPath = '$basePath/controllers';
    final viewsPath = '$basePath/views';
    final widgetsPath = '$basePath/widgets';

    for (final folder in _folders) {
      Directory('$basePath/$folder').createSync(recursive: true);
    }

    //
    // CONTROLLER
    //

    FileGenerator.create('$controllersPath/${featureName}_controller.dart', '''
class ${className}Controller {

}
''');

    FileGenerator.create('$controllersPath/index.dart', '''
export '${featureName}_controller.dart';
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
export 'controllers/index.dart';
export 'views/index.dart';
export 'widgets/index.dart';
''');
  }
}
