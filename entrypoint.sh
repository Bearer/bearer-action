#!/bin/sh -l

# N.B. Expect to be running in `/github/workspace`
printf "DEBUG: Running in working directory: %s\n" `pwd`

POLICY_BREACHES=`curio scan --debug $* .`
SCAN_EXIT_CODE=$?

[ $SCAN_EXIT_CODE -eq 0 ] || echo "policy-breaches=$POLICY_BREACHES" >>$GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
