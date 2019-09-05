#!/bin/sh
## Exit script if any command fails (non-zero status)
set -e

## Create user (33 is the standard uid/gid for "www-data" in Debian)
addgroup -g 33 ${USER_GROUP}
adduser -u 33 ${USER_NAME} -D -G ${USER_GROUP} -h ${USER_HOME} -s /bin/bash
echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd

#mkdir -p ${USER_HOME}/html/public
#chown -R ${USER_NAME}:${USER_GROUP} ${USER_HOME}

## Make the entrypoint a pass through that then runs the docker command (redirect all input arguments)
exec "$@"
