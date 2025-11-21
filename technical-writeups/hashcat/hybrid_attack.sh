#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

HASHFILE="${1}"
WORDLIST="${2}"
MASK="${3}"
MODE="${4:-6}"  # 6=word+mask, 7=mask+word
HASHMODE="${5:-1000}"
SESSIONNAME="hybrid_attack_$(date +%s)"
OUTPUTDIR="./.hashcat_results/$(date +%Y%m%d_%H%M%S)"

log() { echo -e "${GREEN}✓${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*" >&2; exit 1; }
warn() { echo -e "${YELLOW}!${NC} $*"; }

[[ -z "$HASHFILE" ]] && error "Hash file required"
[[ ! -f "$HASHFILE" ]] && error "Hash file not found"
[[ ! -f "$WORDLIST" ]] && error "Wordlist not found"

mkdir -p "$OUTPUTDIR"

MODEDESC=$([ "$MODE" -eq 6 ] && echo "Wordlist + Mask" || echo "Mask + Wordlist")

log "Hybrid Attack Configuration"
echo "Hash file: $HASHFILE"
echo "Wordlist: $WORDLIST ($(wc -l < "$WORDLIST") entries)"
echo "Mask: $MASK"
echo "Mode: $MODE ($MODEDESC)"
echo "Hash mode: $HASHMODE"
echo
echo "Examples:"
echo "  Mode 6: password123 (wordlist + 3 digits)"
echo "  Mode 7: 2024password (4 digits + wordlist)"
echo

read -p "Proceed? (y/n) " -n 1 -r
echo
[[ ! $REPLY =~ ^[Yy]$ ]] && { log "Cancelled"; exit 0; }

log "Starting hybrid attack ($MODEDESC)..."

hashcat -a "$MODE" -m "$HASHMODE" "$HASHFILE" "$WORDLIST" "$MASK" \
    --session "$SESSIONNAME" \
    -o "${OUTPUTDIR}/cracked.txt" \
    --outfile-format=3 \
    -w 3 \
    --status \
    --status-timer 30

[[ -f "${OUTPUTDIR}/cracked.txt" ]] && {
    wc -l < "${OUTPUTDIR}/cracked.txt" | xargs echo "Cracked:"
} || echo "No results"

log "Done"
