#!/bin/bash
set -e

echo "Welcome to docker :)"

# Boot any servers you need to
# bash -l -c "nodejs /app/node_server.js &"


# Spawn bash if we're booting in console mode
if [ "$1" = 'bash' ]; then
    /bin/bash
    exit
fi

# This line keeps the container alive
exec tail -f /var/log/dmesg
