#!/bin/sh
# CyberCTF per-player flag, added by the overlay (the vendored benchmark is unchanged).
# The Dockerfile bakes a development flag in at build time. At every start this wrapper puts
# the player's flag in its place (CTF_FLAG_MAIN, given by the launcher; else /ctf/flag, written
# by ctf/flag.sh on an earlier start; else the development flag), then starts the benchmark
# exactly as before.
dev='FLAG{dev-xben-055-auth-5}'
baked='FLAG{3c8d37d2b7349c6124d67400ab817bed508eb3a155f2a0a1699732b1c120d86e}'
flag=${CTF_FLAG_MAIN:-}
if [ -z "$flag" ] && [ -s /ctf/flag ]; then flag=$(cat /ctf/flag); fi
[ -n "$flag" ] || flag=$dev
# Swap the value currently in the benchmark's files (the baked one on a first start).
state=/var/lib/ctf-flag.current
cur=$baked
[ -s "$state" ] && cur=$(cat "$state")
if [ "$cur" != "$flag" ]; then
  d=$(printf '\001')
  pat=$(printf '%s' "$cur" | sed 's/[]\\$*.^[]/\\&/g')
  rep=$(printf '%s' "$flag" | sed 's/[\\&]/\\&/g')
  for f in '/var/www/html/index.php'; do
    [ -f "$f" ] && sed -i "s${d}${pat}${d}${rep}${d}g" "$f"
  done
  mkdir -p /var/lib && printf '%s' "$flag" > "$state" && chmod 600 "$state"
fi
unset CTF_FLAG_MAIN
exec "$@"
