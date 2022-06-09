#!/bin/bash
exec >2&

# Get the UUID of the system drive
fs_uuid=$(findmnt / -o UUID -n) && echo ${fs_uuid}

# temporarily mount the system drive root via the on-demand line in fstab. if doesn't exist, create a temp mountpoint and mount
if sudo grep -Fq "/mnt/drives/system" /etc/fstab; then sudo mount /mnt/drives/system; 
else 
sudo mkdir -p /mnt/drives/system
sudo mount /mnt/drives/system
fi

# Create swap subvolume, then remove temp mountpoint
sudo btrfs subvolume create /mnt/drives/system/@swap
sudo umount /mnt/drives/system

# Temporarily mount the subvolume
sudo mkdir /swap
sudo mount -m -U ${fs_uuid} -o subvol=@swap,nodatacow /swap

# Create the swapfile
sudo touch /swap/swapfile
sudo chattr +C /swap/swapfile
swp_size=$(echo "$(grep "MemTotal" /proc/meminfo | tr -d "[:blank:],[:alpha:],:") * 1.6 / 1000" | bc ) && echo $swp_size
sudo dd if=/dev/zero of=/swap/swapfile bs=1M count=$swp_size status=progress
sudo chmod 0600 /swap/swapfile
sudo mkswap /swap/swapfile
sudo umount /swap

# mount swap automatically at boot
echo -e "UUID=$fs_uuid\t/swap\tbtrfs\tsubvol=@swap,nodatacow,noatime,nospace_cache\t0\t0" | sudo tee -a /etc/fstab
echo -e "/swap/swapfile\tnone\tswap\tdefaults\t0\t0" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo mount /swap
sudo swapon -a
swapon -s

# Configure hibernation
# Get swap device uuid and offset
swp_uuid=$(findmnt -no UUID -T /swap/swapfile) && echo $swp_uuid
cd /tmp
curl -s "https://raw.githubusercontent.com/osandov/osandov-linux/master/scripts/btrfs_map_physical.c" > bmp.c
gcc -O2 -o bmp bmp.c
swp_offset=$(echo "$(sudo ./bmp /swap/swapfile | egrep "^0\s+" | cut -f9) / $(getconf PAGESIZE)" | bc) && echo $swp_offset
# Add these values to grub
echo -e "GRUB_CMDLINE_LINUX_DEFAULT+=\" resume=UUID=$swp_uuid resume_offset=$swp_offset \"" | sudo tee -a /etc/default/grub
# add resume to mkinitcpio
echo -e "HOOKS+=\" resume \"" | sudo tee -a /etc/mkinitcpio.conf
# configure hibernation related systemd services
sudo mkdir -pv /etc/systemd/system/{systemd-logind.service.d,systemd-hibernate.service.d}
echo -e "[Service]\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" | sudo tee /etc/systemd/system/systemd-logind.service.d/override.conf
echo -e "[Service]\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" | sudo tee /etc/systemd/system/systemd-hibernate.service.d/override.conf
# update initcpio and grub
sudo mkinitcpio -P && sudo grub-mkconfig -o /boot/grub/grub.cfg 

# Use the modern way of standby: suspend-then-hibernate
# Contrary to what is written here: 
# follow https://wiki.archlinux.org/title/Power_management#Hybrid-sleep_on_suspend_or_hibernation_request
# follow https://man.archlinux.org/man/sleep.conf.d.5
# These instructions do not work to enable suspend then hibernate, because "suspend-then-hibernate" is not actually a working value in these conf files.
# This workaround does: 
ln -s /usr/lib/systemd/system/systemd-suspend-then-hibernate.service /etc/systemd/system/systemd-suspend.service
# when suspend-then-hibernate is used, go into hibernation (0.0 power consumption) after 120min of suspend unless interrupted
sed -i -e 's@#HibernateDelaySec=180min@HibernateDelaySec=120min@g' /etc/systemd/sleep.conf

# Now define what to do on user initiated actions: go into hibernation when hitting power key
sed -i -e 's@#HandlePowerKey=poweroff@HandlePowerKey=hibernate@g' /etc/systemd/logind.conf
# Use suspend-then-hibernate when lid is closed, even when on external power since you could disconnect from power during suspend
sed -i -e 's@HandleLidSwitch=ignore@HandleLidSwitch=suspend@g' /etc/systemd/logind.conf
sed -i -e 's@#HandleLidSwitchExternalPower=suspend@HandleLidSwitchExternalPower=suspend@g' /etc/systemd/logind.conf

# Gnome specific: 
# Power
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'hibernate'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
gsettings set org.gnome.shell.extensions.arcmenu power-options "[(0, true), (1, true), (2, true), (3, true), (4, true), (5, false), (6, true)]"

echo "Please reboot before using standby or hibernate. Hit a key to continue the post-install script."
