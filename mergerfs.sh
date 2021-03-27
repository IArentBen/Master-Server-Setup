echo 'test mergerfs'

#copying info FSTAB

UUID=$UUIDDISK0   /mnt/disk0 ext4 defaults 0 0
UUID=$UUIDDISK1   /mnt/disk1 ext4 defaults 0 0
UUID=$UUIDDISK2   /mnt/disk2 ext4 defaults 0 0
UUID=$UUIDPARITY  /mnt/parity ext4 defaults 0 0
 
# mergerfs pool
/mnt/disk* /srv/storage fuse.mergerfs direct_io,defaults,allow_other,minfreespace=50G,fsname=mergerfs 0 0