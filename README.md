# wercker-step-gradle
Gradle step for [wercker](https://app.wercker.com/) written in `bash` and `curl`.
todo `./gradlew`

[![Build status](https://app.wercker.com/status/4b61fe011e8423699ced63c2d90c5cce/m/master)](https://app.wercker.com/project/bykey/4b61fe011e8423699ced63c2d90c5cce)

# Options

- `version` (optional) The Gradle version
- `tasks` The tasks names for execution

# Example

```yaml
build:
  steps:
    - gradle:
      tasks: clean build
```

# License

The MIT License (MIT)

# Changelog

## 0.1.0 (2016-02-18)

- Initial release
