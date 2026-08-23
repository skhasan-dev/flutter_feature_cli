# 🚀 Flutter Feature CLI

Generate Flutter feature architecture in seconds.

A lightweight CLI tool that scaffolds feature modules using popular architectural patterns such as Partial Clean Architecture, Clean Architecture, MVC, and MVVM.

---

## ✨ Features

* Generate complete feature structures instantly
* Supports multiple architecture templates:

  * Partial Clean Architecture
  * Clean Architecture
  * MVC
  * MVVM
  * Custom (define your own folder/file structure via `pubspec.yaml`)
* Configurable output path via `pubspec.yaml`
* Supports command-level path overrides
* Auto-generates barrel exports (`index.dart`)
* Reduces repetitive boilerplate code
* Accepts `snake_case`, `kebab-case`, or `camelCase` feature names — normalized consistently either way
* Never overwrites existing generated files unless `--force` is passed
* Fully tested and production-ready

---

## 📦 Installation

Add the package to your Flutter project:

```yaml
dev_dependencies:
  flutter_feature_cli: ^1.2.0
```

Install dependencies:

```bash
flutter pub get
```

---

## ⚙️ Configuration (Optional)

Configure a default feature generation path in your project's `pubspec.yaml`.

```yaml
flutter_feature_cli:
  path: lib/src/features
```

If omitted, the package falls back to:

```text
lib/features
```

---

## 🚀 Create a Feature

Generate a feature using the default template (`partial_clean`):

```bash
dart run flutter_feature_cli create authentication
```

---

## 🏗 Templates

### Partial Clean Architecture (Default)

```bash
dart run flutter_feature_cli create authentication
```

Generated structure:

```text
authentication/
├── data/
│   ├── data_sources/
│   ├── entities/
│   └── repository/
│
├── presentation/
│   ├── view_models/
│   └── widgets/
│
└── index.dart
```

---

### Clean Architecture

```bash
dart run flutter_feature_cli create authentication \
  --template clean_architecture
```

or

```bash
dart run flutter_feature_cli create authentication \
  -t clean_architecture
```

Generated structure:

```text
authentication/
├── data/
│   ├── data_sources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── use_cases/
│
├── presentation/
│   ├── pages/
│   ├── view_models/
│   └── widgets/
│
└── index.dart
```

---

### MVC

```bash
dart run flutter_feature_cli create authentication \
  -t mvc
```

Generated structure:

```text
authentication/
├── models/
├── controllers/
├── views/
├── widgets/
└── index.dart
```

---

### MVVM

```bash
dart run flutter_feature_cli create authentication \
  -t mvvm
```

Generated structure:

```text
authentication/
├── models/
├── view_models/
├── views/
├── widgets/
└── index.dart
```

---

### Custom

Define your own folder/file structure in `pubspec.yaml` instead of using one of
the built-in templates. Keys are folder paths relative to the feature root;
values are the explicit list of filenames to create in each folder. Use
`{feature}` in a filename as a placeholder for the (normalized) feature name.

```yaml
flutter_feature_cli:
  template: custom
  custom:
    data/data_sources:
      - "{feature}_data_source.dart"
    domain/entities:
      - "{feature}_entity.dart"
    presentation/views:
      - "{feature}_view.dart"
      - "{feature}_view_state.dart"
    presentation/widgets: []
```

```bash
dart run flutter_feature_cli create authentication -t custom
```

Generated structure:

```text
authentication/
├── data/
│   ├── data_sources/
│   │   ├── authentication_data_source.dart
│   │   └── index.dart
│   └── index.dart
├── domain/
│   ├── entities/
│   │   ├── authentication_entity.dart
│   │   └── index.dart
│   └── index.dart
├── presentation/
│   ├── views/
│   │   ├── authentication_view.dart
│   │   ├── authentication_view_state.dart
│   │   └── index.dart
│   ├── widgets/
│   │   └── index.dart
│   └── index.dart
└── index.dart
```

Every folder — including ones only implied by nesting, like `data/` above —
gets its own barrel `index.dart`, matching the other templates. An empty file
list (like `presentation/widgets` above) still creates the folder with just a
barrel file.

#### Directories only, no generated files

To get a folder without any generated `{feature}_*.dart` stub — just the
directory itself — give it an empty list:

```yaml
flutter_feature_cli:
  template: custom
  custom:
    core/constants: []
    core/utils: []
```

This creates `core/constants/` and `core/utils/` with no other files inside.
Note that a bare `index.dart` (empty content) is still generated in each one —
that's intentional, both to match the barrel-export convention every other
template follows and because git can't track a truly empty directory.

#### A folder with both files and a subfolder

A folder can own files *and* have a subfolder — declare the parent path with
its own files, and the nested path separately:

```yaml
flutter_feature_cli:
  template: custom
  custom:
    test1:
      - "{feature}_test1.dart"
    test1/sub:
      - "{feature}_sub.dart"
```

```text
test1/
├── sub/
│   ├── {feature}_sub.dart
│   └── index.dart
├── {feature}_test1.dart
└── index.dart
```

`test1/index.dart` exports both: its own file first, then `sub/index.dart`.

---

## 🎯 Custom Output Path

Override the configured path directly from the command:

```bash
dart run flutter_feature_cli create authentication \
  --path lib/src/features
```

or

```bash
dart run flutter_feature_cli create authentication \
  -p lib/src/features
```

You can combine both options:

```bash
dart run flutter_feature_cli create authentication \
  -t clean_architecture \
  -p lib/src/features
```

The command-line path always takes precedence over the path configured in `pubspec.yaml`.

---

## 🛡 Overwrite Protection

By default, `create` never overwrites a file that already exists — safe to re-run on a feature you've already started editing:

```bash
dart run flutter_feature_cli create authentication
```

```text
⚠️  Skipped (already exists): lib/features/authentication/data/repository/authentication_repository.dart
```

Pass `--force` (or `-f`) to explicitly overwrite existing generated files:

```bash
dart run flutter_feature_cli create authentication --force
```

---

## 💻 Commands

Generate a feature:

```bash
dart run flutter_feature_cli create <feature_name>
```

Generate a feature using a specific template:

```bash
dart run flutter_feature_cli create <feature_name> \
  --template <template>
```

Generate a feature in a custom location:

```bash
dart run flutter_feature_cli create <feature_name> \
  --path <path>
```

Overwrite existing generated files:

```bash
dart run flutter_feature_cli create <feature_name> \
  --force
```

Available templates:

```text
partial_clean
clean_architecture
mvc
mvvm
custom
```

---

## 🛣 Roadmap

* ~~Custom templates via `pubspec.yaml`~~ ✅ Done
* Entity generation
* CRUD scaffolding
* Project setup command
* Bulk feature generation
* Architecture validation
* Feature merge utilities

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome.

---

## 📄 License

MIT License

Copyright (c) 2026 Hasan Shaikh - HasneticLabs
