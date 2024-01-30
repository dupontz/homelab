#!/bin/bash

TOKEN=""
TAILSCALE_AUTH_TOKEN=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe

while [ -z "$TOKEN" ]
do
	sleep 1
	TOKEN=$(echo sudo cat /var/lib/rancher/k3s/server/node-token | ssh -i /home/ubuntu/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@198.19.0.1 | grep '::server:')
    SERVER_IP=$( ssh -i /home/ubuntu/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@198.19.0.1 ifconfig tailscale0 | awk -F ' *|:' '/inet /{print $3}' | grep .)
done

echo "Token acquired: $TOKEN"

while [ ! -d /var/lib/rancher ]
do
	# Install tailscale
    curl -fsSL https://tailscale.com/install.sh | sh
	
	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" K3S_URL=https://$SERVER_IP:6443 K3S_TOKEN=$TOKEN INSTALL_K3S_EXEC="--vpn-auth=name=tailscale,joinKey=tailscale,joinKey=$TAILSCALE_AUTH_TOKEN sh -
	sleep 1
done

echo Installation Completed.

