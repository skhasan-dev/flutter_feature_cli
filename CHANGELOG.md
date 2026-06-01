# Changelog

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
