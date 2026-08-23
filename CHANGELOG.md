# Changelog

## 1.2.0

### New Features

* Added a `custom` template, letting you declare your own folder/file structure under `flutter_feature_cli: custom:` in `pubspec.yaml` instead of using one of the built-in templates:

  ```yaml
  flutter_feature_cli:
    template: custom
    custom:
      presentation/views:
        - "{feature}_view.dart"
  ```

  ```bash
  dart run flutter_feature_cli create authentication -t custom
  ```

## 1.1.1

### Fixes

* Fixed the generator silently overwriting existing generated files on a repeated `create` run. Files that already exist are now skipped by default, with a `⚠️  Skipped (already exists): ...` message printed for each one.
* Fixed `create` accepting any feature name without validation. Empty, malformed, or path-traversal input (e.g. `../evil`) is now rejected with a clear error before anything is written to disk.
* Fixed `pascalCase` conversion only handling `snake_case` input. `kebab-case` and `camelCase` feature names (e.g. `user-profile`, `userProfile`) now produce the correct class name.
* Fixed the CLI crashing with a raw stack trace on an unknown `--template` or an invalid feature name. Both now print a clean `❌ ...` error message instead.

### New Features

* Added a `--force` / `-f` flag to explicitly overwrite existing generated files:

  ```bash
  dart run flutter_feature_cli create authentication --force
  ```

### Improvements

* Feature names are now normalized to a consistent `snake_case` for generated folder and file names regardless of how they're typed — `UserProfile`, `user-profile`, and `userProfile` all generate identical output.

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
