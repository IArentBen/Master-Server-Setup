echo 'mergerfs is being configured'
#Create copy of sasl_passwd in current directory and in defaults directory
sudo cp --archive /etc/fstab /etc/fstab-COPY-$(date +"%Y%m%d%H%M%S")
sudo cp --archive /etc/fstab /home/$USER/bin/defaults/fstab-COPY-$(date +"%Y%m%d%H%M%S")
#copying info FSTAB
grep -q "#These disks" /etc/fstab && sudo sed -i 's/"#These disks.*/#These disks are for the MergerFS Pool"/' /etc/fstab || echo "#These disks are for the MergerFS Pool" | sudo tee -a /etc/fstab
grep -q "UUID=$UUIDDISK3" /etc/fstab && sudo sed -i 's/"UUID=$UUIDDISK3.*/UUID=$UUIDDISK3   /mnt/disk3 ext4 defaults 0 0"/' /etc/fstab || echo "UUID=$UUIDDISK3   /mnt/disk3 ext4 defaults 0 0" | sudo tee -a /etc/fstab
grep -q "UUID=$UUIDDISK1" /etc/fstab && sudo sed -i 's/"UUID=$UUIDDISK1.*/UUID=$UUIDDISK1   /mnt/disk1 ext4 defaults 0 0"/' /etc/fstab || echo "UUID=$UUIDDISK1   /mnt/disk1 ext4 defaults 0 0" | sudo tee -a /etc/fstab
grep -q "UUID=$UUIDDISK2" /etc/fstab && sudo sed -i 's/"UUID=$UUIDDISK2.*/UUID=$UUIDDISK2   /mnt/disk2 ext4 defaults 0 0"/' /etc/fstab || echo "UUID=$UUIDDISK2   /mnt/disk2 ext4 defaults 0 0" | sudo tee -a /etc/fstab
grep -q "UUID=$UUIDPARITY1" /etc/fstab && sudo sed -i 's/"UUID=$UUIDPARITY1.*/UUID=$UUIDPARITY1   /mnt/parity1 ext4 defaults 0 0"/' /etc/fstab || echo "UUID=$UUIDPARITY1   /mnt/parity1 ext4 defaults 0 0" | sudo tee -a /etc/fstab
#mergerfs in fstab
grep -q "#This MergerFS" /etc/fstab && sudo sed -i 's/"#This MergerFS.*/#This MergerFS mount will be the mount for all the snapraid/mergerfs files"/' /etc/fstab || echo "#This MergerFS mount will be the mount for all the snapraid/mergerfs files" | sudo tee -a /etc/fstab
grep -q "/mnt/disk*" /etc/fstab && sudo sed -i 's/"/mnt/disk*.*//mnt/disk*      $storagepath  fuse.mergerfs   defaults,allow_other,use_ino,fsname=mergerFS,x-systemd.requires=/mnt/disk1,x-systemd.requires=/mnt/disk2,x-systemd.requires=/mnt/disk3 0 0"/' /etc/fstab || echo "/mnt/disk*      $storagepath  fuse.mergerfs   defaults,allow_other,use_ino,fsname=mergerFS,x-systemd.requires=/mnt/disk1,x-systemd.requires=/mnt/disk2,x-systemd.requires=/mnt/disk3 0 0" | sudo tee -a /etc/fstab
