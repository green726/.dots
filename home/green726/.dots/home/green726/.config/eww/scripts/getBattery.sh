#!/bin/bash

## Get battery info
BATTERY="$(cat /sys/class/power_supply/BAT0/capacity)"
CHARGE="$(acpi | awk -F ' ' 'END {print $3}' | tr -d \,)"

main() {
	if [[ ($CHARGE = *"Charging"*) && ($BATTERY -lt "100") ]]; then
		echo "󰠠"
	elif [[ $CHARGE = *"Full"* ]]; then
		echo ""
	else
	    if [[ ($BATTERY -lt 100) && (($BATTERY -gt 90) || ($BATTERY -eq 90)) ]]; then
			echo ""
		elif [[ ($BATTERY -lt 90) && (($BATTERY -gt 65) || ($BATTERY -eq 65)) ]]; then
			echo ""
		elif [[ ($BATTERY -lt 65) && (($BATTERY -gt 35) || ($BATTERY -eq 35)) ]]; then
			echo ""
		elif [[ ($BATTERY -lt 35) && (($BATTERY -gt 10) || ($BATTERY -eq 10)) ]]; then
			echo ""
		elif [[ ($BATTERY -lt 10) && (($BATTERY -gt 0) || ($BATTERY -eq 0)) ]]; then
			echo ""
		fi
	fi
}

if [[ $1 == 'icon' ]]; then
	main
elif [[ $1 == 'capacity' ]]; then
	echo "${BATTERY}"
fi
