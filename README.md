# Curio Action

Run [Curio](https://curio.sh/) as a [GitHub Action](https://github.com/features/actions).

## Example usage

### Using defaults

``` yaml
steps:
  - uses: actions/checkout@v3
  - uses: bearer/curio-action@v0.1
```

### Using custom values for inputs

``` yaml
steps:
  - uses: actions/checkout@v3
  - name: Curio
    uses: bearer/curio-action@v0.1
    with:
      config-file: '/some/path/curio.yml'
      only-rule: 'ruby_lang_cookies,ruby_lang_http_post_insecure_with_data'
      skip-path: 'users/*.go,users/admin.sql'
```
### Full Reporting Example

```yaml
name: Curio

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
        uses: bearer/curio-action@v0.1
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
you can see this workflow in action on our [demo repo](https://github.com/Bearer/bear-publishing/actions/workflows/curio.yml)

## Inputs

### `config-file`

**Optional** Curio configuration file path

### `only-rule`

**Optional** Specify the comma-separated IDs of the rules to run; skips all other rules.

### `skip-rule`

**Optional** Specify the comma-separated IDs of the rules to skip; runs all other rules.

### `skip-path`

**Optional** Specify the comma-separated paths to skip. Supports wildcard syntax, e.g. `users/*.go,users/admin.sql`

## Outputs

### `rule_breaches`

Details of any rule breaches that occur. This is URL encoded to work round GitHub issues with multiline outputs.

### `exit_code`

Exit code of the curio binary, 0 indicates a pass
