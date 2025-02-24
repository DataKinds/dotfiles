#!/bin/bash
cat data.json | jq -r '.data | .[keys[]] | [.word, .sitelen_emosi, .def.en] | @tsv' | rofi -dmenu
