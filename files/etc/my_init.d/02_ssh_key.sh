#!/bin/bash
set -e
mkdir -p /var/go/.ssh
cp /etc/secrets/id_rsa /var/go/.ssh/id_rsa
chown -R go:go /var/go/.ssh
chmod 0400 /var/go/.ssh/id_rsa
