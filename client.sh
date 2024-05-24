#!/bin/sh

if which xclip; then
	COPY='xclip -selection c'
elif which pbcopy; then
	COPY='pbcopy'
else
	echo 'failed to detect clipboard cli' >&2
	exit 1
fi

ssh "$@" rclip-handler | (
	while input size; do
		head -c"$size" | "$COPY"
	done
)
