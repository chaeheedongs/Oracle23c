#!/bin/bash

# @ 2024.08.24
# oracle 23c

## Import

## Env
current_path=$(PWD)

## Fn
function exec_oracle_compose() {
    docker compose up -d oracle
}

function print_docker_process() {
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.RunningFor}}"
}

function check_docker_compose() {
    docker compose version
}

function check_docker() {
    docker -v
}

function check_brew() {
	brew -v
	brew list | grep colima
}

## Process
check_brew
check_docker
check_docker_compose
exec_oracle_compose
print_docker_process