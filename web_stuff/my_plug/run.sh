#!/bin/bash

case $1 in
  app)
    PORT=$2 mix run --no-halt
    ;;
  app_on_node)
    PORT=$2 NODE=$3 COOKIE=$4 HOSTNAME=$(hostname) iex --sname $3 --cookie $4 -S mix run --no-halt
    ;;
  esac
exit 0
