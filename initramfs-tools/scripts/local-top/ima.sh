#!/bin/sh

PREREQ=""

# Output pre-requisites

prereqs()
{
    echo "$PREREQ"
}

case "$1" in
    prereqs)
        prereqs
        exit 0
    ;;
esac

grep -q "ima=off" /proc/cmdline && exit 1

mount -n -t securityfs securityfs /sys/kernel/security
