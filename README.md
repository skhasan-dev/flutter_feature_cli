# 🚀 Flutter Feature CLI

Generate scalable Flutter feature architecture in seconds.

A lightweight CLI tool that helps Flutter developers create consistent feature modules with a single command.

---

## ✨ Features

* Generate complete feature structure instantly
* Creates Data Sources, Entities, Repositories, View Models, and Widgets
* Configurable output path via `pubspec.yaml`
* Supports command-level path overrides
* Auto-generates barrel exports (`index.dart`)
* Reduces repetitive boilerplate code
* Fully tested and production-ready

---

## 📦 Installation

Add the package to your Flutter project:

```yaml
dev_dependencies:
  flutter_feature_cli: ^1.0.0
```

Install dependencies:

```bash
flutter pub get
```

---

## ⚙️ Configuration (Optional)

Configure a default feature generation path in your project's `pubspec.yaml`.

### Example

```yaml
flutter_feature_cli:
  path: lib/src/features
```

or

```yaml
flutter_feature_cli:
  path: lib/src/ai_features
```

If omitted, the package falls back to:

```text
lib/features
```

---

## 🚀 Create a Feature

Generate a feature:

```bash
dart run flutter_feature_cli:create authentication
```

Generated structure:

```text
lib/
└── features/
    └── authentication/
        ├── data/
        │   ├── data_sources/
        │   ├── entities/
        │   ├── repository/
        │   └── index.dart
        ├── presentation/
        │   ├── view_models/
        │   ├── widgets/
        │   └── index.dart
        └── index.dart
```

---

## 🎯 Override the Configured Path

You can override the configured path directly from the command:

```bash
dart run flutter_feature_cli:create authentication --path=lib/src/ai_features
```

The command-line path always takes precedence over the path configured in `pubspec.yaml`.

---

## 📂 Example

Using:

```yaml
flutter_feature_cli:
  path: lib/src/features
```

and running:

```bash
dart run flutter_feature_cli:create user_profile
```

creates:

```text
lib/
└── src/
    └── features/
        └── user_profile/
```

---

## 🛣 Roadmap

* Project setup command
* Bulk feature generation
* Custom templates
* Architecture validation
* Feature merge utilities

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome.

---

## 📄 License

MIT License

Copyright (c) 2026 Hasan Shaikh - HasneticLabs
