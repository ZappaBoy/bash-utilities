#!/usr/bin/env bash
set -euo pipefail

# IMPORTANT:
# Edit /etc/pulse/default.pa
# from "load-module module-stream-restore" to "load-module module-stream-restore restore_device=false"

# Replace following with your outputs
# You can check available sinks with: pactl list short sinks
first_output=alsa_output.pci-0000_00_1f.3.analog-stereo
second_output=alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo

# Replace following with your inputs
# You can check available sources with: pactl list short sources
first_input=alsa_input.usb-CMEDIA_Q9-1-00.mono-fallback
second_input=alsa_input.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.mono-fallback

swap(){
    default_output=$(pactl get-default-sink)
    if [ "$first_output" = "$default_output" ]; then
        pacmd set-default-sink "${second_output}"
        pacmd set-default-source "${second_input}"
    else
        pacmd set-default-sink "${first_output}"
        pacmd set-default-source "${first_input}"
    fi
}

swap
