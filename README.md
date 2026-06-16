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
  flutter_feature_cli: ^1.1.0
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

Available templates:

```text
partial_clean
clean_architecture
mvc
mvvm
```

---

## 🛣 Roadmap

* Custom templates via `pubspec.yaml`
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
