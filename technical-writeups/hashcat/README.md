# Hashcat Technical Write-Up

## Overview

Comprehensive technical documentation for hashcat, the world's fastest password recovery utility.

## Contents

- **hashcat.md** - Complete expert-level technical write-up covering:
  - Architecture and core capabilities
  - Attack methodologies (dictionary, mask, hybrid, combinator, Prince, Markov)
  - Performance optimization and hardware considerations
  - Session management and operational control
  - Hash extraction and format handling
  - Real-world engagement strategies
  - SOC vs Penetration Testing operational frameworks

- **hashcat_mode0_automation.sh** - Automated bash script for Mode 0 (dictionary) attacks
  - Pre-flight validation and GPU detection
  - Configurable hash modes, wordlists, and rules
  - Session management with checkpoint/restore
  - Post-attack analysis and reporting

- **Hashcat-in-SOC-vs-Penetration-Testing_Operational.md** - Strategic deployment comparison
  - SOC defensive operations (incident response, forensics)
  - Penetration testing offensive operations (vulnerability validation)
  - Real-world integration examples
  - Detection and defense monitoring

- **Usage-Examples.md** - Practical command examples and output structure

## Quick Start

For a complete understanding of hashcat capabilities, start with `hashcat.md`.

For automated dictionary attacks, use the `hashcat_mode0_automation.sh` script:
```bash
./hashcat_mode0_automation.sh hashes.txt rockyou.txt best64.rule
```

## Target Audience

- Security Operations Center (SOC) analysts
- Penetration testers and red team operators
- Digital forensics investigators
- Security researchers

## Last Updated

November 21, 2025      
