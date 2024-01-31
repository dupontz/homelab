#!/bin/sh

[ -f "/etc/netplan/51-static.yaml" ] && exit 0

while [ ! -f /etc/netplan/50-cloud-init.yaml ];
do
        sleep 1
done

IFACE=$(grep 'set-name:' /etc/netplan/50-cloud-init.yaml | tr -d [:space:] | cut -f2 -d':')

curl -fsSL https://tailscale.com/install.sh | sh

sudo tailscale up --authkey=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe

printf 'network:\n  ethernets:\n    %s:\n      addresses: [ 198.19.0.1/20 ]\n  version: 2' $IFACE | tee /etc/netplan/51-static.yaml
