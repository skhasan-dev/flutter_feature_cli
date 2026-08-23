abstract class FeatureTemplate {
  Future<void> generate({
    required String featureName,
    required String basePath,
    bool force = false,
  });
}
