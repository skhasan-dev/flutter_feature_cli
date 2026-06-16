# Changelog

## 1.1.0

### New Features

* Added template-based feature generation.
* Added support for:

  * `partial_clean`
  * `clean_architecture`
  * `mvc`
  * `mvvm`
* Added template selection via:

  ```bash
  dart run flutter_feature_cli create auth --template clean_architecture
  ```
* Added shorthand template flag:

  ```bash
  dart run flutter_feature_cli create auth -t clean_architecture
  ```

### Improvements

* Added custom output path support:

  ```bash
  dart run flutter_feature_cli create auth --path lib/src/features
  ```
* Added shorthand path flag:

  ```bash
  dart run flutter_feature_cli create auth -p lib/src/features
  ```
* Improved CLI argument parsing.
* Improved CLI help and error messages.
* Improved internal architecture to support future templates and generators.

## 1.0.2

### Fixes

* Standardized CLI executable naming.
* Renamed executable from `create` to `flutter_feature_cli`.
* Fixed command execution when installed as a package dependency.
* Updated command syntax to:

```bash
dart run flutter_feature_cli create <feature_name>
```

### Improvements

* Updated README examples and usage instructions.
* Improved CLI structure to support future commands.

## 1.0.1

### Improvements

* Added API documentation comments to public APIs.
* Improved package description in `pubspec.yaml`.
* Enhanced README with detailed installation and usage instructions.

## 1.0.0

### Initial Release

* Generate Flutter feature architecture from a single command.
* Configurable feature output path via `pubspec.yaml`.
* Support command-level path overrides.
* Generate Data Sources, Entities, Repositories, View Models, and Widgets.
* Auto-generate barrel exports (`index.dart`).
* Full test coverage.
