#/bin/bash

curl https://raw.githubusercontent.com/dupontz/homelab/main/mac/control-init.yaml | multipass launch -vvvv -n control 20.04 --memory 3G --cloud-init -