#!/bin/sh

# Creates a lemonbar clock in right corner
while :; do
	echo "%{c}$(date "+%a %d %b %k:%M:%S")%{c}"
	sleep 1s
done |
lemonbar -b -d -g "150x40+1200+16" -f "lemon:pixelsize=11" -B "#f0f0f0" -F "#70838c"
