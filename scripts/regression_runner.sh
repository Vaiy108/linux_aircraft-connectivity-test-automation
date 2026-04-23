#!/bin/bash
# regression_runner.sh — Simple regression test for connectivity configs


set -euo pipefail

CONFIG="${1:-config.ini}"
TEST_RUNS=3
RESULTS_DIR="regression_results_$(date +%Y%m%d_%H%M%S)"

usage() {
    echo "Usage: $0 [CONFIG_FILE]"
    echo "Example: $0 my_aircraft_config.ini"
    exit 1
}

if [ $# -gt 1 ]; then
    usage
fi

mkdir -p "$RESULTS_DIR"

echo "=== Regression Test Suite for Aircraft Connectivity ==="
echo "Config file    : $CONFIG"
echo "Test runs      : $TEST_RUNS"
echo "Results dir    : $RESULTS_DIR"
echo "------------------------------------------------"

for i in $(seq 1 "$TEST_RUNS"); do
    echo " Starting Run #$i ..."
    LOGFILE="$RESULTS_DIR/run_${i}.log"
    
    # Simulate config loading + full network test
    {
        echo "=== Run #$i - $(date) ==="
        echo "Loading configuration: $CONFIG"
        ./network_test.sh >> "$LOGFILE" 2>&1
        echo "Network test completed."
    } >> "$LOGFILE"
    
    echo "   Run #$i completed → $LOGFILE"
done

echo ""
echo " Final Summary "
grep -E "ERROR|WARNING|OPEN|CLOSED|failed" "$RESULTS_DIR"/run_*.log | head -20 || echo "No critical issues found."

echo ""
echo " Regression testing completed. Check $RESULTS_DIR for detailed logs."
echo "   Ready for CI integration or test bench deployment."