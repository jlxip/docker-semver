#!/bin/bash

# This is the whole point of the action

if [[ ! "$1" =~ [0-9]\.[0-9]\.[0-9](-[0-9A-Za_z-]+)?(\+[0-9A-Za-z-]+)? ]]; then
	echo "Version \"$1\" does not appear to follow SemVer 2.0.0"
	exit 1
fi

# Latest
echo -n "$2:latest,"
# Major
major="$(echo "$1" | cut -d'.' -f1)"
echo -n "$2:$major,"
# Minor
minor="$(echo "$1" | cut -d'.' -f2)"
echo -n "$2:$major.$minor,"
# Patch
echo "$2:$1"
