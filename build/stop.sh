#!/bin/bash

# @ 2024.08.24
# oracle stop

current_path=$(PWD)

echo
echo "> Oracle Stop !"

docker compose down oracle

echo
echo "> Colima Stop !"
colima stop

docker ps -a | grep study-oracle-23c

echo
echo "> Oracle Stop Done."
echo

