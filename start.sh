#/bin/bash

curl https://raw.githubusercontent.com/dupontz/homelab/main/mac/control-init.yaml | multipass launch -vvvv -n control 20.04 --memory 3G --cloud-init -
 curl https://raw.githubusercontent.com/dupontz/homelab/main/mac/node1-init.yaml | multipass launch -vvvv -n node1 20.04 --cloud-init - 


 #ref https://blog.dsb.dev/posts/accessing-my-k3s-cluster-from-anywhere-with-tailscale/
 #https://docs.k3s.io/installation/network-options#integration-with-the-tailscale-vpn-provider-experimental