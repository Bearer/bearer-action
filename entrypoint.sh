#!/bin/bash

# Filter out any empty args
args=$(for var in "$@"; do echo "$var";done | grep =.)

RULE_BREACHES=`$RUNNER_TEMP/bearer scan --quiet ${args//$'\n'/ } .`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

# Convert to single line
RULE_BREACHES="${RULE_BREACHES//'%'/%25}"
RULE_BREACHES="${RULE_BREACHES//$'\n'/%0A}"
RULE_BREACHES="${RULE_BREACHES//$'\r'/%0D}"

echo "rule_breaches=$RULE_BREACHES" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
