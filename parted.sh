#!/bin/bash
# Creating five partitions
parted -s /dev/md127 mklabel gpt
parted /dev/md127 mkpart primary ext4 0% 20%
parted /dev/md127 mkpart primary ext4 20% 40%
parted /dev/md127 mkpart primary ext4 40% 60%
parted /dev/md127 mkpart primary ext4 60% 80%
parted /dev/md127 mkpart primary ext4 80% 100%
# Creating mkfs for each new partition
for a in $(seq 1 5); do sudo mkfs.ext4 /dev/md127p$a; done
# Creating catalogs for the partitions
for c in $(seq 1 5); do sudo mkdir -p /catalogs/part$c; done
# Mounting the partitions to the new catalogs
for m in $(seq 1 5); do sudo mount /dev/md127p$m /catalogs/part$m; done
# Adding entries about new mounting to the /etc/fstab
for u in $(seq 1 5); do echo `sudo blkid /dev/md127p$u | cut -d ' ' -f 2` /catalogs/part$u ext4 defaults 0 0 >> /etc/fstab; done
