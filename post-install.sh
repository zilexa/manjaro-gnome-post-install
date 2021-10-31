# Might need this for pacman automation: yes | LC_ALL=en_US.UTF-8 pacman

# Find and select the fastest mirror to install apps from
sudo pacman-mirrors -g -P https --api && sudo pacman -Syyu

# Arc Menu & Dash to Panel
gsettings set org.gnome.shell.extensions.arcmenu.arc-menu-placement 'DTP'
gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Eleven'
gsettings set org.gnome.shell.disabled-extensions "['material-shell@papyelgringo', 'vertical-overview@RensAlthuis.github.com', 'dash-to-dock@micxgx.gmail.com', 'unite@hardpixel.eu']"
gsettings set org.gnome.shell.enabled-extensions "['pamac-updates@manjaro.org', 'gnome-ui-tune@itstime.tech', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-panel@jderose9.github.com', 'arcmenu@arcmenu.com']"
gsettings set org.gnome.shell.extensions.arcmenu available-placement "[false, true, false]"
gsettings set org.gnome.shell.extensions.dash-to-panel panel-positions '{"0":"LEFT"}'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.shell.extensions.arcmenu reload-theme true
gsettings set org.gnome.shell.extensions.arcmenu reload-theme unset

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

#ARCMENU Hot corner (top left) 
gsettings set org.gnome.shell.extensions.arcmenu override-hot-corners true
gsettings set org.gnome.shell.extensions.arcmenu custom-hot-corner-cmd "sh -c 'notify-send \"$(date)\"'"
gsettings set org.gnome.shell.extensions.arcmenu hot-corners 'ToggleArcMenu'

# Display
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 22.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 8.75
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/wallpapers-2018/palm-beach.jpg'
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay uint32 480

# cleanup
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true

# Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# Locale
gsettings set system.locale region 'nl_NL.UTF-8'
gsettings set org.gnome.system.location enabled true
gsettings set org.gnome.desktop.datetime automatic-timezone true

# Change default texteditor Gedit to Pluma, keep the Text Editor name and icon
# Backup the Text Editor shortcut
sudo cp '/usr/share/applications/Text Editor.desktop' '/usr/share/applications/TextEditor.backup'
# Change default app for text files 
#sudo sed -i -e 's@org.gnome.gedit.desktop@pluma.desktop@g' /usr/share/applications/mimeinfo.cache
# Remove default texteditor, install Pluma
sudo pacman -R --noconfirm gedit
sudo pacman -S --noconfirm pluma
# Configure the backupped Text Editor to work with Pluma, keeping the name and logo
sudo mv '/usr/share/applications/pluma.desktop' '/usr/share/applications/pluma.backup'
sudo sed -i -e 's@gedit@pluma@g' '/usr/share/applications/TextEditor.backup'
sudo sed -i -e 's@Icon=org.gnome.pluma@Icon=org.gnome.gedit@g' '/usr/share/applications/TextEditor.backup'
sudo mv '/usr/share/applications/TextEditor.backup' '/usr/share/applications/TextEditor.desktop'
sudo sed -i -e 's@org.gnome.gedit.desktop@TextEditor.desktop@g' $HOME/.config/mimeapps.list 

# Change default filemanager Nautilus for Nemo 
sudo sed -i -e 's@org.gnome.Nautilus.desktop@nemo.desktop@g' /usr/share/applications/mimeinfo.cache
sudo pacman -S --noconfirm nemo
# Configure Nemo to make it a bit more intuitive
gsettings set .org.nemo.preferences quick-renames-with-pause-in-between true
gsettings set .org.nemo.preferences date-format iso
gsettings set .org.nemo.preferences show-reload-icon-toolbar true
gsettings set .org.nemo.preferences default-folder-viewer 'list-view'
gsettings set .org.nemo.preferences inherit-folder-viewer true
#[Default Applications]
#inode/directory=nemo.desktop;
#text/plain=pluma.desktop;

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

echo "___________________________________________________________________________________"
echo "Firefox: Create a default profile setting to enable syncing of your toolbar layout " 
echo "         (Applied for for all Firefox profiles created in the future.)             "
echo "___________________________________________________________________________________"
sudo tee -a /usr/lib/firefox/defaults/pref/autoconfig.js &>/dev/null << EOF
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF
sudo tee -a /usr/lib/firefox/firefox.cfg &>/dev/null << EOF
// IMPORTANT: Start your code on the 2nd line
defaultPref("services.sync.prefs.sync.browser.uiCustomization.state",true);
EOF


echo "_______________________________________"
echo "   Simplify $HOME personal folders     "
echo "_______________________________________"
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


echo "_________________________________________________________________________"
echo "   OPTIONAL BUT RECOMMENDED TASKS (choose y if you don't know better)    "
echo "_________________________________________________________________________"
#______________________________________
#          OPTIONAL
#______________________________________
# OPTIONAL: IF THIS IS A COMMON PC OR LAPTOP, CREATE A SUBVOLUME FOR USER DATA.  
echo "======================================="
echo "---------------------------------------"
echo "Hit y if this a regular, personal device, laptop/desktop pc ( y /n )?"
echo "Yes: Personal folders will be moved to (and linked back to home) and swapfile created on seperate root subvolumes. Swap will be properly configured for BTRFS."
read -p "No: Nothing will be configured, make sure personal data is stored on a seperate subvolume and consider a swapfile or alternatively configure zram." answer
case ${answer:0:1} in
    y|Y )
# Temporarily mount filesystem root
sudo mkdir /mnt/system
sudo mount -o subvolid=5 /dev/nvme0n1p2 /mnt/system
# create a root subvolume for user personal folders in the root filesystem
sudo btrfs subvolume create /mnt/system/@userdata
## unmount root filesystem
sudo umount /mnt/system
# Add lines to fstab to make it persistent after boot, you should manually fill in the UUID before rebooting
sudo tee -a /etc/fstab &>/dev/null << EOF
# Mount the BTRFS root subvolume @userdata
UUID=COPYPASTE-THE-LONG-UUID-FROM-THE-TOP /mnt/userdata           btrfs   defaults,noatime,subvol=@userdata,compress-force=zstd:2  0  0
EOF
## Temporarily mount @userdata subvolume and finish configuration
sudo mkdir /mnt/userdata
sudo mount -o subvol=@userdata /dev/nvme0n1p2 /mnt/userdata
## Move personal user folders to the subvolume
## Note I have already moved Desktop and Templates to my Documents folder via my config.sh file.  
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
## Now open fstab for the user to copy paste the UUID
echo "==========================================================================================================="
echo "-----------------------------------------------------------------------------------------------------------"
echo "Almost done, now a 2nd window will open and you need to copy/paste with your mouse the UUID from the top"
echo "And paste it where it says !!Copy UUID HERE !!"
echo "Then save changes with CTRL+O and exit the file with CTRL+X"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Are you ready to do this? Hit Enter and enter your password in the 2nd window to open the file."
x-terminal-emulator -e sudo nano /etc/fstab
read -p "When done in the 2nd window, hit ENTER in this window to continue..."
cd /
cd $HOME
cd $HOME/Downloads

    ;;
    * )
        echo "Not creating userdata, this is not a common personal device." 
    ;;
esac


# Install ALL Win10/Office365 fonts
echo "======================================="
echo "---------------------------------------"
echo "A few MS Office available for Linux + a few commonly used additional MS Office fonts have been installed by this script." 
echo "However, if you want your documents to look identical, you need to install all MS Office fonts."
echo "If you believe you have the right to do so, the script will download a prepackaged copy of all MS Office365/Win10 fonts and install them."
read -p "The win10-fonts.zip archive is required. Your browser will open the download page, continue (Y) or skip (N)? (Y/n)" answer
case ${answer:0:1} in
    y|Y )
       xdg-open 'https://mega.nz/file/u4p02JCC#HnJOVyK8TYDqEyVXLkwghDLKlKfIq0kOlX6SPxH53u0'
       read -p "Click any key when the download has finished completely..."
       echo "please wait while extracting fonts to the system fonts folder (/usr/share/fonts), the downloaded file will be deleted afterwards." 
       # Extract the manually downloaded file to a subfolder in the systems font folder
       sudo tar -xf $HOME/Downloads/fonts-office365.tar.xz -C /usr/share/fonts
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
echo "======================================="
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
echo "======================================="
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


# Firefox: use your own Firefox Sync Server for all Firefox profiles on this system
echo "======================================="
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
