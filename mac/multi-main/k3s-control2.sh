#!/bin/bash
IP=""
TOKEN=""

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


while [ ! -d /var/lib/rancher ]
do

# Is flannel enough ? no need to add calico later on
	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" K3S_TOKEN=$TOKEN INSTALL_K3S_EXEC="--server https://control.tail58b34.ts.net:6443 --flannel-iface tailscale0 --advertise-address $IP --node-ip $IP  --node-external-ip $IP --write-kubeconfig-mode 664" sh -

	sleep 1
done

echo Installation Completed.