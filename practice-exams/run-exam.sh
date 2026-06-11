#!/usr/bin/env bash
# run-exam.sh — timed SY0-701 practice-exam runner.
# Usage: ./run-exam.sh exam-01.md
#
# Parses a practice-exam markdown file in this directory, presents each question one at a
# time, records your answers, enforces the 90-minute SY0-701 limit, then scores against the
# answer key and breaks the result down by domain so you know what to redrill.
#
# Question format expected (matches exam-01 / exam-03):
#   **Q12 (D4) ...** stem...
#   - A. ...
#   answer key line: **Q12 — B ...** explanation
set -u

FILE="${1:-}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -z "$FILE" ] && { echo "Usage: $0 <exam-file.md>"; exit 1; }
[ -f "$DIR/$FILE" ] || { echo "Not found: $DIR/$FILE"; exit 1; }

LIMIT=$((90 * 60))            # SY0-701: 90 questions / 90 minutes — same per-question budget
START=$(date +%s)

# Pull question numbers + their domain tag from the stem lines (not the answer-key lines).
mapfile -t QLINES < <(grep -nE '^\*\*Q[0-9]+ \(D[0-9]\)' "$DIR/$FILE")
declare -A DOMAIN ANSWER CORRECT
QNUMS=()
for line in "${QLINES[@]}"; do
  q=$(sed -E 's/.*\*\*Q([0-9]+).*/\1/' <<<"$line")
  d=$(sed -E 's/.*\(D([0-9])\).*/\1/' <<<"$line")
  QNUMS+=("$q"); DOMAIN[$q]=$d
done

# Pull the correct letter from each answer-key line: **Q12 — B ...**
while IFS= read -r line; do
  q=$(sed -E 's/.*Q([0-9]+) —.*/\1/' <<<"$line")
  c=$(sed -E 's/.*Q[0-9]+ — ([A-D]).*/\1/' <<<"$line")
  CORRECT[$q]=$c
done < <(grep -E '^\*\*Q[0-9]+ — [A-D]' "$DIR/$FILE")

echo "=== $FILE — ${#QNUMS[@]} questions, 90-minute limit ==="
echo "Type a letter (A-D) for each, or 's' to skip. Ctrl-C aborts."
echo

extract_q() {  # print stem + options for question $1
  awk -v q="\\*\\*Q$1 \\(" '
    $0 ~ q {p=1}
    p && /^\*\*Q[0-9]+ — / {exit}                 # stop at answer key
    p && /^---$/ && seen {exit}
    p {print; if ($0 ~ /^- [A-D]\./) seen=1}
    p && /^\*\*Q[0-9]+ \(/ && !first {first=1}
  ' "$DIR/$FILE" | sed -n '1,12p'
}

for q in "${QNUMS[@]}"; do
  now=$(date +%s); elapsed=$((now - START))
  if [ $elapsed -ge $LIMIT ]; then echo; echo "*** 90-minute limit reached — stopping. ***"; break; fi
  remain=$(( (LIMIT - elapsed) / 60 ))
  echo "----- Q$q  (D${DOMAIN[$q]})  [${remain} min left] -----"
  extract_q "$q"
  printf "Your answer (A-D/s): "
  read -r ans </dev/tty
  ANSWER[$q]=$(tr '[:lower:]' '[:upper:]' <<<"${ans:0:1}")
  echo
done

# Score.
declare -A DTOTAL DCORRECT
total=0; right=0
for q in "${QNUMS[@]}"; do
  d=${DOMAIN[$q]}; DTOTAL[$d]=$(( ${DTOTAL[$d]:-0} + 1 )); total=$((total+1))
  if [ "${ANSWER[$q]:-}" = "${CORRECT[$q]:-X}" ]; then
    right=$((right+1)); DCORRECT[$d]=$(( ${DCORRECT[$d]:-0} + 1 ))
  fi
done

elapsed=$(( $(date +%s) - START ))
echo "================ RESULT ================"
printf "Score: %d / %d  (%d%%)   Time: %dm%02ds\n" \
  "$right" "$total" $(( total ? right*100/total : 0 )) $((elapsed/60)) $((elapsed%60))
echo "Pass line ≈ 83% (750/900 scaled)."
echo
echo "By domain (weakest first — redrill the bottom):"
for d in 1 2 3 4 5; do
  t=${DTOTAL[$d]:-0}; [ "$t" -eq 0 ] && continue
  c=${DCORRECT[$d]:-0}
  printf "  D%s: %d/%d (%d%%)\n" "$d" "$c" "$t" $(( c*100/t ))
done | sort -t'(' -k2 -n
echo
echo "Log every miss in error-log.md by domain + trap type."
