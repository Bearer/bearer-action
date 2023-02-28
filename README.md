# Bearer Action

Run [Bearer](https://docs.bearer.com/) as a [GitHub Action](https://github.com/features/actions).

## Example usage

### Using defaults

``` yaml
steps:
  - uses: actions/checkout@v3
  - uses: bearer/bearer-action@v0.4
```

### Using custom values for inputs

``` yaml
steps:
  - uses: actions/checkout@v3
  - name: Bearer
    uses: bearer/bearer-action@v0.4
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
        uses: bearer/bearer-action@v0.4
      - id: summary
        name: Display Summary
        uses: actions/github-script@v6
        with:
          script: |
            // github does not support multiline outputs so report is encoded
            const report = decodeURIComponent(`${{ steps.report.outputs.rule_breaches }}`);
            const passed = `${{ steps.report.outputs.exit_code }}` == "0";
            if(!passed){ core.setFailed(report); }
```

you can see this workflow in action on our [demo repo](https://github.com/Bearer/bear-publishing/actions/workflows/bearer.yml)

## Inputs

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

## Outputs

### `rule_breaches`

Details of any rule breaches that occur. This is URL encoded to work round GitHub issues with multiline outputs.

### `exit_code`

Exit code of the binary, 0 indicates a pass
