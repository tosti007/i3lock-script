#!/bin/bash

##############################
# Static variables
##############################
dir_name="i3lock-script"
dir_config="${XDG_CONFIG_HOME:-"$HOME/.config"}/$dir_name"
dir_cache="${XDG_CACHE_HOME:-"$HOME/.cache"}/$dir_name"

file_config="$dir_config/config"
file_defaults="$(realpath $(dirname $0)/i3lock-script-defaults)"

file_lock="$dir_cache/lock"
file_background="$dir_cache/background.png"

color_transparent='00000000'

cd "$dir_config"

##############################
# Helper function(s)
##############################
function get-value-from() {
	git config -f "$1" "$2"
}

function get-value-raw() {
	if [ -n "$file_pywal" ]; then
		get-value-from "$file_pywal" "$1"
		if [ $? -eq 0 ]; then
			return 0
		fi
	fi
	get-value-from "$file_config" "$1"
	if [ $? -eq 0 ]; then
		return 0
	fi
	get-value-from "$file_defaults" "$1"
}

function get-value() {
	result=$(get-value-raw "$1")
	status=$?
	if [[ $status -eq 0 && "$result" =~ ^\$.*\..*$ ]]; then
		result=$(get-value "${result:1}")
		status=$?
	fi
	echo "$result"
	return $status
}
