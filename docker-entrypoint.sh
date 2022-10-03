#!/bin/bash

node /home/theia/src-gen/backend/main.js /home/project --hostname 0.0.0.0
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start theia: $status"
  exit $status
fi