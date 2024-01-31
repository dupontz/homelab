#!/bin/bash

while [ ! -d /var/lib/rancher ]
do  

TAILSCALE_AUTH_TOKEN=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe
# Install tailscale
    curl -fsSL https://tailscale.com/install.sh | sh

# Is flannel enough ? no need to add calico later on
	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" INSTALL_K3S_EXEC="--vpn-auth=name=tailscale,joinKey=tailscale,joinKey=$TAILSCALE_AUTH_TOKEN  --write-kubeconfig-mode 664 --disable-network-policy" sh -
#	curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.25.15+k3s2" INSTALL_K3S_EXEC="--vpn-auth=name=tailscale,joinKey=tailscale,joinKey=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe --flannel-backend=none --cluster-cidr=198.19.16.0/20 --service-cidr=198.19.32.0/20 --write-kubeconfig-mode 664 --disable-network-policy" sh -
	sleep 1
done

echo Installation Completed.
