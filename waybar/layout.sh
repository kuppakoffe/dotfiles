#!/bin/sh

swaymsg \
  --type get_inputs | \
  jq \
    --raw-output \ '
      [
        .[] |
          select(.type == "keyboard") |
          .xkb_active_layout_name |
          select(contains("English (US)") | not)
      ] |
        first // "English"
    '

swaymsg \
  --type subscribe \
  --monitor \
  --raw \
  '["input"]' | \
  jq \
    --raw-output \
    --unbuffered \ '
      select(.change == "xkb_layout") |
        .input.xkb_active_layout_name |
        sub(" \\(US\\)"; "")
    '
