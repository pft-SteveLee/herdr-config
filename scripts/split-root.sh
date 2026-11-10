#!/usr/bin/env bash
set -euo pipefail

direction="${1:?usage: split-root.sh right|down}"
herdr_bin="${HERDR_BIN_PATH:-herdr}"
herdr_bin="${herdr_bin% (deleted)}"

paneId=$("$herdr_bin" pane list | jq -r '.result.panes[] | select(.focused) | .pane_id' | head -n1)
cwd=$("$herdr_bin" pane get "$paneId" | jq -r '.result.pane.foreground_cwd // .result.pane.cwd')

case "$cwd" in
  */.claude/worktrees/*) cwd="${cwd%%/.claude/worktrees/*}" ;;
esac

"$herdr_bin" pane split "$paneId" --direction "$direction" --cwd "$cwd" --focus
