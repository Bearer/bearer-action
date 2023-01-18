#!/bin/sh -l

POLICY_BREACHES=`curio scan --quiet $* .`
SCAN_EXIT_CODE=$?

# @todo FIXME:
# [ $SCAN_EXIT_CODE -eq 0 ] || echo "policy_breaches=$POLICY_BREACHES" >>$GITHUB_OUTPUT

time=`date`
echo "time=$time" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
