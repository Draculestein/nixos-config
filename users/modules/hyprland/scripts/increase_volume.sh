#! /usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
