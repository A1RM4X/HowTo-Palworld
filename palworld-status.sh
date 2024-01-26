#!/bin/bash

echo "-------------------------"
# Set the service name
SERVICENAME="palworld.service"

# Check Status
STATUS="$(systemctl is-active $SERVICENAME)"

if [ "${STATUS}" = "active" ]; then
    echo "Server is running..."
    echo "Have Fun!"
    echo "-------------------------"
    exit 1
fi

# If not active, retrieve the last complete status, including errors
status_result=$(systemctl status $SERVICENAME 2>&1)

echo "Server is offline!"
echo "-------------------------"
echo "$status_result"