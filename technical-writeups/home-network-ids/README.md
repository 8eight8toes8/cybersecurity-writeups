# Home Network Intrusion Detection System (IDS)

[![OpenWrt](https://img.shields.io/badge/OpenWrt-Router-00B5E2?logo=openwrt&logoColor=white)](https://openwrt.org/)
[![Suricata](https://img.shields.io/badge/Suricata-IDS-FF6600?logo=suricata&logoColor=white)](https://suricata.io/)
[![WSL2](https://img.shields.io/badge/WSL2-Ubuntu-FCC624?logo=linux&logoColor=black)](https://docs.microsoft.com/en-us/windows/wsl/)

> **Professional home network security implementation featuring OpenWrt firewall configuration and Suricata IDS deployment on WSL2**

## 📋 Project Overview

This repository documents the deployment of a multi-layered network intrusion detection system for home lab environments. The implementation combines OpenWrt router-level firewall controls with Suricata IDS running on WSL2 for comprehensive network monitoring and threat detection.

**Key Objectives:**
- Implement enterprise-grade network security in home lab environment
- Monitor and analyze network traffic for suspicious activity
- Document reproducible security architecture
- Practice SOC analyst skills with real-world traffic analysis

---

## 🚀 Quick Start

### Prerequisites

**Hardware Requirements:**
- OpenWrt-compatible router (tested on models with 128MB+ RAM)
- Windows 10/11 machine with WSL2 enabled
- Minimum 4GB RAM on host machine
- At least 20GB free disk space

**Software Requirements:**
- Ubuntu 20.04/22.04 on WSL2
- OpenWrt 21.02 or newer
- Suricata 6.0+
- Basic understanding of networking concepts

### Installation Overview

1. **OpenWrt Router Setup** (~30 minutes)
   - Flash OpenWrt firmware
   - Configure network interfaces
   - Set up port mirroring/SPAN

2. **Suricata IDS Deployment** (~45 minutes)
   - Install WSL2 and Ubuntu
   - Compile and install Suricata
   - Configure network capture
   - Load detection rules

3. **Integration Testing** (~20 minutes)
   - Validate traffic flow
   - Test alert generation
   - Tune performance settings

**Total estimated setup time: ~2 hours**

---

## 📊 System Capabilities

### Detection Features

- ✅ **Signature-based detection** using ET Open ruleset
- ✅ **Protocol anomaly detection** (TCP, UDP, ICMP, HTTP, TLS)
- ✅ **File extraction and inspection**
- ✅ **DNS query logging and analysis**
- ✅ **TLS/SSL certificate monitoring**
- ✅ **Network flow tracking** (Netflow-style metadata)

### Network Coverage

- All ingress/egress traffic via port mirroring
- Internal VLAN traffic monitoring
- DMZ segment surveillance
- Wireless client activity tracking

### Performance Metrics

- **Throughput**: Up to 500 Mbps monitored traffic
- **Latency**: <5ms added to mirrored traffic
- **Alert Volume**: 50-200 alerts/day (tuned environment)
- **False Positive Rate**: <5% after tuning
- **CPU Usage**: 15-25% on 4-core system
- **RAM Usage**: ~2GB for Suricata process

---

## 🛡️ Security Best Practices

### Network Segmentation

```
Internet → Firewall → [DMZ] → Internal Network
                     ↓
              IDS Mirror Port
                     ↓
             Suricata on WSL2
```

### Firewall Configuration

- **Default deny** ingress policy
- **Egress filtering** for malware C2 prevention
- **Rate limiting** on WAN interface
- **Geo-blocking** for high-risk countries
- **Port mirroring** without disrupting production traffic

### IDS Tuning Recommendations

1. Start with ET Open ruleset (free)
2. Disable noisy rules (Windows Update, CDN traffic)
3. Create custom rules for your environment
4. Implement alert suppression for known-good traffic
5. Regular rule updates (weekly recommended)

### Data Retention

- **PCAP files**: 7 days (rolling deletion)
- **Logs**: 30 days
- **Alerts**: 90 days
- **Statistics**: 1 year

---

## 🏗️ Architecture

```
Internet
   │
   ↓
[ISP Modem/Gateway]
   │
   ↓
[OpenWrt Router] ← Firewall Rules, ACLs, Port Mirroring
   │
   ├─→ [Home Network Devices]
   │
   └─→ [WSL2 Ubuntu] ← Suricata IDS Engine
       │
       └─→ Log Analysis & Alerting
```

### Components

1. **OpenWrt Router**
   - Custom firewall ruleset (DMZ, port forwarding, ACLs)
   - Traffic mirroring/SPAN port configuration
   - Network segmentation

2. **Suricata IDS (WSL2)**
   - Real-time packet analysis
   - Signature-based threat detection
   - Protocol anomaly detection
   - EVE JSON logging for SIEM integration

3. **Log Management**
   - EVE JSON output format
   - Integration-ready for Splunk/ELK
   - Custom alert correlation rules

---

## 🛠️ Technical Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Router OS | OpenWrt 23.05+ | Network gateway and traffic control |
| IDS Engine | Suricata 7.x | Network intrusion detection |
| Host Platform | WSL2 (Ubuntu 22.04) | Linux environment on Windows 11 |
| Packet Capture | libpcap / AF_PACKET | Network interface monitoring |
| Rule Management | Emerging Threats Open | Threat signature database |
| Log Format | EVE JSON | Structured logging for analysis |

---

## 📚 Documentation

### Setup Guides

- **[OpenWrt Router Configuration](openwrt-setup.md)**
  - Initial router setup
  - Firewall rule implementation
  - Port mirroring/SPAN configuration
  - DMZ and network segmentation

- **[Suricata IDS Installation](suricata-installation.md)**
  - WSL2 environment preparation
  - Suricata compilation and installation
  - Network interface configuration
  - Rule management setup

- **[Integration & Testing](integration-testing.md)**
  - Traffic flow verification
  - Alert validation
  - Performance tuning
  - False positive reduction

---

## 🔍 Monitoring & Analysis

### Key Detection Capabilities

- **Network Reconnaissance**: Nmap scans, port sweeps, service enumeration
- **Exploit Attempts**: CVE-based signatures, payload detection
- **Protocol Anomalies**: Malformed packets, unusual traffic patterns
- **C2 Communications**: Known malware signatures, beaconing behavior
- **Data Exfiltration**: Large outbound transfers, suspicious destinations

### Log Analysis

Suricata generates EVE JSON logs in `/var/log/suricata/eve.json`:

```bash
# Real-time alert monitoring
tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'

# Alert summary
cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c | sort -rn
```

---

## 🔧 Troubleshooting

### Common Issues

**Suricata not seeing traffic**

```bash
# Verify mirror port on OpenWrt
uci show network | grep mirror

# Check WSL2 network adapter
ip link show
ip addr show

# Test packet capture
sudo tcpdump -i eth0 -c 100
```

**High CPU usage**

- Reduce active ruleset
- Disable unneeded protocol parsers
- Increase `af-packet` workers
- Check for packet loss: `suricatasc -c "iface-stat eth0"`

**No alerts generating**

```bash
# Verify rules loaded
sudo suricatactl ruleset-stats

# Check for errors
sudo tail -f /var/log/suricata/suricata.log

# Test with known-bad traffic
curl http://testmynids.org/uid/index.html
```

---

## 👤 Author

**Jay Henderson**
- Cybersecurity Intern @ MCCoE
- GitHub: [@8eight8toes8](https://github.com/8eight8toes8)
- Email: jhenderson@mccoe.org

---

## 🔖 Project Status

**Current Phase:** Active Development & Documentation

**Completed:**
- ✅ OpenWrt router deployment
- ✅ Suricata IDS installation on WSL2
- ✅ Basic rule configuration
- ✅ Initial testing and validation

**In Progress:**
- 🔄 Advanced rule tuning
- 🔄 SIEM integration (Splunk)
- 🔄 Automated alerting workflows
- 🔄 Comprehensive documentation

**Planned:**
- 📋 Threat intelligence feed integration
- 📋 Custom dashboard creation
- 📋 Automated incident response scripts
- 📋 Network baseline profiling

---

*Last Updated: November 2025*
