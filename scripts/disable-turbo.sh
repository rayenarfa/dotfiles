#!/bin/bash

pkexec cpupower set --turbo-boost 0

notify-send "CPU Turbo" "Turbo Boost disabled (CPU capped around 2.5 GHz)"
