#!/bin/bash
exec >2&

# Calculate required swap size
ram=$(grep "MemTotal" /proc/meminfo | tr -d " " | sed -r "s/(\w+):([0-9]+)(\w+)/\\2/g") 
size=$(printf "%.0f\n" $(echo "$ram * 1.5 / 1000" | bc ))

# Configure swapfile on btrfs nested subvolume to maintain TimeShift compatibility
# Disable current swap, remove its entries from fstab, mount fstab, remove swap folder and file
swapoff /swap/swapfile
sed -i"-backup" '/swap/d' /etc/fstab
mount -a
rm -rf /swap/swapfile
rm -rf /swap
# Configure swap for BTRFS with hibernate support
btrfs subvolume create /@swap
touch /@swap/swapfile
truncate -s 0 /@swap/swapfile
chattr +C /@swap/swapfile
btrfs property set /@swap/swapfile compression none
dd if=/dev/zero of=/@swap/swapfile bs=1M count=$size status=progress
chmod 0600 /@swap/swapfile
mkswap /@swap/swapfile
echo -e '# Swapfile for hibernation support, on nested subvolume\n/@swap/swapfile\tnone\tswap\tsw\t0\t0' >> /etc/fstab
[[ -z $(swapon -s | grep "/@swap/swapfile") ]] && swapon /@swap/swapfile

# Enable Hibernation
offset=$(filefrag -v /@swap/swapfile | awk '{ if($1=="0:"){print substr($4, 1, length($4)-2)} }')
uuid=$(findmnt -no UUID -T /@swap/swapfile)
mkdir -p /etc/default/grub.d/

if [[ -z $(grep "source /etc/default/grub.d/*" /etc/default/grub) ]]
	then
		echo -e "\n\nsource /etc/default/grub.d/*" >> /etc/default/grub  
fi
echo -e "# Added by a script\nGRUB_CMDLINE_LINUX_DEFAULT=\"\$GRUB_CMDLINE_LINUX_DEFAULT resume=UUID=$uuid resume_offset=$offset\"" > /etc/default/grub.d/resume.cfg

if [[ -z $(grep "resume" /etc/mkinitcpio.conf) ]]
	then
		sed -i "s/filesystems/filesystems resume/g" /etc/mkinitcpio.conf 
fi

# Due no support for btrfs we need to bypass the memory check
mkdir -p /etc/systemd/system/systemd-logind.service.d/		
mkdir -p /etc/systemd/system/systemd-hibernate.service.d/		
logind="/etc/systemd/system/systemd-logind.service.d/bypass_hibernation_memory_check.conf"
hibernate="/etc/systemd/system/systemd-hibernate.service.d/bypass_hibernation_memory_check.conf"

if [[ ! -f $logind ]]
	then
		echo -e "#Added by a script\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" \
		>  /etc/systemd/system/systemd-logind.service.d/bypass_hibernation_memory_check.conf
fi

if [[ ! -f $hibernate ]]
	then
		echo -e "#Added by a script\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" \
		> /etc/systemd/system/systemd-hibernate.service.d/bypass_hibernation_memory_check.conf
fi
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P

# GOAL: system should always use Hybrid Sleep when it automatically suspends and Suspend-Then-Hibernate
#
# follow https://wiki.archlinux.org/title/Power_management#Hybrid-sleep_on_suspend_or_hibernation_request
# follow https://man.archlinux.org/man/sleep.conf.d.5
# 
# Disable regular suspend, we only allow Hybrid Sleep, to prevent data loss when battery dies
#sed -i -e 's@#AllowSuspend=yes@AllowSuspend=no@g' /etc/systemd/sleep.conf
# Disabling suspend implies disabling suspend-then-hibernate and hybrid-sleep, override to allow both again
#sed -i -e 's@#AllowHybridSleep=yes@AllowHybridSleep=yes@g' /etc/systemd/sleep.conf
#sed -i -e 's@#AllowSuspendThenHibernate=yes@AllowSuspendThenHibernate=yes@g' /etc/systemd/sleep.conf
# Define the method of suspend to be Hybrid Sleep, this is also used by suspend-then-hibernate to determine how to suspend.
#sed -i -e 's@#SuspendMode=@SuspendMode=suspend@g' /etc/systemd/sleep.conf
#sed -i -e 's@#SuspendState=mem standby freeze@SuspendState=disk@g' /etc/systemd/sleep.conf
# when suspend-then-hibernate is used, go into hibernation (0.0 power consumption) after 60min of suspend unless interrupted
sed -i -e 's@#HibernateDelaySec=180min@HibernateDelaySec=60min@g' /etc/systemd/sleep.conf

# Now define what to do on user initiated actions: go into hibernation when hitting power key
#sed -i -e 's@#HandlePowerKey=poweroff@HandlePowerKey=hibernate@g' /etc/systemd/logind.conf
# Use suspend-then-hibernate when lid is closed, even when on external power since you could disconnect from power during suspend
#sed -i -e 's@HandleLidSwitch=ignore@HandleLidSwitch=suspend-then-hibernate@g' /etc/systemd/logind.conf
#sed -i -e 's@#HandleLidSwitchExternalPower=suspend@HandleLidSwitchExternalPower=suspend-then-hibernate@g' /etc/systemd/logind.conf
