#!/bin/bash
IP=""

while [ -z "$IP" ]
do
	if ifconfig -s | grep tails ; then
		IP=$( ifconfig tailscale0 | awk -F ' *|:' '/inet /{print $3}' | grep .)
	fi
	sleep 2
done

while [ ! -d /var/lib/rancher ]
do

# Is flannel enough ? no need to add calico later on
	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" INSTALL_K3S_EXEC="--cluster-init --flannel-iface tailscale0 --advertise-address $IP --node-ip $IP  --node-external-ip $IP --write-kubeconfig-mode 664" sh -
#	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" INSTALL_K3S_EXEC="--vpn-auth=name=tailscale,joinKey=tailscale,joinKey=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe --flannel-backend=none --cluster-cidr=198.19.16.0/20 --service-cidr=198.19.32.0/20 --write-kubeconfig-mode 664 --disable-network-policy" sh -
#	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" INSTALL_K3S_EXEC="--vpn-auth=name=tailscale,joinKey=tailscale,joinKey=$TAILSCALE_AUTH_TOKEN  --write-kubeconfig-mode 664 --disable-network-policy" sh -

	sleep 1
done


echo Installation Completed.