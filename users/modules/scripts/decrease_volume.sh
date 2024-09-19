#! /usr/bin/env bash

if [[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep "MUTED") ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
