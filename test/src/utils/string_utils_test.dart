import 'package:flutter_feature_cli/src/utils/index.dart' show StringUtils;
import 'package:test/test.dart';

void main() {
  group('StringUtils', () {
    group('pascalCase', () {
      test('converts snake_case', () {
        expect(StringUtils.pascalCase('user_profile'), 'UserProfile');
      });

      test('converts kebab-case', () {
        expect(StringUtils.pascalCase('user-profile'), 'UserProfile');
      });

      test('converts camelCase', () {
        expect(StringUtils.pascalCase('userProfile'), 'UserProfile');
      });

      test('converts already-PascalCase input', () {
        expect(StringUtils.pascalCase('UserProfile'), 'UserProfile');
      });

      test('converts space separated words', () {
        expect(StringUtils.pascalCase('user profile'), 'UserProfile');
      });

      test('inserts a boundary between a digit and an uppercase letter', () {
        expect(StringUtils.pascalCase('v2Info'), 'V2Info');
      });

      test('handles a single word', () {
        expect(StringUtils.pascalCase('auth'), 'Auth');
      });

      test('handles an empty string', () {
        expect(StringUtils.pascalCase(''), '');
      });
    });

    group('snakeCase', () {
      test('converts camelCase', () {
        expect(StringUtils.snakeCase('userProfile'), 'user_profile');
      });

      test('converts PascalCase', () {
        expect(StringUtils.snakeCase('UserProfile'), 'user_profile');
      });

      test('converts kebab-case', () {
        expect(StringUtils.snakeCase('user-profile'), 'user_profile');
      });

      test('leaves already-snake_case input unchanged', () {
        expect(StringUtils.snakeCase('user_profile'), 'user_profile');
      });

      test('handles a single word', () {
        expect(StringUtils.snakeCase('auth'), 'auth');
      });

      test('handles an empty string', () {
        expect(StringUtils.snakeCase(''), '');
      });
    });
  });
}
