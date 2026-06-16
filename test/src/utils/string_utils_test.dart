import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;
import 'package:test/test.dart';

void main() {
  group('Class Name Test', () {
    test('should return PascalCaseNames for the inputs', () {
      expect(StringUtils.pascalCase('user_profile'), 'UserProfile');
      expect(StringUtils.pascalCase('auth'), 'Auth');
      expect(StringUtils.pascalCase(''), '');
    });
  });
}
