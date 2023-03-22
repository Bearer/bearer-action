#!/bin/sh -l

# Filter out any empty args
args=($@)
given_args=($(for i in ${args[@]}
    do echo $i
done | grep =.))

RULE_BREACHES=`bearer scan --quiet ${given_args[@]} .`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

# Convert to single line
RULE_BREACHES="${RULE_BREACHES//'%'/%25}"
RULE_BREACHES="${RULE_BREACHES//$'\n'/%0A}"
RULE_BREACHES="${RULE_BREACHES//$'\r'/%0D}"

echo "rule_breaches=$RULE_BREACHES" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT
