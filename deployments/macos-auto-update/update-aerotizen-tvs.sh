#!/bin/sh
set -u

CLI="$HOME/.local/share/aerotizen-auto/aerotizen"
STATE_DIR="$HOME/.local/state/aerotizen-auto"
mkdir -p "$STATE_DIR"

if [ ! -x "$CLI" ]; then
  echo "AeroTizen CLI is not installed at $CLI" >&2
  exit 1
fi

"$CLI" update cli || echo "CLI update failed; continuing with the installed compatible CLI" >&2

for tv in b2-tv.imo.com.au b3-tv.imo.com.au; do
  if "$CLI" --tv "$tv" update launcher; then
    printf '%s %s success\n' "$(date -u +%FT%TZ)" "$tv" >"$STATE_DIR/$tv.status"
  else
    printf '%s %s unreachable-or-failed\n' "$(date -u +%FT%TZ)" "$tv" >"$STATE_DIR/$tv.status"
  fi
done

# A powered-off TV is expected during the retry window. Keep launchd healthy and
# record each result for inspection instead of turning a bedroom TV on.
exit 0
