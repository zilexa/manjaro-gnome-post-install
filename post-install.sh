#!/bin/bash
#
# Might need this for pacman automation: yes | LC_ALL=en_US.UTF-8 pacman
# Find and select the fastest mirror to install apps from
echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "              Configure updates (every 6hrs > weekly), enable AUR                  "
echo "                     Test and rank mirrors, select fastest                         "
echo "___________________________________________________________________________________"
# Weekly updates instead of 4x a day. No tray icon if there are no updates. Download in background. Enable AUR (Arch User Repository). 
sudo sed -i -e 's@RefreshPeriod = 6@RefreshPeriod = 168@g' /etc/pamac.conf
sudo sed -Ei '/NoUpdateHideIcon/s/^#//' /etc/pamac.conf
sudo sed -Ei '/DownloadUpdates/s/^#//' /etc/pamac.conf
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf
sudo sed -Ei '/CheckAURUpdates/s/^#//' /etc/pamac.conf
# Mirrors
sudo pacman-mirrors -g --continent -P https --api && sudo pacman -Syyu


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "              Replace filemanager (Nautilus) with more intuitive Nemo              "
echo "___________________________________________________________________________________"
# Change default filemanager Nautilus for Nemo 
sudo sed -i -e 's@org.gnome.Nautilus.desktop@nemo.desktop@g' /usr/share/applications/mimeinfo.cache
sudo pacman -S --noconfirm nemo
# Configure Nemo to make it a bit more intuitive
gsettings set org.nemo.preferences quick-renames-with-pause-in-between true
gsettings set org.nemo.preferences date-format 'iso'
gsettings set org.nemo.preferences show-reload-icon-toolbar true
gsettings set org.nemo.preferences default-folder-viewer 'list-view'
gsettings set org.nemo.preferences inherit-folder-viewer true
## also when opening folders as with elevated privileges (root user)
sudo -u root dbus-launch gsettings set org.nemo.preferences quick-renames-with-pause-in-between true
sudo -u root dbus-launch gsettings set org.nemo.preferences date-format 'iso'
sudo -u root dbus-launch gsettings set org.nemo.preferences show-reload-icon-toolbar true
sudo -u root dbus-launch gsettings set org.nemo.preferences default-folder-viewer 'list-view'
sudo -u root dbus-launch gsettings set org.nemo.preferences inherit-folder-viewer true
#[Default Applications]
#inode/directory=nemo.desktop;
#text/plain=pluma.desktop;

echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "               Replace Text Editor (gedit) with more intuitive Pluma               "
echo "___________________________________________________________________________________"
# Change default texteditor Gedit to Pluma, keep the Text Editor name and icon
# Backup the Text Editor shortcut (contains name and the preferred icon)
#sudo cp '/usr/share/applications/org.gnome.gedit.desktop' '/usr/share/applications/TextEditor.backup'
# Change default app for text files 
# Remove default texteditor, install Pluma
sudo pacman -R --noconfirm gedit
sudo pacman -S --noconfirm pluma
# Configure the backupped Text Editor to work with Pluma, keeping the name and logo
sudo cp '/usr/share/applications/pluma.desktop' '/usr/share/applications/pluma.backup'
sudo sed -i -e 's@pluma@Text Editor@g' '/usr/share/applications/pluma.desktop'
sudo sed -i -e 's@Icon=org.gnome.pluma@Icon=org.gnome.gedit@g' '/usr/share/applications/pluma.desktop'
#sudo mv '/usr/share/applications/TextEditor.backup' '/usr/share/applications/TextEditor.desktop'
#sudo sed -i -e 's@org.gnome.gedit.desktop@TextEditor.desktop@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@org.gnome.gedit.desktop@Text Editor.desktop@g' $HOME/.config/mimeapps.list
#sudo sed -i -e 's@text/plain=TextEditor.desktop@text/plain=TextEditor.desktop@g' $HOME/.config/mimeapps.list

#Configuration of Pluma
gsettings set org.mate.pluma highlight-current-line true
gsettings set org.mate.pluma bracket-matching true
gsettings set org.mate.pluma display-line-numbers true
gsettings set org.mate.pluma display-overview-map true
gsettings set org.mate.pluma auto-indent true
gsettings set org.mate.pluma active-plugins "['time', 'spell', 'sort', 'snippets', 'modelines', 'filebrowser', 'docinfo']"
## also when opening files as with elevated privileges (root user)
sudo -u root dbus-launch gsettings set org.mate.pluma highlight-current-line true
sudo -u root dbus-launch gsettings set org.mate.pluma bracket-matching true
sudo -u root dbus-launch gsettings set org.mate.pluma display-line-numbers true
sudo -u root dbus-launch gsettings set org.mate.pluma display-overview-map true
sudo -u root dbus-launch gsettings set org.mate.pluma auto-indent true
sudo -u root dbus-launch gsettings set org.mate.pluma active-plugins "['time', 'spell', 'sort', 'snippets', 'modelines', 'filebrowser', 'docinfo']"


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "     Configure panel (taskbar), App menu (Arcmenu) and common system settings      "
echo "___________________________________________________________________________________"
# Arc Menu & Dash to Panel
gsettings set org.gnome.shell.extensions.arcmenu arc-menu-placement 'DTP'
gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Eleven'
gsettings set org.gnome.shell disabled-extensions "['material-shell@papyelgringo', 'vertical-overview@RensAlthuis.github.com', 'dash-to-dock@micxgx.gmail.com', 'unite@hardpixel.eu']"
gsettings set org.gnome.shell enabled-extensions "['pamac-updates@manjaro.org', 'gnome-ui-tune@itstime.tech', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-panel@jderose9.github.com', 'arcmenu@arcmenu.com']"
gsettings set org.gnome.shell.extensions.arcmenu available-placement "[false, true, false]"
gsettings set org.gnome.shell.extensions.dash-to-panel panel-positions '{"0":"LEFT"}'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.shell.extensions.arcmenu reload-theme true
# Arc Menu Hot corner (top left) 
gsettings set org.gnome.shell.extensions.arcmenu override-hot-corners true
gsettings set org.gnome.shell.extensions.arcmenu custom-hot-corner-cmd "sh -c 'notify-send \"$(date)\"'"
gsettings set org.gnome.shell.extensions.arcmenu hot-corners 'ToggleArcMenu'
# Dash to Panel
gsettings set org.gnome.shell.extensions.dash-to-panel animate-appicon-hover true
gsettings set org.gnome.shell.extensions.dash-to-panel animate-appicon-hover-animation-extent "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}"
gsettings set org.gnome.shell.extensions.dash-to-panel animate-appicon-hover-animation-zoom "{'SIMPLE': 1.2, 'RIPPLE': 1.25, 'PLANK': 2.0}"
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-margin 8
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-padding 4
gsettings set org.gnome.shell.extensions.dash-to-panel available-monitors "[0]"
gsettings set org.gnome.shell.extensions.dash-to-panel dot-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-panel dot-style-focused 'METRO'
gsettings set org.gnome.shell.extensions.dash-to-panel dot-style-unfocused 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-panel hide-overview-on-startup true
gsettings set org.gnome.shell.extensions.dash-to-panel hotkeys-overlay-combo 'TEMPORARILY'
gsettings set org.gnome.shell.extensions.dash-to-panel intellihide false
gsettings set org.gnome.shell.extensions.dash-to-panel intellihide-animation-time 250
gsettings set org.gnome.shell.extensions.dash-to-panel intellihide-close-delay 800
gsettings set org.gnome.shell.extensions.dash-to-panel intellihide-hide-from-windows true
gsettings set org.gnome.shell.extensions.dash-to-panel intellihide-use-pressure true
gsettings set org.gnome.shell.extensions.dash-to-panel isolate-workspaces true
gsettings set org.gnome.shell.extensions.dash-to-panel leftbox-padding -1
gsettings set org.gnome.shell.extensions.dash-to-panel overview-click-to-exit true
gsettings set org.gnome.shell.extensions.dash-to-panel panel-anchors '{"0":"MIDDLE"}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-element-positions '{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-lengths '{"0":100}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-positions '{"0":"LEFT"}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 48
gsettings set org.gnome.shell.extensions.dash-to-panel panel-sizes '{"0":48}'
gsettings set org.gnome.shell.extensions.dash-to-panel secondarymenu-contains-showdetails false
gsettings set org.gnome.shell.extensions.dash-to-panel show-running-apps true
gsettings set org.gnome.shell.extensions.dash-to-panel status-icon-padding -1
gsettings set org.gnome.shell.extensions.dash-to-panel trans-bg-color '#241f31'
gsettings set org.gnome.shell.extensions.dash-to-panel trans-dynamic-anim-target 0.95000000000000007
gsettings set org.gnome.shell.extensions.dash-to-panel trans-dynamic-anim-time 300
gsettings set org.gnome.shell.extensions.dash-to-panel trans-gradient-bottom-color '#5e5c64'
gsettings set org.gnome.shell.extensions.dash-to-panel trans-gradient-bottom-opacity 0.050000000000000003
gsettings set org.gnome.shell.extensions.dash-to-panel trans-gradient-top-color '#000000'
gsettings set org.gnome.shell.extensions.dash-to-panel trans-gradient-top-opacity 0.80000000000000004
gsettings set org.gnome.shell.extensions.dash-to-panel trans-panel-opacity 0.75
gsettings set org.gnome.shell.extensions.dash-to-panel trans-use-custom-bg true
gsettings set org.gnome.shell.extensions.dash-to-panel trans-use-custom-gradient true
gsettings set org.gnome.shell.extensions.dash-to-panel trans-use-custom-opacity true
gsettings set org.gnome.shell.extensions.dash-to-panel trans-use-dynamic-opacity true
gsettings set org.gnome.shell.extensions.dash-to-panel tray-padding -1
gsettings set org.gnome.shell.extensions.dash-to-panel window-preview-title-position 'TOP'
# Desktop
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding start-corner 'bottom-left'
# Theme
gsettings set org.gnome.desktop.interface gtk-theme 'Matcha-dark-azul'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
# Display
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 22.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 8.75
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/wallpapers-2018/palm-beach.jpg'
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 'uint32 480'
# Power
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'hibernate'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
# cleanup
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
# Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
# Locale
gsettings set org.gnome.system.location enabled true
gsettings set org.gnome.desktop.datetime automatic-timezone true


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                          Simplify $HOME personal folders                          "
echo "___________________________________________________________________________________"
# Change default location of personal folders by editing $HOME/.config/user-dirs.dirs
## Move /Templates to be subfolder of /Documents. 
sudo sed -i -e 's+$HOME/Templates+$HOME/Documents/Templates+g' $HOME/.config/user-dirs.dirs
## Disable Public folder because nobody uses it. 
sudo sed -i -e 's+$HOME/Public+$HOME/Downloads+g' $HOME/.config/user-dirs.dirs
## Rename Pictures to Photos
sudo sed -i -e 's+$HOME/Pictures+$HOME/Photos+g' $HOME/.config/user-dirs.dirs
## Rename Videos to Media making it the folder for tvshows/movies downloads or anything else that is not suppose to be in Photos. 
sudo sed -i -e 's+$HOME/Videos+$HOME/Media+g' $HOME/.config/user-dirs.dirs

# Now make the changes to the actual folders: 
## Remove unused Pubic folder
rmdir $HOME/Public
## Move Templates folder into Documents because it does not make sense to be outside it. 
mv $HOME/Templates $HOME/Documents/
## Rename and move contents from Pictures to Photos, Videos to Media.
mv /home/${USER}/Videos /home/${USER}/Media
mv /home/${USER}/Pictures /home/${USER}/Photos
org.nemo.window-state sidebar-bookmark-breakpoint 4
org.nemo.window-state sidebar-bookmark-breakpoint 3



echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "         Install must-have applications for various common tasks                   "
echo "___________________________________________________________________________________"
#Install system cleanup tool
sudo pacman -S --noconfirm bleachbit

#Install handy desktop tools
sudo pacman -S --noconfirm variety

# Install a musicplayer that supports folder view library
sudo pacman -S --noconfirm strawberry

#Install Audacity audio editor and recorder
sudo pacman -S --noconfirm audacity

#Install simple video editor (cut/trim videos)
#sudo pacman -S losslesscut

#Install handbrake to convert videos
sudo pacman -S --noconfirm handbrake

#Install Darktable photo editor (like Adobe Photoshop)
sudo pacman -S --noconfirm darktable

#Install simple image editor (like Paint)
sudo pacman -S --noconfirm pinta

#Install photo library management
sudo pacman -S --noconfirm digikam

# Pin common apps to Arc Menu
gsettings get org.gnome.shell.extensions.arcmenu pinned-app-list "['Add/Remove Software', '', 'org.manjaro.pamac.manager.desktop', 'Strawberry', '', 'org.strawberrymusicplayer.strawberry.desktop', 'Audacity', '', 'audacity.desktop', 'Document Scanner', '', 'simple-scan.desktop', 'Settings', '', 'gnome-control-center.desktop', 'Manjaro Settings Manager', '', 'manjaro-settings-manager.desktop', 'gThumb Image Viewer', '', 'org.gnome.gThumb.desktop', 'digiKam', '', 'org.kde.digikam.desktop', 'Darktable Photo Workflow Software', '', 'darktable.desktop', 'Pinta Image Editor', '', 'pinta.desktop', 'HandBrake', '', 'fr.handbrake.ghb.desktop', 'LosslessCut', '', 'losslesscut-bin.desktop']"
# Add most used apps to Panel (favourites)
gsettings get org.gnome.shell favorite-apps "['nemo.desktop', 'firefox.desktop', 'org.gnome.gThumb.desktop', 'org.onlyoffice.desktopeditors.desktop', 'pluma.desktop', 'org.gnome.Calculator.desktop']"


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                            Firefox default settings                               "
echo "         (Applied for for all Firefox profiles created in the future.)             "
echo "___________________________________________________________________________________"
echo "      Create a default profile setting to enable syncing of your toolbar layout    " 
echo "___________________________________________________________________________________"
sudo tee -a /usr/lib/firefox/defaults/pref/autoconfig.js &>/dev/null << EOF
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF
sudo tee -a /usr/lib/firefox/firefox.cfg &>/dev/null << EOF
// IMPORTANT: Start your code on the 2nd line
defaultPref("services.sync.prefs.sync.browser.uiCustomization.state",true);
EOF


echo "_________________________________________________________________________"
echo "                         OPTIONAL APPLICATIONS                           "
echo "_________________________________________________________________________"
# Use your custom Firefox Sync Server by default
echo "---------------------------------------"
read -p "Would you like to use your own Firefox Sync Server? (y/n)" answer
case ${answer:0:1} in
    y|Y )
    echo "Please type your Firefox Sync domain address, for example: firefox.mydomain.com"
    read -p 'Firefox Sync domain address: ' ffsyncdomain
    sudo tee -a /usr/lib/firefox/firefox.cfg &>/dev/null << EOF
defaultPref("identity.sync.tokenserver.uri","https://$ffsyncdomain/token/1.0/sync/1.5");
EOF
    echo "Done. New firefox profile will use your Firefox sync server by default."
    ;;
    * )
        echo "default Mozilla public sync server is used."
    ;;
esac


# Install ALL Win10/Office365 fonts
echo "---------------------------------------"
echo "Install all MS Office365 fonts, for full compatibility with MS Office files?"
echo "Only choose 'y' if you believe you have the license and approval of MS to download all their fonts." 
read -p "Your browser will open and you need to download the fonts package. Continue? (Y/n)" answer
case ${answer:0:1} in
    y|Y )
       xdg-open 'https://mega.nz/file/u4p02JCC#HnJOVyK8TYDqEyVXLkwghDLKlKfIq0kOlX6SPxH53u0'
       read -p "Click any key when the download has finished AND you saved the file to your Downloads..."
       echo "please wait while extracting fonts to the system fonts folder (/usr/share/fonts), the downloaded file will be deleted afterwards." 
       # Extract the manually downloaded file to a subfolder in the systems font folder
       sudo tar -xvf $HOME/Downloads/fonts-office365.tar.xz -C /usr/share/fonts
       # Set permissions to allow non-root to use the fonts
       sudo chown -R root:root /usr/share/fonts/office365
       sudo chmod -R 755 /usr/share/fonts/office365
       # Refresh the font cache (= register the fonts)
       sudo fc-cache -f -v
       # Remove the downloaded font file
       rm $HOME/Downloads/fonts-office365.tar.xz
    ;;
    * )
        echo "Not installing all win10/office365 fonts..."
    ;;
esac


# Install Nextcloud Desktop Client for webDAV syncing with FileRun 
echo "---------------------------------------"
read -p "Install Nextcloud Desktop Client for Nemo/Budgie? Recommended if you run a FileRun or WebDAV server (y / n)?" answer
case ${answer:0:1} in
    y|Y )
        sudo pacman -S --noconfirm nextcloud-client
    ;;
    * )
        echo "Skipping Nextcloud Desktop Client..."
    ;;
esac

# Install Spotify
echo "---------------------------------------"
read -p "Install Spotify (y/n)?" answer
case ${answer:0:1} in
    y|Y )
        sudo pacman -S --noconfirm spotifyd
    ;;
    * )
        echo "Skipping Spotify..." 
    ;;
esac


echo "_________________________________________________________________________"
echo "                         ISOLATE PERSONAL FOLDERS                        "
echo "_________________________________________________________________________"
# OPTIONAL: IF THIS IS A COMMON PC OR LAPTOP, CREATE A SUBVOLUME FOR USER DATA.  
echo "---------------------------------------"
echo "Hit y if this a regular, personal device, laptop/desktop pc ( y /n )?"
echo "YES = Personal folders will be isolated by via a seperate subvolume (and linked back to $HOME folder)."
echo "      Benefits: 1. allows you to easily configure backups and 'back-in-time' snapshots."
echo "                2. Isolates personal folders, allows cean system re-install without deleting personal data." 
echo "NO = nothing will be changed."
read -p "Isolate personal data y/n ?" answer
case ${answer:0:1} in
    y|Y )
# Temporarily mount filesystem root
sudo mkdir /mnt/system
sudo mount -o subvolid=5 /dev/nvme0n1p2 /mnt/system
# create a root subvolume for user personal folders in the root filesystem
sudo btrfs subvolume create /mnt/system/@userdata
## unmount root filesystem
sudo umount /mnt/system
# Get system fs UUID
fs_uuid=$(findmnt / -o UUID -n)
# Add @userdata subvolume to fstab to mount at boot
sudo tee -a /etc/fstab &>/dev/null << EOF
# Mount the BTRFS root subvolume @userdata
UUID=${fs_uuid} /mnt/userdata  btrfs   defaults,noatime,subvol=@userdata,compress-force=zstd:2  0  0
EOF

## Temporarily mount @userdata subvolume to move existing personal folders and link them back to $HOME
sudo mkdir /mnt/userdata
sudo mount -o subvol=@userdata /dev/nvme0n1p2 /mnt/userdata
## Move personal user folders to the subvolume
sudo mv /home/${USER}/Documents /mnt/userdata/
sudo mv /home/${USER}/Desktop /mnt/userdata/
sudo mv /home/${USER}/Downloads /mnt/userdata/
sudo mv /home/${USER}/Media /mnt/userdata/
sudo mv /home/${USER}/Music /mnt/userdata/
sudo mv /home/${USER}/Photos /mnt/userdata/
## Link personal folders inside subvolume back into home subvolume
ln -s /mnt/userdata/Documents $HOME/Documents
ln -s /mnt/userdata/Desktop $HOME/Desktop
ln -s /mnt/userdata/Downloads $HOME/Downloads
ln -s /mnt/userdata/Media $HOME/Media
ln -s /mnt/userdata/Music $HOME/Music
ln -s /mnt/userdata/Photos $HOME/Photos
#Current Downloads folder has been moved, enter the moved Downloads folder 
cd /
cd $HOME
cd $HOME/Downloads
    ;;
    * )
        echo "Not creating userdata, this is not a common personal device." 
    ;;
esac

echo "_________________________________________________________________________"
echo "               Configure BTRFS swap and enable hibernation               "
echo "_________________________________________________________________________"
echo "Highly recommended if this is a laptop. It will allow hybrid sleep and hibernation."
echo "Select 'n' if this is your server: You don't need hibernate but zswap instead."
read -p "Configure swapfile for BTRFS and enable hibernation y/n ?" answer
case ${answer:0:1} in
    y|Y )
# Calculate required swap size
ram=$(grep "MemTotal" /proc/meminfo | tr -d " " | sed -r "s/(\w+):([0-9]+)(\w+)/\\2/g") 
size=$(printf "%.0f\n" $(echo "$ram * 1.5 / 1000" | bc ))

# Configure swapfile on btrfs nested subvolume to maintain TimeShift compatibility
sudo btrfs subvolume create /@swap
sudo touch /@swap/swapfile
sudo truncate -s 0 /@swap/swapfile
sudo chattr +C /@swap/swapfile
sudo btrfs property set /@swap/swapfile compression none
sudo dd if=/dev/zero of=/@swap/swapfile bs=1M count=$size status=progress
sudo chmod 0600 /@swap/swapfile
sudo mkswap /@swap/swapfile
sudo echo "# Created by a script\n/swapfile\tnone\tswap\tsw\t0\t0" >> /etc/fstab
[[ -z $(swapon -s | grep "/@swap/swapfile") ]] && swapon /@swap/swapfile

# Enable Hibernation
pamac install pm-utils
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

sudo sed -i -e 's@#HibernateDelaySec=180min@HibernateDelaySec=60min@g' /etc/systemd/sleep.conf
    ;;
    * )
        echo "Not configuring BTRFS swapfile and hibernation. It is recommended you configure zswap." 
    ;;
esac
