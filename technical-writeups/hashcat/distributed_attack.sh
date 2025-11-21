#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

HASHFILE="${1}"
WORDLIST="${2}"
NUMGPUS="${3:-2}"
SESSIONBASE="distributed_$(date +%s)"

log() { echo -e "${GREEN}✓${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*" >&2; exit 1; }

[[ ! -f "$HASHFILE" ]] && error "Hash file not found"
[[ ! -f "$WORDLIST" ]] && error "Wordlist not found"

log "Distributed attack on $NUMGPUS GPUs"
log "Hash file: $HASHFILE"
log "Wordlist: $WORDLIST"
echo

# Get total wordlist size
WORDLIST_LINES=$(wc -l < "$WORDLIST")
BATCH_SIZE=$((WORDLIST_LINES / NUMGPUS))

log "Distributing $WORDLIST_LINES entries across $NUMGPUS GPUs"
echo "Batch size per GPU: $BATCH_SIZE entries"
echo

# Launch parallel attacks
for gpu in $(seq 0 $((NUMGPUS-1))); do
    START=$((gpu * BATCH_SIZE))
    END=$(((gpu + 1) * BATCH_SIZE))
    
    log "GPU $gpu: Processing entries $START-$END"
    
    hashcat -m 1000 "$HASHFILE" "$WORDLIST" \
        -d $((gpu + 1)) \
        --skip "$START" \
        --limit "$BATCH_SIZE" \
        -r /usr/share/hashcat/rules/best64.rule \
        --session "${SESSIONBASE}_gpu${gpu}" \
        -o "results_gpu${gpu}.txt" \
        --outfile-format=3 \
        -w 3 &
done

wait
log "All GPU tasks complete"

# Merge results
log "Merging results..."
cat results_gpu*.txt > merged_results.txt 2>/dev/null || true
wc -l merged_results.txt | xargs echo "Total Cracks:"
