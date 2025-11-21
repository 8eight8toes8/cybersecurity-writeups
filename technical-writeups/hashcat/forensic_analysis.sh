#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

HASHFILE="${1}"
CASEID="${2:-CASE_$(date +%Y%m%d_%H%M%S)}"
EVIDENCEDIR="./forensic_${CASEID}"

log() { echo -e "${GREEN}✓${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*" >&2; exit 1; }

[[ ! -f "$HASHFILE" ]] && error "Hash file not found"

mkdir -p "$EVIDENCEDIR"

# Chain of custody log
COCLOG="${EVIDENCEDIR}/chain_of_custody.log"
{
    echo "=== CHAIN OF CUSTODY LOG ==="
    echo "Case ID: $CASEID"
    echo "Analyst: $(whoami)"
    echo "DateTime: $(date)"
    echo "Hash file: $HASHFILE"
    echo "Hash file MD5: $(md5sum "$HASHFILE" | cut -d' ' -f1)"
    echo "Hash count: $(wc -l < "$HASHFILE")"
    echo "Evidence location: $EVIDENCEDIR"
    echo
} > "$COCLOG"

log "Forensic Analysis - Case $CASEID"
log "Chain of custody: $COCLOG"
echo

# Phase 1: Dictionary analysis
log "Phase 1: Dictionary analysis"
START=$(date +%s)

hashcat -m 1000 "$HASHFILE" /usr/share/wordlists/rockyou.txt \
    -r /usr/share/hashcat/rules/best64.rule \
    --debug-mode=5 \
    --debug-file="${EVIDENCEDIR}/rule_analysis.txt" \
    --session "${CASEID}_p1" \
    -o "${EVIDENCEDIR}/phase1_results.txt" \
    --outfile-format=15 \
    -w 3

END=$(date +%s)
DURATION=$((END - START))

{
    echo "=== PHASE 1 RESULTS ==="
    echo "Duration: ${DURATION}s"
    echo "Hashes cracked: $(wc -l < "${EVIDENCEDIR}/phase1_results.txt")"
    echo "Timestamp: $(date)"
} >> "$COCLOG"

# Extract passwords for analysis
hashcat -m 1000 "$HASHFILE" --show --outfile-format=2 > "${EVIDENCEDIR}/recovered_passwords.txt" 2>/dev/null || true

log "Analysis complete"
log "Evidence directory: $EVIDENCEDIR"
ls -lh "$EVIDENCEDIR"
