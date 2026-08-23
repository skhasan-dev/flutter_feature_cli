import 'dart:io';

class FileGenerator {
  static void create(String path, String content, {bool force = false}) {
    final file = File(path);

    if (file.existsSync() && !force) {
      stdout.writeln('⚠️  Skipped (already exists): $path');
      return;
    }

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    file.writeAsStringSync(content);
  }
}
