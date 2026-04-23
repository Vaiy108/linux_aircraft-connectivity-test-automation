#!/bin/bash
# analyze_logs.sh — Job-ready log analyzer for aircraft connectivity testing

set -euo pipefail

# Usage function
usage() {
    echo "Usage: $0 [LOGFILE]"
    echo "Example: $0 /var/log/syslog"
    echo "         $0 /path/to/connectivity_test.log"
    exit 1
}

# Check arguments
if [ $# -gt 1 ]; then
    usage
fi

LOGFILE="${1:-/var/log/syslog}"

if [ ! -f "$LOGFILE" ]; then
    echo "Error: Log file '$LOGFILE' not found!" >&2
    exit 1
fi

echo "=== Aircraft Connectivity Log Analysis Report ==="
echo "Log file       : $LOGFILE"
echo "Analysis time  : $(date)"
echo "------------------------------------------------"

ERROR_COUNT=$(grep -c -i "error\|failed\|critical\|exception" "$LOGFILE" || echo 0)
WARNING_COUNT=$(grep -c -i "warning" "$LOGFILE" || echo 0)

TOP_ERRORS=$(grep -i "error\|failed" "$LOGFILE" | sort | uniq -c | sort -nr | head -8)

echo "Total ERRORS   : $ERROR_COUNT"
echo "Total WARNINGS : $WARNING_COUNT"
echo ""
echo "Top 8 Errors/Warnings:"
echo "${TOP_ERRORS:-None found}"
echo ""
echo " Log analysis completed."