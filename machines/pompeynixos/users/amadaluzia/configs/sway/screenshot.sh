#!/usr/bin/env bash
if ! ls "${HOME}/Pictures/Screenshots/"; then
	mkdir -p "${HOME}/Pictures/Screenshots/"
fi
grimshot savecopy screen "${HOME}/Pictures/Screenshots/$(date).png"
