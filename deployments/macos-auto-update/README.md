# Monthly B2/B3 updates

The Samsung TVs allow developer installation only from the Host PC IP configured in Developer Mode.
That address is this Mac, so the updater runs here rather than on a homelab runner.

The LaunchAgent tries both TVs at 20:30 on days 1–7 of each month. A powered-off TV is skipped and
retried the following evening; the automation never powers a TV on. AeroTizen's update command is
idempotent, preserves settings, and does not change Home/startup assignments.

Installed files:

- `~/.local/share/aerotizen-auto/aerotizen` — self-updating standalone CLI
- `~/.local/bin/update-aerotizen-tvs` — bounded update runner
- `~/Library/LaunchAgents/com.imo.aerotizen-monthly.plist` — schedule
- `~/.local/state/aerotizen-auto/` — logs and per-TV results
