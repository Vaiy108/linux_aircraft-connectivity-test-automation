#!/bin/bash
# network_test.sh — Automated network diagnostics for aircraft connectivity

set -euo pipefail

# Default values (easily overridden)
TARGET="${1:-8.8.8.8}"
INTERFACE="${2:-eth0}"
CAPTURE_FILE="connectivity_capture_$(date +%Y%m%d_%H%M%S).pcap"

usage() {
    echo "Usage: $0 [TARGET_IP] [INTERFACE]"
    echo "Example: $0 192.168.1.100 eth0"
    exit 1
}

if [ $# -gt 2 ]; then
    usage
fi

echo "=== Aircraft Network Connectivity Test ==="
echo "Target IP      : $TARGET"
echo "Interface      : $INTERFACE"
echo "Capture file   : $CAPTURE_FILE"
echo "------------------------------------------------"

# Basic connectivity
ping -c 4 -I "$INTERFACE" "$TARGET" || echo "⚠️  Ping failed"

echo ""
echo "Port checks (common avionics/HTTP/SATCOM ports):"
for port in 80 443 8080 615A 9999; do
    timeout 2 bash -c "</dev/tcp/$TARGET/$port" 2>/dev/null && \
        echo "Port $port : OPEN" || echo "Port $port : CLOSED"
done

echo ""
echo "Capturing 20 packets with tcpdump (press Ctrl+C to stop early)..."
sudo tcpdump -i "$INTERFACE" -c 20 -w "$CAPTURE_FILE" 2>/dev/null || true

echo ""
echo " Capture saved: $CAPTURE_FILE"
echo "   Open in Wireshark for detailed analysis."