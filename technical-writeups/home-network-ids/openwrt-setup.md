# OpenWrt Router Configuration Guide

Complete step-by-step guide for configuring OpenWrt router for IDS deployment.

## Overview

This guide covers:
- Initial router setup and security hardening
- Network interface configuration
- Firewall rules implementation
- Port mirroring/SPAN configuration for IDS traffic
- DMZ and network segmentation
- VLAN configuration
- Security best practices

## Quick Reference

### Initial Setup
```bash
# Connect to router
ssh root@192.168.1.1

# Set strong password
passwd

# Update packages
opkg update && opkg upgrade
```

### Essential Packages
```bash
# Network monitoring tools
opkg install tcpdump nmap iperf3 vnstat

# Traffic mirroring
opkg install iptables-mod-tee iptables-mod-extra

# Web interface enhancements
opkg install luci-app-statistics luci-app-firewall
```

### Port Mirroring for IDS
```bash
# Using iptables TEE target (recommended)
iptables -t mangle -A PREROUTING -j TEE --gateway 192.168.100.2
iptables -t mangle -A POSTROUTING -j TEE --gateway 192.168.100.2
```

### Network Segmentation
- **LAN**: 192.168.1.0/24 (trusted)
- **DMZ**: 192.168.20.0/24 (restricted)
- **IDS Monitor**: 192.168.100.0/24 (passive monitoring)

## Detailed Documentation

For complete configuration details, troubleshooting, and advanced topics, see the full documentation in the original repository:

**[Complete OpenWrt Setup Guide](https://github.com/8eight8toes8/home-network-ids/blob/main/docs/openwrt-setup.md)**

## Key Configuration Files

- `/etc/config/network` - Network interfaces and VLANs
- `/etc/config/firewall` - Firewall zones and rules  
- `/etc/config/dhcp` - DHCP and DNS settings
- `/etc/firewall.user` - Custom firewall rules

## Security Hardening Checklist

- [ ] Set strong root password
- [ ] Disable password authentication (use SSH keys)
- [ ] Change SSH to non-standard port
- [ ] Enable firewall logging
- [ ] Configure automated backups
- [ ] Disable unused services
- [ ] Implement rate limiting
- [ ] Set up geo-blocking

## Testing & Validation

```bash
# Verify mirroring is working
tcpdump -i eth0.3 -c 10

# Test firewall rules
nmap -sT 192.168.1.1

# Monitor bandwidth
vnstat -l -i br-lan
```

---

**Next Steps**: [Suricata IDS Installation](suricata-installation.md)
