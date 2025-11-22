#!/bin/bash
# Hashcat Mode 0 (Dictionary) Attack Automation
# Production-ready script for dictionary attacks with rules

set -e  # Exit on error

# === TITLE ===
# Usage: ./hashcat_mode0_automation.sh <hashfile> [wordlist] [rules]

# === Colors for output ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

# === Default values ===
HASHFILE="$1"
WORDLIST="${2:-/usr/share/wordlists/rockyou.txt}"
RULES="${3:-/usr/share/hashcat/rules/best64.rule}"
HASHMODE="${HASHMODE:-1000}"  # NTLM (change as needed)
SESSIONNAME="dict_attack_$(date +%s)"
OUTPUTDIR="./hashcat_results/$(date +%Y%m%d_%H%M%S)"

# === Functions ===
log() { echo -e "${GREEN}[+]${NC} $*"; }
error() { echo -e "${RED}[!]${NC} $*" >&2; }
warn() { echo -e "${YELLOW}[*]${NC} $*"; }

usage() {
    cat << EOF
Usage: $0 <hashfile> [wordlist] [rules]

Arguments:
  hashfile    Required. Path to hash file
  wordlist    Optional. Path to wordlist (default: rockyou.txt)
  rules       Optional. Path to rules file (default: best64.rule)

Environment Variables:
  HASHMODE    Hashcat mode (default: 1000 - NTLM)

Examples:
  $0 hashes.txt
  $0 hashes.txt /usr/share/wordlists/rockyou2021.txt
  $0 hashes.txt rockyou.txt /usr/share/hashcat/rules/OneRuleToRuleThemAll.rule

Hash Modes:
  0     = MD5
  1000  = NTLM (default)
  5600  = NetNTLMv2
  3200  = bcrypt
  1800  = sha512crypt
EOF
    exit 1
}

# === Validation ===
if [ -z "$HASHFILE" ]; then
    error "Hash file required"
    usage
fi

if [ ! -f "$HASHFILE" ]; then
    error "Hash file not found: $HASHFILE"
    exit 1
fi

if [ ! -f "$WORDLIST" ]; then
    error "Wordlist not found: $WORDLIST"
    exit 1
fi

if [ ! -f "$RULES" ]; then
    warn "Rules file not found: $RULES"
    warn "Proceeding without rules..."
    RULES=""
fi

# === Pre-flight checks ===
log "Validating environment..."

if ! command -v hashcat &> /dev/null; then
    error "hashcat not found in PATH"
    exit 1
fi

if ! command -v nvidia-smi &> /dev/null; then
    warn "nvidia-smi not found - verify GPU drivers installed"
else
    log "GPU Status:"
    nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits
fi

# === Create output directory ===
mkdir -p "$OUTPUTDIR"
log "Output directory: $OUTPUTDIR"

# === Display configuration ===
log "Attack Configuration:"
echo "  Hash file:     $HASHFILE"
echo "  Hash count:    $(wc -l < "$HASHFILE")"
echo "  Hash mode:     $HASHMODE"
echo "  Wordlist:      $WORDLIST"
echo "  Wordlist size: $(wc -l < "$WORDLIST") entries"
if [ -n "$RULES" ]; then
    echo "  Rules:         $RULES"
else
    echo "  Rules:         None"
fi
echo "  Session:       $SESSIONNAME"
echo "  Output dir:    $OUTPUTDIR"
echo ""

# === Confirm before starting ===
read -p "Proceed with attack? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Attack cancelled"
    exit 0
fi

# === Start attack ===
log "Starting hashcat attack..."
log "Time: $(date)"
echo ""

if [ -n "$RULES" ]; then
    hashcat -m "$HASHMODE" "$HASHFILE" "$WORDLIST" \
        -r "$RULES" \
        --session "$SESSIONNAME" \
        -o "$OUTPUTDIR/cracked.txt" \
        --outfile-format=3 \
        -w 3 \
        --status \
        --status-timer=30
else
    hashcat -m "$HASHMODE" "$HASHFILE" "$WORDLIST" \
        --session "$SESSIONNAME" \
        -o "$OUTPUTDIR/cracked.txt" \
        --outfile-format=3 \
        -w 3 \
        --status \
        --status-timer=30
fi

# === Post-attack analysis ===
log "Attack complete"
log "Time: $(date)"
echo ""

if [ -f "$OUTPUTDIR/cracked.txt" ]; then
    CRACKED=$(wc -l < "$OUTPUTDIR/cracked.txt")
    TOTAL=$(wc -l < "$HASHFILE")
    SUCCESS=$((CRACKED * 100 / TOTAL))
    
    log "Results:"
    echo "  Total hashes:  $TOTAL"
    echo "  Cracked:       $CRACKED"
    echo "  Success rate:  $SUCCESS%"
    echo ""
    
    log "Sample cracked passwords:"
    head -10 "$OUTPUTDIR/cracked.txt" | cut -d: -f3 | nl
    echo ""
    
    # Extract plaintext passwords only
    hashcat -m "$HASHMODE" "$HASHFILE" --show --outfile-format=2 > "$OUTPUTDIR/passwords_only.txt" 2>/dev/null || true
    
    log "Output files:"
    echo "  Full results:      $OUTPUTDIR/cracked.txt"
    echo "  Passwords only:    $OUTPUTDIR/passwords_only.txt"
    echo "  Session file:      ~/.hashcat/sessions/$SESSIONNAME.restore"
else
    warn "No cracked hashes found"
fi

echo ""
log "Done"
