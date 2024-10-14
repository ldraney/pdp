#!/bin/bash
action=$1
if [ "$action" = "set" ]; then
    xclip -selection clipboard
elif [ "$action" = "get" ]; then
    xclip -selection clipboard -o
fi
