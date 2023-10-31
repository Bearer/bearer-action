#!/bin/bash

# Filter out any empty args
args=$(for var in "$@"; do echo "$var";done | grep =.)

path_arg=$(echo "$args" | grep -oP '(?<=--path=)[^\s]+')
other_args=$(echo "$args" | sed -E 's/--path=[^\s]+//')

RULE_BREACHES=`$RUNNER_TEMP/bearer scan ${other_args//$'\n'/ } $path_arg`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)

echo "rule_breaches<<$EOF" >> $GITHUB_OUTPUT
echo "$RULE_BREACHES" >> $GITHUB_OUTPUT
echo "$EOF" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
