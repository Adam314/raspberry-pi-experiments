#!/bin/bash

delay=7
device=/dev/ttyUSB0
open="/home/pi/scripts/bash_relay.sh open $device"
close="/home/pi/scripts/bash_relay.sh close $device"
status="/home/pi/scripts/bash_relay.sh status"
logfile="/home/pi/logs/heat.log"

command=$1

if [ $command = "start" ]; then
	$open >> $logfile
	echo $close | at now + $delay min
fi

if [ $command = "stop" ]; then
	$close >> $logfile
fi

if [ $command = "status" ]; then
        $status
fi
