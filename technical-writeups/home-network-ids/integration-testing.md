# Integration & Testing Guide

Comprehensive testing procedures for validating the Home Network IDS deployment.

## Overview

This guide covers:
- Traffic flow verification between OpenWrt and Suricata
- Alert validation and rule testing
- Performance benchmarking
- False positive reduction
- Network baseline establishment
- Continuous monitoring setup

## Pre-Testing Checklist

- [ ] OpenWrt router configured with port mirroring
- [ ] Suricata IDS installed and running on WSL2
- [ ] Network interfaces properly configured
- [ ] Rulesets loaded and enabled
- [ ] Logging configured and accessible
- [ ] Backup configurations saved

## Traffic Flow Verification

### Test 1: Verify Port Mirroring

**On OpenWrt Router:**
```bash
# Check iptables rules
iptables -t mangle -L -v -n

# Verify mirrored packets
tcpdump -i eth0.3 -c 20
```

**On WSL2 (Suricata):**
```bash
# Verify interface is receiving traffic
sudo tcpdump -i eth0 -c 20

# Check Suricata stats
sudo suricatasc -c "iface-stat eth0"
```

### Test 2: End-to-End Connectivity

```bash
# From LAN device, generate traffic
ping -c 10 8.8.8.8
curl https://www.google.com

# Verify traffic appears in Suricata logs
sudo tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="flow")'
```

## Alert Validation

### Test Known-Bad Traffic

```bash
# Test 1: ET Open test site
curl http://testmynids.org/uid/index.html

# Test 2: Nmap scan (from external machine)
nmap -sS -p 1-1000 <your-wan-ip>

# Test 3: User-Agent string detection
curl -A "Nmap Scripting Engine" http://example.com
```

### Verify Alerts Generated

```bash
# Check fast.log
sudo tail -f /var/log/suricata/fast.log

# Parse EVE JSON for alerts
sudo cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")' | head -n 5

# Count alerts by signature
sudo cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c | sort -rn
```

## Performance Testing

### Bandwidth Test

```bash
# Install iperf3 on both ends
sudo apt install iperf3

# Server side
iperf3 -s

# Client side
iperf3 -c <server-ip> -t 60

# Monitor Suricata during test
watch -n 1 'sudo suricatasc -c "dump-counters" | grep -E "capture|drop"'
```

### CPU & Memory Usage

```bash
# Monitor Suricata resources
top -p $(pgrep suricata)

# Check detailed stats
sudo suricatasc -c "dump-counters" | grep -E "cpu|memory"
```

### Packet Drop Analysis

```bash
# Check for packet drops
sudo suricatasc -c "iface-stat eth0"

# Review stats log
sudo tail -f /var/log/suricata/stats.log
```

## False Positive Reduction

### Identify Noisy Rules

```bash
# Top 10 most triggered rules
sudo cat /var/log/suricata/eve.json | \\
  jq -r 'select(.event_type=="alert") | "\(.alert.signature_id): \(.alert.signature)"' | \\
  sort | uniq -c | sort -rn | head -10
```

### Disable Problematic Rules

Edit `/etc/suricata/disable.conf`:
```
# Disable by SID
2100498  # ET INFO Session Traversal Utilities for NAT
2013028  # ET POLICY curl User-Agent Outbound
```

### Create Suppression Rules

Edit `/etc/suricata/threshold.config`:
```
# Suppress specific alerts from trusted IPs
suppress gen_id 1, sig_id 2100498, track by_src, ip 192.168.1.100

# Rate limit alerts
threshold gen_id 1, sig_id 2013028, type threshold, track by_src, count 5, seconds 60
```

## Baseline Establishment

### Day 1-7: Learning Mode

```bash
# Monitor normal traffic patterns
sudo cat /var/log/suricata/eve.json | jq 'select(.event_type=="flow") | {src_ip: .src_ip, dest_ip: .dest_ip, proto: .proto}' > baseline_week1.json

# Analyze protocols
cat baseline_week1.json | jq -r '.proto' | sort | uniq -c | sort -rn

# Common destinations
cat baseline_week1.json | jq -r '.dest_ip' | sort | uniq -c | sort -rn | head -20
```

### Create Whitelist

```yaml
# Add to suricata.yaml
pass:
  - 192.168.1.100  # Trusted workstation
  - 192.168.1.50   # Server
```

## Continuous Monitoring Setup

### Automated Health Checks

Create `/usr/local/bin/ids-health-check.sh`:
```bash
#!/bin/bash
LOGFILE="/var/log/ids-health.log"

echo "[$(date)] Starting IDS health check" >> $LOGFILE

# Check if Suricata is running
if ! pgrep suricata > /dev/null; then
    echo "[$(date)] ERROR: Suricata is not running!" >> $LOGFILE
    sudo systemctl restart suricata
fi

# Check packet capture rate
PACKETS=$(sudo suricatasc -c "iface-stat eth0" | jq '.message.pkts')
if [ "$PACKETS" -eq 0 ]; then
    echo "[$(date)] WARNING: No packets captured!" >> $LOGFILE
fi

echo "[$(date)] Health check complete" >> $LOGFILE
```

### Schedule Monitoring

```bash
# Add to crontab
*/5 * * * * /usr/local/bin/ids-health-check.sh
0 2 * * * sudo suricata-update && sudo systemctl reload suricata
```

## Testing Scenarios

### Scenario 1: Port Scan Detection
```bash
# From external machine
nmap -sS -p- <your-ip>

# Expected: Multiple alerts for port scanning
```

### Scenario 2: Malware Download Simulation
```bash
# Download EICAR test file
wget http://www.eicar.org/download/eicar.com

# Expected: Malware detection alert
```

### Scenario 3: DNS Tunneling
```bash
# Simulate suspicious DNS activity
for i in {1..100}; do
  dig randomsubdomain$i.suspicious.com @8.8.8.8
done

# Expected: DNS tunneling alerts
```

## Troubleshooting Common Issues

**No traffic reaching Suricata:**
- Verify port mirroring on OpenWrt
- Check interface promiscuous mode
- Ensure WSL2 networking is properly bridged

**High false positive rate:**
- Review and tune rules
- Implement suppression for known-good traffic
- Create custom rules for your environment

**Performance degradation:**
- Reduce active ruleset
- Tune worker threads
- Check for packet drops

## Detailed Documentation

For complete testing procedures, advanced scenarios, and troubleshooting:

**[Complete Integration Testing Guide](https://github.com/8eight8toes8/home-network-ids/blob/main/docs/integration-testing.md)**

## Success Criteria

- [ ] Traffic mirroring confirmed working
- [ ] Suricata capturing 100% of mirrored packets
- [ ] Test alerts generating correctly
- [ ] False positive rate <5%
- [ ] No packet drops under normal load
- [ ] Performance acceptable (<25% CPU usage)
- [ ] Logs rotating properly
- [ ] Automated monitoring in place

---

**Project Complete!** Your Home Network IDS is now fully deployed and validated.
