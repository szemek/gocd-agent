#!/bin/bash
set -e
export GO_SERVER_URL="https://${GO_SERVER}:8154/go"
sed -i "s|GO_SERVER_URL=.*|GO_SERVER_URL=${GO_SERVER_URL}|g" /etc/default/go-agent
/etc/init.d/go-agent start
