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

### Pull Request Diff

When the Bearer action is being used to check a pull request, you can tell the
action to only report findings introduced within the pull request by setting
the `diff` input parameter to `true`.

```yaml
name: Bearer PR Check

on:
  pull_request:
    types: [opened, synchronize, reopened]

permissions:
  contents: read

jobs:
  rule_check:
    runs-on: ubuntu-latest
    continue-on-error: true
    steps:
      - uses: actions/checkout@v3
      - name: Run Report
        id: report
        uses: bearer/bearer-action@v2
        with:
          diff: true
```

See our guide on [configuring a scan](/guides/configure-scan#only-report-new-findings-on-a-branch)
for more information on differential scans.

### Using [Reviewdog](https://github.com/Reviewdog/Reviewdog) for PR review comments with Bearer

```yaml
name: Bearer PR Check

on:
  pull_request:
    types: [opened, synchronize, reopened]

permissions:
  contents: read

jobs:
  rule_check:
    runs-on: ubuntu-latest
    continue-on-error: true
    steps:
      - uses: actions/checkout@v3
      - name: Run Report
        id: report
        uses: bearer/bearer-action@v2
        with:
          format: rdjson
          output: rd.json
          diff: true
      - uses: reviewdog/action-setup@v1
        with:
          reviewdog_version: latest
      - name: Run reviewdog
        env:
          REVIEWDOG_GITHUB_API_TOKEN: ${{ secrets.REVIEWDOG_GITHUB_API_TOKEN }}
        run: |
          cat rd.json | reviewdog -f=rdjson -reporter=github-pr-review
```
Remember to setup a personal access [token](https://github.com/settings/personal-access-tokens/new) with PR read and write permissions and save it to your repo secrets as `REVIEWDOG_GITHUB_API_TOKEN` and you should be good to go.

### Using [Defect Dojo](https://github.com/DefectDojo/django-DefectDojo) to monitor findings

```yaml
name: Bearer Defect Dojo

on:
  push:
    branches:
      - main

permissions:
  contents: read

jobs:
  rule_check:
    runs-on: ubuntu-latest
    continue-on-error: true
    steps:
      - uses: actions/checkout@v3
      - name: Run Report
        id: report
        uses: bearer/bearer-action@v2
        with:
          format: gitlab-sast
          output: gl-sast-report.json
      - name: Defect Dojo
        env:
          DD_TOKEN: ${{ secrets.DD_TOKEN}}
          DD_APP: ${{ secrets.DD_APP}}
          DD_ENGAGEMENT: ${{ secrets.DD_ENGAGEMENT}}
        run: |
          curl -X POST -F "file=@gl-sast-report.json" -F "product_name=$DD_APP" -F "engagement_name=$DD_ENGAGEMENT" -F "scan_type=GitLab SAST Report" -H "Authorization: Token $DD_TOKEN" http://example.com/api/v2/import-scan/
```

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

### `exclude-fingerprint`

**Optional** Specify the comma-separated fingerprints of the findings you would like to exclude from the report.

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
