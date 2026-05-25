#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  🍅 Pomodoro Timer
#  Usage: ./pomodoro.sh [work_mins] [short_break] [long_break] [sessions_before_long]
#  Defaults: 25 / 5 / 15 / 4
# ─────────────────────────────────────────────

# Strip any non-digit characters (commas, spaces, etc.) and fall back to defaults
WORK_MINS=$(( ${1//[^0-9]/} > 0 ? ${1//[^0-9]/} : 25 ))
SHORT_BREAK=$(( ${2//[^0-9]/} > 0 ? ${2//[^0-9]/} : 5 ))
LONG_BREAK=$(( ${3//[^0-9]/} > 0 ? ${3//[^0-9]/} : 15 ))
LONG_EVERY=$(( ${4//[^0-9]/} > 0 ? ${4//[^0-9]/} : 4 ))

session=0

# ── Colors ──────────────────────────────────
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[0;33m'
BLU='\033[0;34m'
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

# ── Bell ────────────────────────────────────
bell() { printf '\a'; }

# ── Countdown display ────────────────────────
countdown() {
  local total_secs=$(( $1 * 60 ))
  local label="$2"
  local color="$3"
  local end=$(( SECONDS + total_secs ))

  while (( SECONDS < end )); do
    local remaining=$(( end - SECONDS ))
    local mins=$(( remaining / 60 ))
    local secs=$(( remaining % 60 ))
    local elapsed=$(( total_secs - remaining ))
    local pct=$(( elapsed * 20 / total_secs ))   # out of 20 chars
    local bar=""
    for (( i=0; i<20; i++ )); do
      (( i < pct )) && bar+="█" || bar+="░"
    done

    printf "\r  ${color}${BLD}%-14s${RST}  ${color}[%s]${RST}  %02d:%02d  " \
      "$label" "$bar" "$mins" "$secs"
    sleep 1
  done
  printf "\r%-60s\r" ""   # clear line
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
