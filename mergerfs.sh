echo 'mergerfs is being configured'

#copying info FSTAB
grep -q '^#These disks are for' /etc/fstab && sudo sed -i 's/^#These disks are for.*/#These disks are for the MergerFS Pool/' /etc/fstab || echo '#These disks are for the MergerFS Pool' | sudo tee -a /etc/fstab
grep -q '^UUID=$UUIDDISK0' /etc/fstab && sudo sed -i 's/^UUID=$UUIDDISK0.*/UUID=$UUIDDISK0   /mnt/disk0 ext4 defaults 0 0/' /etc/fstab || echo 'UUID=$UUIDDISK0   /mnt/disk0 ext4 defaults 0 0' | sudo tee -a /etc/fstab
grep -q '^UUID=$UUIDDISK1' /etc/fstab && sudo sed -i 's/^UUID=$UUIDDISK1.*/UUID=$UUIDDISK1   /mnt/disk1 ext4 defaults 0 0/' /etc/fstab || echo 'UUID=$UUIDDISK1   /mnt/disk1 ext4 defaults 0 0' | sudo tee -a /etc/fstab
grep -q '^UUID=$UUIDDISK2' /etc/fstab && sudo sed -i 's/^UUID=$UUIDDISK2.*/UUID=$UUIDDISK2   /mnt/disk2 ext4 defaults 0 0/' /etc/fstab || echo 'UUID=$UUIDDISK2   /mnt/disk2 ext4 defaults 0 0' | sudo tee -a /etc/fstab
grep -q '^UUID=$UUIDPARITY' /etc/fstab && sudo sed -i 's/^UUID=$UUIDPARITY.*/UUID=$UUIDPARITY   /mnt/parity ext4 defaults 0 0/' /etc/fstab || echo 'UUID=$UUIDPARITY   /mnt/parity ext4 defaults 0 0' | sudo tee -a /etc/fstab
# mergerfs pool
grep -q '^#This MergerFS mount ' /etc/fstab && sudo sed -i 's/^#This MergerFS mount .*/#This MergerFS mount will be the mount for all the snapraid/mergerfs files/' /etc/fstab || echo '#This MergerFS mount will be the mount for all the snapraid/mergerfs files' | sudo tee -a /etc/fstab
grep -q '^/mnt/disk*' /etc/fstab && sudo sed -i 's/^/mnt/disk*.*//mnt/disk* /srv/storage fuse.mergerfs direct_io,defaults,allow_other,minfreespace=50G,fsname=mergerfs 0 0/' /etc/fstab || echo '/mnt/disk* /srv/storage fuse.mergerfs direct_io,defaults,allow_other,minfreespace=50G,fsname=mergerfs 0 0' | sudo tee -a /etc/fstab
