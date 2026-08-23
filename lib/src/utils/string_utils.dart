class StringUtils {
  static List<String> _words(String text) {
    final withBoundaries = text.replaceAllMapped(
      RegExp(r'(?<=[a-z0-9])(?=[A-Z])'),
      (match) => '_',
    );

    return withBoundaries
        .split(RegExp(r'[_\-\s]+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word.toLowerCase())
        .toList();
  }

  static String pascalCase(String text) {
    return _words(
      text,
    ).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  static String snakeCase(String text) {
    return _words(text).join('_');
  }
}
