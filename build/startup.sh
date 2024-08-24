#!/bin/bash

# @ 2024.08.24
# oracle stop

current_path=$(PWD)

echo
echo "> Colima Start !"

colima start

echo
echo "> Oracle Start !"

docker compose up -d oracle

docker ps -a | grep study-oracle-23c

echo
echo "> Oracle Start Done."
echo

