class CliConfig {
  final String path;
  final String template;
  final Map<String, List<String>>? custom;

  const CliConfig({
    required this.path,
    required this.template,
    this.custom,
  });
}
