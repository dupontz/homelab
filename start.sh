#/bin/bash

curl https://raw.githubusercontent.com/dupontz/homelab/main/mac/control-init.yaml | multipass launch -vvvv -n control 20.04 --memory 3G --cloud-init -
curl https://raw.githubusercontent.com/dupontz/homelab/main/mac/control-init.yaml | multipass launch -vvvv -n control2 20.04 --memory 2G --cloud-init -


curl https://raw.githubusercontent.com/dupontz/homelab/main/mac/node1-init.yaml | multipass launch -vvvv -n node1 20.04 --memory 8G --disk 30G --cloud-init -

 #ref https://blog.dsb.dev/posts/accessing-my-k3s-cluster-from-anywhere-with-tailscale/
 #https://docs.k3s.io/installation/network-options#integration-with-the-tailscale-vpn-provider-experimental




 sudo tailscale up --authkey=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe --advertise-connector --advertise-tag="tag:connector"



 #TODO
# Allow subnet advertising
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

sudo tailscale up --authkey=tskey-auth-k3i22C5CNTRL-vNKvFZB5nBgVLbZNJgZwBgD2k8a8yAKUe --advertise-routes=10.42.0.0/16,10.43.0.0/16 --snat-subnet-routes=true 

--accept-routes=true  --reset