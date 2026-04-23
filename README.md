
# Linux-based Aircraft Connectivity Test Automation

**Bash + Linux scripts for system integration testing of aircraft networked equipment (Ethernet/IP, ARINC 615A, log analysis, regression testing avionics interfaces).**

Demonstrates practical skills in:
- Linux (Debian/Ubuntu) environment setup
- Bash scripting for test automation
- Log analysis & root cause support
- Network diagnostics (tcpdump + Wireshark compatible)
- Regression testing of configurations

### Key Features
- Automated log analysis for root cause support  
- Network diagnostics with `tcpdump` (Wireshark-compatible captures)  
- Regression testing of configurations and connectivity  
- Clean, production-grade Bash with best practices (`set -euo pipefail`, error handling, usage messages)

**Application areas:**
- System integration testing of aircraft networked equipment and interfaces
- Analyze logs, test evidence, and reproduce field issues
- Execute software/configuration loading and regression testing on test benches
- IP networking & troubleshooting (Wireshark / tcpdump)

### Scripts

| Script                    | Purpose                                              | What it tests  |
|---------------------------|------------------------------------------------------|----------------|
| `analyze_logs.sh`        | Scans logs for errors/warnings and generates reports | "Analyze logs, test evidence, root cause analysis" |
| `network_test.sh`        | Connectivity checks, port scanning, tcpdump capture  | "IP networking, Wireshark/tcpdump, troubleshoot HW/SW/config" |
| `regression_runner.sh`   | Runs multiple test cycles and compares results       | "Execute regression testing on test benches" |

### How to Use

### How to use
```bash
git clone https://github.com/Vaiy108/aircraft-connectivity-test-automation.git
cd aircraft-connectivity-test-automation/scripts
chmod +x *.sh
./network_test.sh                  # basic network diagnostics
./analyze_logs.sh /var/log/syslog   # analyze system logs
./regression_runner.sh             # run full regression suite
```

### Future enhancements (in progress):

- Python test automation
- ARINC 615A data loader simulation
- Sample Wireshark .pcap files with avionics traffic filters
- CI integration - Jenkins-style CI pipeline examples

