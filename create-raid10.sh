#!/bin/bash
yum install -y bash-completion
yum install -y mdadm
mdadm --create --verbose /dev/md/raid10-example --level=10 --raid-devices=4 /dev/nvme0n1 /dev/nvme0n2 /dev/nvme0n3 /dev/nvme0n4
mdadm --add /dev/md/raid10-example /dev/nvme0n9
mdadm /dev/md/raid10-example --fail /dev/nvme0n3
#sleep 5
mdadm --remove /dev/md/raid10-example /dev/nvme0n3
mdadm --add /dev/md/raid10-example /dev/nvme0n3
