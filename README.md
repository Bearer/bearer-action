# Bearer Action

Run [Bearer](https://docs.bearer.com/) as a [GitHub Action](https://github.com/features/actions).

## Example usage

### Using defaults

``` yaml
steps:
  - uses: actions/checkout@v3
  - uses: bearer/bearer-action@v2
```

### Using custom values for inputs

``` yaml
steps:
  - uses: actions/checkout@v3
  - name: Bearer
    uses: bearer/bearer-action@v2
    with:
      config-file: '/some/path/bearer.yml'
      only-rule: 'ruby_lang_cookies,ruby_lang_http_post_insecure_with_data'
      skip-path: 'users/*.go,users/admin.sql'
```

### Full Reporting Example

```yaml
name: Bearer

on:
  push:
    branches:
      - main

permissions:
  contents: read

jobs:
  rule_check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Report
        id: report
        uses: bearer/bearer-action@v2
```

you can see this workflow in action on our [demo repo](https://github.com/Bearer/bear-publishing/actions/workflows/bearer.yml)

## Inputs

### `version`

**Optional** Specify the Bearer version to use. This must match a Bearer release name.

### `scanner`

**Optional** Specify the comma-separated scanner to use e.g. `sast,secrets`

### `config-file`

**Optional** configuration file path

### `only-rule`

**Optional** Specify the comma-separated IDs of the rules to run; skips all other rules.

### `skip-rule`

**Optional** Specify the comma-separated IDs of the rules to skip; runs all other rules.

### `skip-path`

**Optional** Specify the comma-separated paths to skip. Supports wildcard syntax, e.g. `users/*.go,users/admin.sql`

### `severity`

**Optional** Specify which severities are included in the report as a comma separated string, e.g. `critical,medium`

### `format`

**Optional** Specify which format to use, e.g. `json`

### `output`

**Optional** Specify where to store the report, e.g. `results.sarif`

## Outputs

### `rule_breaches`

Details of any rule breaches that occur. This is URL encoded to work round GitHub issues with multiline outputs.

### `exit_code`

Exit code of the binary, 0 indicates a pass
