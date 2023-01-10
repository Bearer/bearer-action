# Curio Action

Run [Curio](https://curio.sh/) as a [GitHub Action](https://github.com/features/actions).

## Inputs

### `scan-path`

**Optional** The path to be scanned; defaults to the `GITHUB_WORKSPACE` environment variable

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

### `policy-breaches`

Details of any policy breaches that occur

## Example usage

### Using defaults

``` yaml
uses: bearer/curio-action@v1
```

### Using custom values for inputs

``` yaml
uses: bearer/curio-action@v1
with:
  scan-path: /some/repo/path
  config-file: '/some/path/curio.yml'
  only-policy: 'CR-001,CR-004'
  skip-path: 'users/*.go,users/admin.sql'
```
