#!/bin/sh

set -e

if [ "${1#-}" != "$1" ]
then
	set -- /usr/local/bin/minica "$@"
fi

exec "$@"
