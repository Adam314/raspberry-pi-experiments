#!/bin/bash


# Sends a open/close param command to a USB relay controller
# via its virtual serial port enumerated as Linux /dev/ttyUSB{x} 
# Usage: bash_relay.sh COMMAND TARGET
#        bash_relay.sh open /dev/ttyUSB1
#        bash_relay.sh close /dev/ttyUSB1
#
# Mfg Style: bash_relay.sh TARGET START_ID SWITCH OP_DATA CHECK
#      Open:
#        bash_relay.sh /dev/ttyUSB1 A0 01 01 A2
#     Close:
#        bash_relay.sh /dev/ttyUSB1 A0 01 00 A1

# If you have multiple TARGET plugged into a USB hub (or different OS types):
#    Linux Mint14 : /dev/ttyUSB0
#    Linux Mint14 : /dev/ttyUSB1
#    Linux Mint14 : /dev/ttyUSB2 . . . etc
#        Mac OS X : /dev/tty.usbmodem00007011
# BeagleBone Black: /dev/cu.usbmodem00007011
#  Windows CYGWIN : '\\.\USBSER000'

# Mfg's Command Example:
# Open the USB switch: A0 0101 A2
# Close the USB switch: A0 0100 A1

COMMAND=$1
TARGET=$2
STATUSFILE="/tmp/bash_relay_status.txt"
byte() {
  printf "\\x$(printf "%x" $1)"
}

if [ $COMMAND = "open" ] 
then
echo "Simple OPEN . . ."
{
  byte 0xA0
  byte 0X01
  byte 0x01
  byte 0xA2
} > $TARGET
echo "1" > $STATUSFILE
fi

if [ $COMMAND = "close" ] 
then
echo "Simple CLOSE . . ."
{
  byte 0xA0
  byte 0X01
  byte 0x00
  byte 0xA1
} > $TARGET
echo "0" > $STATUSFILE
fi

if [ $COMMAND = "status" ]
then
cat $STATUSFILE
fi

if [[ $COMMAND != "close" && $COMMAND != "open" && $COMMAND != "status" ]] 
then
TARGET=$1
START_ID=$2
SWITCH=$3
OP_DATA=$4
CHECK=$5
echo "Mfg style $START_ID $SWITCH $OP_DATA $CHECK > $TARGET . . ."
{
  byte 0x$START_ID
  byte 0X$SWITCH
  byte 0x$OP_DATA
  byte 0x$CHECK
} > $TARGET
fi

# ################
# MORE INFORMATION
# ################
# USB Relay Module USB intelligent control switch.
# http://www.aliexpress.com/item/CH340-USB-Relay-Module-USB-intelligent-control-switch/1906532134.html
 
# Information
# 1, onboard high performance micro controller chip
# 2, onboard CH340 USB control chip
# 3, onboard power LED indicator and relay status LED indicator
# 4, onboard 5V, 10A/250VAC, 10A/30VDC relay, relay’s life is so long, continuous pull 100000 times
# 5, module and relay with overcurrent protection diode freewheeling protection function
# 6, PCB size: 43.6 (mm) x16.4 (mm)

# USB switch default baud rate for the communication: 9600BPS
# USB switch protocol

# Data (1) - start ID (default is 0xA0)
# Data (2) --- switch address code (the default is 0x01, marking the first switch)
# Data (3) - operating data (0x00 is "off", 0x01 is "open")
# Data (4) - check code

# #############################################
# MFG ARDUINO CLONG KERNEL PATCHING INFORMATION
# #############################################
# NOTE: This is not needed, but is included if you are wanting to directly hack the code and 
# change the CH340 as any ATMEL chip using the Arduino IDE. You will need to patch the Linux 
# kernel to do so...

# LINUX CH340 KERNEL PATCH (for programming as an Arduino - but not needed for this example script.)
# Linux patch and driver talked about here :
# http://stackoverflow.com/questions/23040820/driver-ch341-usb-adapter-serial-port-or-qserialport-not-works-in-linux

# #############################################
# KERNEL PATCH FOR LINUX 2.6.25 to 3.13.x (Required for programming only and NOT required for use AS IS from Mfg...)
# #############################################
# See: if anyone have problems with ch341 drivers on Ubuntu 14.04 I have a patched driver and it works with 3.13.X kernel:
# https://www.mediafire.com/?3ph5x6ttc7ddde4
# thanks to:
# http://stackoverflow.com/questions/23040820/driver-ch341-usb-adapter-serial-port-or-qserialport-not-works-in-linux

# Also PATCH from (This is one I have used with success on Mint 14): 
# if you want to install the patched driver, you have to run the ins.sh in the follow file:
# https://www.mediafire.com/?61hpz0c59mqlf6a

# --OpenSource 2015 All rights reserved. (USE AS IT - NO GURATEE)
# bash_relay.sh : Example power relay command script...
# Commited:  01/25/2015 (Demo)
