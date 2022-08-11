#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR

sudo killall picocom # just to be sure no-one is using UART

. ./venv/bin/activate
esptool.py --chip esp8266 \
           --port /dev/serial0 \
           --baud 115200 \
           --before default_reset \
           --after hard_reset \
           write_flash \
           -z \
           --flash_mode dio \
           --flash_freq 40m \
           --flash_size 2MB \
           0x0 bootloader.bin \
           0x10000 copilot.bin \
           0x8000 partitions_singleapp.bin
