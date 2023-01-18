#!/bin/sh -l

POLICY_BREACHES=`curio scan $* .`
SCAN_EXIT_CODE=$?

[ $SCAN_EXIT_CODE -eq 0 ] || echo "policy_breaches=$POLICY_BREACHES" >>$GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
