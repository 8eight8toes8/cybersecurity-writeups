# Hashcat Usage Examples

Comprehensive examples for using Hashcat in various scenarios.

## Basic Dictionary Attack

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt
```

**Explanation:**
- `-m 0`: MD5 hash mode
- `-a 0`: Dictionary attack
- `hashes.txt`: File containing target hashes
- `wordlist.txt`: Dictionary file

## Mask Attack (Brute Force)

```bash
hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a?a?a?a
```

**Explanation:**
- `-m 0`: MD5 hash mode
- `-a 3`: Mask attack
- `?a?a?a?a?a?a?a?a`: 8-character mask using all printable ASCII

**Mask Charsets:**
- `?l` = lowercase letters (a-z)
- `?u` = uppercase letters (A-Z)
- `?d` = digits (0-9)
- `?s` = special characters
- `?a` = all printable ASCII characters

## Hybrid Attack (Dictionary + Mask)

```bash
hashcat -m 0 -a 6 hashes.txt wordlist.txt ?d?d?d?d
```

**Explanation:**
- `-a 6`: Hybrid Wordlist + Mask
- Appends 4 digits to each dictionary word

## Rule-Based Attack

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt -r rules/best64.rule
```

**Explanation:**
- `-r rules/best64.rule`: Apply the best64 rule set
- Rules modify dictionary words (uppercase, append characters, etc.)

## Combinator Attack

```bash
hashcat -m 0 -a 1 hashes.txt wordlist1.txt wordlist2.txt
```

**Explanation:**
- `-a 1`: Combinator attack
- Combines words from two dictionaries

## WPA/WPA2 Handshake

```bash
hashcat -m 22000 -a 0 capture.hc22000 wordlist.txt
```

**Explanation:**
- `-m 22000`: WPA-PBKDF2-PMKID+EAPOL
- Requires converted capture file (use `hcxpcapngtool`)

## Performance Optimization

### Using Multiple GPUs

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt -d 1,2,3
```

**Explanation:**
- `-d 1,2,3`: Use GPUs 1, 2, and 3

### Workload Profile

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt -w 3
```

**Explanation:**
- `-w 3`: High workload (may cause system lag)
- `-w 1`: Low (default)
- `-w 2`: Medium
- `-w 4`: Nightmare (maximum performance)

## Session Management

### Save Session

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt --session mysession
```

### Restore Session

```bash
hashcat --session mysession --restore
```

## Output Options

### Save Cracked Passwords

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt -o cracked.txt
```

### Show Cracked Hashes

```bash
hashcat -m 0 hashes.txt --show
```

## Common Hash Modes

| Mode | Hash Type |
|------|----------|
| 0 | MD5 |
| 100 | SHA1 |
| 1000 | NTLM |
| 1400 | SHA2-256 |
| 1700 | SHA2-512 |
| 3200 | bcrypt |
| 5600 | NetNTLMv2 |
| 13100 | Kerberos 5 TGS-REP |
| 22000 | WPA-PBKDF2-PMKID+EAPOL |

## Advanced Examples

### Custom Charset

```bash
hashcat -m 0 -a 3 hashes.txt -1 ?l?d ?1?1?1?1?1?1?1?1
```

**Explanation:**
- `-1 ?l?d`: Define custom charset 1 as lowercase + digits
- `?1?1?1?1?1?1?1?1`: 8 characters from custom charset 1

### Increment Mode

```bash
hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a?a?a?a --increment
```

**Explanation:**
- `--increment`: Start with shorter masks and increment up to specified length

### Debug Mode

```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt --debug-mode=1 --debug-file=debug.txt
```

**Explanation:**
- `--debug-mode=1`: Save candidates to debug file
- Useful for rule testing

## Tips and Best Practices

1. **Always benchmark first**: `hashcat -b`
2. **Use potfile**: Hashcat automatically saves cracked hashes to `hashcat.potfile`
3. **Monitor temperature**: Use `--hwmon-temp-abort=90` to stop at 90°C
4. **Optimize attack order**: Start with fast attacks (dictionary) before slow ones (brute force)
5. **Use rules efficiently**: Start with small rule sets like `best64.rule`

## Troubleshooting

### No devices found
```bash
hashcat -I  # List OpenCL devices
```

### Force fallback to CPU
```bash
hashcat --force --opencl-device-types=1
```

### Skip warnings
```bash
hashcat --force  # Use with caution
```
