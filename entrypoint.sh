#!/bin/sh -l

do_error() {
  printf "ERROR: $*\n" 1>&2
  exit 1
}

run_scan() {
  docker run --rm -v $SCAN_PATH:/tmp/scan bearer/curio:latest-amd64 \
         scan \
         $* \
         /tmp/scan
}

[ -n "$SCAN_PATH" ] || do_error "The SCAN_PATH environment variable is not set"

POLICY_BREACHES=`run_scan $*`
SCAN_EXIT_CODE=$?

[ $SCAN_EXIT_CODE -eq 0 ] || echo "policy-breaches=$POLICY_BREACHES" >>$GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
