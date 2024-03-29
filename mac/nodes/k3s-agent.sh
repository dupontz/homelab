#!/bin/bash

TOKEN=""
TAILSCALE_AUTH_TOKEN=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe
IP=""

while [ -z "$IP" ]
do
	if ifconfig -s | grep tails ; then
		IP=$( ifconfig tailscale0 | awk -F ' *|:' '/inet /{print $3}' | grep .)
	fi
	sleep 2
done


while [ -z "$TOKEN" ]
do
	sleep 1
	TOKEN=$(echo sudo cat /var/lib/rancher/k3s/server/node-token | ssh -i /home/ubuntu/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@control.tail58b34.ts.net | grep '::server:')
	SERVER_IP=$( ssh -i /home/ubuntu/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@control.tail58b34.ts.net ifconfig tailscale0 | awk -F ' *|:' '/inet /{print $3}' | grep .)
done

echo "Token acquired: $TOKEN"
echo "Server ip: $SERVER_IP"

while [ ! -d /var/lib/rancher ]
do
	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" K3S_URL=https://$SERVER_IP:6443 K3S_TOKEN=$TOKEN INSTALL_K3S_EXEC="--flannel-iface tailscale0 --node-ip $IP --node-external-ip $IP" sh -
	sleep 1
done

echo Installation Completed.

