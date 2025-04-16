#!/bin/bash

# This script updates the worker.service.ts file of the Angular application with the public IP address of the server.

# Usage: ./updateFile.sh

# Define the path to the worker.service.ts file
FILE_PATH="/home/ubuntu/Three-tier-Angular-Application/angular-fronted/src/app/services/worker.service.ts"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "File not found!"
    exit 1
fi

# Get the public IP address of the server
INSTANCE_ID="i-0c12bd01948bb6332"

ipv4_address=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "Failed to get the public IP address"
    exit 1
fi

# Update the worker.service.ts file with the new IP address

sed -i "s|http://localhost:8080/api/v1/workers|http://${ipv4_address}:8080/api/v1/workers|g" "$FILE_PATH"

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "Failed to update the file"
    exit 1
else
    echo "File updated successfully with the new IP address: $ipv4_address"
fi
