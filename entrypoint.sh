#!/bin/sh -l

POLICY_BREACHES=`curio scan --quiet $* .`
SCAN_EXIT_CODE=$?

echo "::debug::$POLICY_BREACHES"

# Convert to single line
POLICY_BREACHES="${POLICY_BREACHES//'%'/%25}"
POLICY_BREACHES="${POLICY_BREACHES//$'\n'/%0A}"
POLICY_BREACHES="${POLICY_BREACHES//$'\r'/%0D}"

echo "policy_breaches=$POLICY_BREACHES" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT
