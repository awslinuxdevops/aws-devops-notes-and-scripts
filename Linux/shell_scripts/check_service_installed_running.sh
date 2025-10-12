#!/bin/bash

SERVICE=$1

if systemctl list-unit-files | grep -q "^$SERVICE.service"; then
	echo "service '$SERVICE' exists."

	if systemctl is-active --quiet $SERVICE; then
		echo "Service '$SERVICE' is running."
	else
		echo "Service '$SERVICE' is not running."
	fi
else
	echo "Service '$SERVICE' does not exists."
fi 


