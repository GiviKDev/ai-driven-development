## [0.3.0](https://github.com/GiviKDev/ai-driven-development/compare/v0.2.0...v0.3.0) (2026-06-07)

### Features

* **docs:** add containerization practices and multi-artifact repo patterns to open problems ([e98e15b](https://github.com/GiviKDev/ai-driven-development/commit/e98e15ba38a012db10471258c8f2e24c73822cd5))

### Refactoring

* address audit findings across practices, methods, and structure ([3d75783](https://github.com/GiviKDev/ai-driven-development/commit/3d75783eba71376130e688aafe3258f2e50c47f6))
* **docs:** standardize punctuation rules across documentation ([c13ad5d](https://github.com/GiviKDev/ai-driven-development/commit/c13ad5d020af4be2a02470752e695738e47b6574))

## [0.2.0](https://github.com/GiviKDev/ai-driven-development/compare/v0.1.1...v0.2.0) (2026-05-17)

### ⚠ BREAKING CHANGES

* **plugin:** plugin/ moved to plugins/journey-verification/.
Plugin name renamed accordingly in plugin.json and
.claude-plugin/plugin.json.
* **docs:** All paths under docs/ have moved. specs/ removed.

### Refactoring

* **docs:** split docs into practices/ and methods/ ([4034379](https://github.com/GiviKDev/ai-driven-development/commit/40343798dfa46e355bf9749bec58456d23845e8f))
* **plugin:** rename plugin/ to plugins/journey-verification/ ([10e9f0e](https://github.com/GiviKDev/ai-driven-development/commit/10e9f0e99cdb53fc024d34a9564fdd72b749044f))
* update path references after restructure ([a2c0e0e](https://github.com/GiviKDev/ai-driven-development/commit/a2c0e0e3f0be0ae1b7de46b1607f85d8370e4808))

## [0.1.1](https://github.com/GiviKDev/ai-driven-development/compare/v0.1.0...v0.1.1) (2026-05-11)

### Bug Fixes

* **ci:** install lychee binary for link checking ([4a0894c](https://github.com/GiviKDev/ai-driven-development/commit/4a0894cec6bc05a23dbbcc84dd326d76fc03dd48))
* resolve yamllint and markdownlint errors across repo ([f7c5b6a](https://github.com/GiviKDev/ai-driven-development/commit/f7c5b6a77b64340200e00cf34ed77cad19066b99))

### Refactoring

* consolidate linting through pre-commit, bump hook versions ([fd28f2b](https://github.com/GiviKDev/ai-driven-development/commit/fd28f2b4005799752297260d80a3bdc70233c94a))
* move samples to root, bump actions to v6 ([7d69de1](https://github.com/GiviKDev/ai-driven-development/commit/7d69de1857cc40c792d12c726c55248b32111891))
