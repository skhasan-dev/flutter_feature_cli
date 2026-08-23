# Example

Generate a feature:

```bash
dart run flutter_feature_cli create authentication
```

Using the configuration:

```yaml
flutter_feature_cli:
  path: lib/src/features
  template: clean_architecture
```

Generates:

```text
lib/src/features/authentication
```

## Custom Template

Instead of `clean_architecture`, declare your own folder/file structure under
`custom` in `pubspec.yaml`:

```yaml
flutter_feature_cli:
  path: lib/src/features
  template: custom
  custom:
    presentation/views:
      - "{feature}_view.dart"
    domain/entities:
      - "{feature}_entity.dart"
```

```bash
dart run flutter_feature_cli create authentication -t custom
```

Want a folder with no generated files, just the directory? Give it an empty
list:

```yaml
flutter_feature_cli:
  custom:
    core/constants: []
```

Want a folder that has both its own files and a subfolder? Declare the parent
path and the nested path separately:

```yaml
flutter_feature_cli:
  custom:
    test1:
      - "{feature}_test1.dart"
    test1/sub:
      - "{feature}_sub.dart"
```

See the root [README](../README.md#custom) for the full schema.