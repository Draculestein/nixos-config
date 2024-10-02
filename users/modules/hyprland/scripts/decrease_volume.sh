#! /usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
# wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
swayosd-client --output-volume lower