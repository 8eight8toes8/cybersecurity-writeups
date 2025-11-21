# Suricata IDS Installation Guide

Comprehensive guide for installing and configuring Suricata IDS on WSL2 Ubuntu for network threat detection.

## Overview

This guide covers:
- WSL2 environment preparation
- Suricata compilation and installation from source
- Network interface configuration for packet capture
- Rule management and updates
- Performance tuning
- Integration with OpenWrt router

## Quick Installation

### Prerequisites
```bash
# Windows 11 with WSL2 enabled
# Ubuntu 22.04 LTS on WSL2
# At least 4GB RAM available
# Network adapter configured for promiscuous mode
```

### Install from Repository (Fast)
```bash
# Add Suricata PPA
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt update

# Install Suricata
sudo apt install suricata -y

# Verify installation
sudo suricata --build-info
```

### Install Dependencies
```bash
# Core libraries
sudo apt install libpcap-dev libpcre3-dev libyaml-dev \\
                 libjansson-dev libmagic-dev zlib1g-dev \\
                 libcap-ng-dev libnetfilter-queue-dev

# Python for rule management
sudo apt install python3-pip python3-yaml
sudo pip3 install suricata-update
```

## Network Configuration

### Enable Promiscuous Mode
```bash
# Set interface to promiscuous mode
sudo ip link set eth0 promisc on

# Verify setting
ip link show eth0 | grep PROMISC
```

### Configure Interface in Suricata
Edit `/etc/suricata/suricata.yaml`:
```yaml
af-packet:
  - interface: eth0
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes
    use-mmap: yes
    tpacket-v3: yes
```

## Rule Management

### Install ET Open Ruleset
```bash
# Update Suricata rules
sudo suricata-update

# List available sources
sudo suricata-update list-sources

# Enable specific rulesets
sudo suricata-update enable-source et/open
sudo suricata-update
```

### Custom Rules
Create `/etc/suricata/rules/local.rules`:
```
# Detect nmap scans
alert tcp any any -> $HOME_NET any (msg:"Nmap SYN scan"; \\
    flags:S; threshold: type both, track by_src, count 5, seconds 60; \\
    sid:1000001; rev:1;)

# Detect suspicious DNS queries
alert dns any any -> any any (msg:"Suspicious TLD query"; \\
    dns_query; content:".xyz"; nocase; sid:1000002; rev:1;)
```

## Performance Tuning

### CPU and Memory Settings
In `/etc/suricata/suricata.yaml`:
```yaml
# Threading
threading:
  set-cpu-affinity: no
  cpu-affinity:
    - management-cpu-set:
        cpu: [ 0 ]
    - receive-cpu-set:
        cpu: [ 0-3 ]
    - worker-cpu-set:
        cpu: [ 0-3 ]
  detect-thread-ratio: 1.0

# Resource limits
max-pending-packets: 1024
default-packet-size: 1514
```

### Run Mode Configuration
```yaml
# High-performance mode
runmode: workers
engine-analysis:
  rules-fast-pattern: yes
  rules: yes

profiling:
  rules:
    enabled: yes
    filename: rule_perf.log
```

## Starting Suricata

### As Service
```bash
# Enable and start service
sudo systemctl enable suricata
sudo systemctl start suricata

# Check status
sudo systemctl status suricata

# View logs
sudo tail -f /var/log/suricata/suricata.log
```

### Manual Mode
```bash
# Run in foreground with verbose output
sudo suricata -c /etc/suricata/suricata.yaml -i eth0 -v

# Run in daemon mode
sudo suricata -c /etc/suricata/suricata.yaml -i eth0 -D
```

## Monitoring & Logs

### Key Log Files
- `/var/log/suricata/suricata.log` - Main application log
- `/var/log/suricata/eve.json` - EVE JSON format events
- `/var/log/suricata/fast.log` - Fast alert format
- `/var/log/suricata/stats.log` - Performance statistics

### Real-time Monitoring
```bash
# Watch alerts
tail -f /var/log/suricata/fast.log

# Parse EVE JSON
tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'

# Statistics
sudo suricatasc -c "dump-counters"
```

## Testing

### Test Alert Generation
```bash
# Test with known-bad traffic
curl http://testmynids.org/uid/index.html

# Should generate alerts in fast.log
sudo grep "GPL ATTACK_RESPONSE" /var/log/suricata/fast.log
```

### Verify Packet Capture
```bash
# Check interface stats
sudo suricatasc -c "iface-stat eth0"

# Monitor packet counters
watch -n 1 'sudo suricatasc -c "dump-counters" | grep capture.kernel_packets'
```

## Detailed Documentation

For complete installation procedures, advanced configuration, and troubleshooting:

**[Complete Suricata Installation Guide](https://github.com/8eight8toes8/home-network-ids/blob/main/docs/suricata-installation.md)**

##  Common Issues

**Suricata not seeing traffic:**
- Verify promiscuous mode is enabled
- Check WSL2 network bridge configuration
- Ensure mirroring is working from OpenWrt

**High CPU usage:**
- Reduce active ruleset
- Tune worker thread count
- Disable unnecessary protocol parsers

**Permission errors:**
- Suricata requires root/sudo
- Check file permissions on log directory
- Verify CAP_NET_RAW capability

---

**Next Steps**: [Integration & Testing](integration-testing.md)
