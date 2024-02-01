#!/bin/sh

[ -f "/etc/netplan/51-static.yaml" ] && exit 0

while [ ! -f /etc/netplan/50-cloud-init.yaml ];
do
        sleep 1
done

IFACE=$(grep 'set-name:' /etc/netplan/50-cloud-init.yaml | tr -d [:space:] | cut -f2 -d':')

printf 'network:\n  ethernets:\n    %s:\n      addresses: [ 198.19.0.10/20 ]\n  version: 2' $IFACE | tee /etc/netplan/51-static.yaml
