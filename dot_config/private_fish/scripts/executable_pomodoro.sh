#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  🍅 Pomodoro Timer
#  Usage: ./pomodoro.sh [work_mins] [short_break] [long_break] [sessions_before_long]
#  Defaults: 25 / 5 / 15 / 4
#  Press Space or p to pause/resume during a countdown
# ─────────────────────────────────────────────

# Safe integer parse: strip non-digits, return default if empty/zero
parse_int() {
  local raw="${1//[^0-9]/}"
  local default="$2"
  if [[ -n "$raw" && "$raw" -gt 0 ]]; then
    echo "$raw"
  else
    echo "$default"
  fi
}

WORK_MINS=$(parse_int "${1}" 25)
SHORT_BREAK=$(parse_int "${2}" 5)
LONG_BREAK=$(parse_int "${3}" 15)
LONG_EVERY=$(parse_int "${4}" 4)

session=0
paused=0

# ── Colors ──────────────────────────────────
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[0;33m'
BLU='\033[0;34m'
DIM='\033[2m'
BLD='\033[1m'
RST='\033[0m'

# ── Notification helper ──────────────────────
notify() {
  local title="$1" msg="$2"
  if command -v osascript &>/dev/null; then
    osascript -e "display notification \"$msg\" with title \"$title\" sound name \"Glass\"" 2>/dev/null
  elif command -v notify-send &>/dev/null; then
    notify-send "$title" "$msg"
  fi
}

bell() { printf '\a'; }

# ── Countdown with pause support ─────────────
countdown() {
  local total_secs=$(( $1 * 60 ))
  local label="$2"
  local color="$3"
  local remaining=$total_secs
  paused=0

  # Read keypresses without blocking the countdown
  # We use a background read loop writing to a tmp file
  local keyfile
  keyfile=$(mktemp)

  # Put terminal in raw mode so Space is caught instantly
  local old_stty
  old_stty=$(stty -g)
  stty -echo -icanon min 0 time 0

  # Cleanup on exit
  local cleanup="stty '$old_stty'; rm -f '$keyfile'"
  trap "$cleanup" RETURN

  while (( remaining > 0 )); do
    # Check for keypress
    local key
    key=$(dd bs=1 count=1 2>/dev/null < /dev/tty)
    if [[ "$key" == " " || "$key" == "p" || "$key" == "P" ]]; then
      paused=$(( 1 - paused ))
    fi

    if (( paused )); then
      local mins=$(( remaining / 60 ))
      local secs=$(( remaining % 60 ))
      local elapsed=$(( total_secs - remaining ))
      local pct=$(( elapsed * 20 / total_secs ))
      local bar=""
      for (( i=0; i<20; i++ )); do
        (( i < pct )) && bar+="█" || bar+="░"
      done
      printf "\r  ${YLW}${BLD}%-14s${RST}  ${DIM}[%s]${RST}  %02d:%02d  ${YLW}⏸ PAUSED${RST}  " \
        "$label" "$bar" "$mins" "$secs"
      sleep 0.2
      continue
    fi

    local mins=$(( remaining / 60 ))
    local secs=$(( remaining % 60 ))
    local elapsed=$(( total_secs - remaining ))
    local pct=$(( elapsed * 20 / total_secs ))
    local bar=""
    for (( i=0; i<20; i++ )); do
      (( i < pct )) && bar+="█" || bar+="░"
    done

    printf "\r  ${color}${BLD}%-14s${RST}  ${color}[%s]${RST}  %02d:%02d  ${DIM}[p] pause${RST}   " \
      "$label" "$bar" "$mins" "$secs"

    sleep 1
    (( remaining-- ))
  done

  stty "$old_stty"
  rm -f "$keyfile"
  printf "\r%-70s\r" ""   # clear line
}

# ── Header ───────────────────────────────────
clear
printf "\n  ${RED}${BLD}🍅 Pomodoro Timer${RST}\n"
printf "  Work %dm  ·  Short break %dm  ·  Long break %dm  ·  Long every %d\n\n" \
  "$WORK_MINS" "$SHORT_BREAK" "$LONG_BREAK" "$LONG_EVERY"

trap 'printf "\n\n  ${YLW}Stopped after %d session(s). Great work!${RST}\n\n" "$session"; exit 0' INT

# ── Main loop ────────────────────────────────
while true; do
  (( session++ ))
  printf "  ${BLD}Session $session${RST}  $(date +%H:%M)\n"

  # Work
  countdown "$WORK_MINS" "🍅 Focus" "$RED"
  bell
  printf "  ${GRN}${BLD}Work done!${RST}\n"
  notify "🍅 Pomodoro" "Work session $session complete — take a break!"

  # Pick break length
  if (( session % LONG_EVERY == 0 )); then
    printf "  ${BLU}${BLD}Long break (%d min)…${RST}\n" "$LONG_BREAK"
    countdown "$LONG_BREAK" "☕ Long break" "$BLU"
    notify "🍅 Pomodoro" "Long break over — back to work!"
  else
    printf "  ${GRN}${BLD}Short break (%d min)…${RST}\n" "$SHORT_BREAK"
    countdown "$SHORT_BREAK" "🌿 Short break" "$GRN"
    notify "🍅 Pomodoro" "Break over — ready to focus!"
  fi

  bell
  printf "\n"
done
