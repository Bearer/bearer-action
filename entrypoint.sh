#!/bin/sh -l

RULE_BREACHES=`curio scan --quiet $* .`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

# Convert to single line
RULE_BREACHES="${RULE_BREACHES//'%'/%25}"
RULE_BREACHES="${RULE_BREACHES//$'\n'/%0A}"
RULE_BREACHES="${RULE_BREACHES//$'\r'/%0D}"

echo "rule_breaches=$RULE_BREACHES" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT
