#!/bin/bash
set -e

if [ -z "$LOG_LEVEL" ]; then
    LOG_LEVEL=info
fi

if [ "$1" = "worker" ]; then
    /usr/local/bin/celery -A tasks worker --loglevel=$LOG_LEVEL -n $HOSTNAME
elif [ "$1" = "beat" ]; then

    if [ -z "$SCHEDULE" ]; then
        SCHEDULE=/home/snek/celerybeat-schedule
    fi

    if [ -z "$PIDFILE" ]; then
        PIDFILE=/tmp/celerybeat.pid
    fi

    /usr/local/bin/celery -A tasks beat --loglevel=$LOG_LEVEL -s $SCHEDULE --pidfile $PIDFILE
elif [ "$1" = "flower" ]; then

    if [ -z "$BROKER_API" ]; then
        BASIC_AUTH=guest:guest
    fi

    /usr/local/bin/celery -A tasks flower --broker_api=$BROKER_API --basic_auth=$BASIC_AUTH
else
    exec "$@"
fi
