#!/usr/bin/env bash

inputFile="${1}"
if [[ -f "${inputFile}" ]]; then
    gm convert -resize 700! "${inputFile}" -quality 90 "$(dirname "${inputFile}")/700x700.jpg"
fi
