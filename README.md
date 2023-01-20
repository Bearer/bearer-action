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
      only-policy: 'CR-001,CR-004'
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
  policy_check:
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
            const report = decodeURIComponent(`${{ steps.report.outputs.policy_breaches }}`);
            const passed = `${{ steps.report.outputs.exit_code }}` == "0";
            if(!passed){ core.setFailed(report); }
```

## Inputs

### `config-file`

**Optional** Curio configuration file path

### `only-policy`

**Optional** Specify the comma-separated IDs of the policies to run; skips all other policies

### `skip-policy`

**Optional** Specify the comma-separated IDs of the policies to skip; runs all other policies

### `only-detector`

**Optional** Specify the comma-separated IDs of the detectors to run; skips all other detectors

### `skip-detector`

**Optional** Specify the comma-separated IDs of the detectors to skip; runs all other detectors

### `skip-path`

**Optional** Specify the comma-separated paths to skip. Supports wildcard syntax, e.g. `users/*.go,users/admin.sql`

## Outputs

### `policy_breaches`

Details of any policy breaches that occur. This is URL encoded to work round githubs issues with multiline outputs.

### `exit_code`

Exit code of the curio binary, 0 indicates a pass
