#!/bin/bash
var=$(zenity --entry \
--title="Add Application" \
--text="Use a custom command" \
--width="320")
if [ $? -eq 0 ] && [ "$var" ]; then
    $var "$1"
else
    exit 0
fi
