# wercker-step-gradle
Gradle step for [wercker](https://app.wercker.com/) written in `bash` and `curl`.

If your project includes the `gradlew` wrapper script in the repository root, step will try to use it instead of install Gradle in standalone mode.

If your project does not includes `gradlew` wrapper script then step will install Gradle in standalone mode. Will be installed current version of Gradle or version declared in `version` option.

[![Build status](https://app.wercker.com/status/4b61fe011e8423699ced63c2d90c5cce/m/master)](https://app.wercker.com/project/bykey/4b61fe011e8423699ced63c2d90c5cce)

# Options

- `version` (optional) The Gradle version
- `tasks` The tasks names for execution

# Example

```yaml
build:
  steps:
    - valery1707/gradle:
      tasks: clean build
```

# License

The MIT License (MIT)

# Changelog

## 0.1.2 (2016-02-18)

- Fix unzip gradle distribution

## 0.1.1 (2016-02-18)

- Update README
- Test for default value in `version`

## 0.1.0 (2016-02-18)

- Initial release
