#!/bin/bash

COMPOSE=nvidia-docker-compose

case $1 in

  build)
    $COMPOSE build
    ;;

  up)
    $COMPOSE up # -d
    ;;

  down)
    $COMPOSE down 
    rm nvidia-docker-compose.yml
    ;;

  status)
    $COMPOSE ps
    ;;

  tail)
    docker logs -f orbslam
    ;;

  shell)
    docker exec orbslam /bin/bash
    ;;

  *)
    echo "Usage $0 [ build | up | down | status | tail | shell ]"
    ;;

esac
