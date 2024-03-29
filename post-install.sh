#!/bin/bash
#
# Might need this for pacman automation: yes | LC_ALL=en_US.UTF-8 pacman
# Find and select the fastest mirror to install apps from
echo "___________________________________________________________________________________"
echo "                                                                                   "
echo "                                   APPLICATIONS                                    "
echo "                                 remove unused apps                                "
echo "___________________________________________________________________________________"
# Remove unused apps
# temporarily remove OnlyOffice and install after LibreOffice. This way, OnlyOffice will be the default for Office files, LibreOfice will be the alternative choice.
sudo pamac remove --no-confirm geary firefox-gnome-theme-maia gnome-shell-extension-x11gestures touchegg touche


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


# Query mirrors servers (on this continent only) to ensure updates are downloaded via the fastest HTTPS server
pacman-mirrors --continent --api -P https
# Perform update, force refresh of update database files
pamac update --force-refresh --no-confirm


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                                   APPLICATIONS                                    "    
echo "             Install must-have applications for various common tasks               "
echo "___________________________________________________________________________________"
# Install packages that should be installed by default:  (Why it is not installed by default? I'm clueless)
# Regquired to install discovered printers
sudo pamac install --no-confirm system-config-printer
# Required to automatically change screen rotation based on sensor
sudo pamac install --no-confirm iio-sensor-proxy

# Install system cleanup tool
sudo pamac install --no-confirm bleachbit 

# Install ability to connect to Wireguard VPN with automatic network configuration
sudo pamac install --no-confirm wireguard-tools

# Install ability to take an instant screenshot (of user selected area, a window or fullscreen). 
# The new screenshot utility built into Gnome 42 and higher does not allow you to do so and requires more user input. Install the regular one. 
pamac install --no-confirm gnome-screenshot

# Install support for sharing your desktop via RDP and install an RDP client to connect to other devices
sudo pamac install --no-confirm gnome-remote-desktop gnome-connections

# Install MS Office alternative. LibreOffice is the most complete Microsoft Office alternative. 
sudo pamac install --no-confirm libreoffice-fresh

# Install handy desktop tools
sudo pamac install --no-confirm variety

# Install a musicplayer that supports folder view library
sudo pamac install --no-confirm strawberry

# Install Audacity audio editor and recorder
sudo pamac install --no-confirm audacity

# Install simple video editor (cut/trim videos) from AUR repository
sudo pamac install --no-confirm losslesscut-bin

# Install handbrake to convert videos
sudo pamac install --no-confirm handbrake

# Install simple image editor/creator (like Paint)
sudo pamac install --no-confirm pinta

# Install photo editor
sudo pamac install --no-confirm gimp

# Install photo library management
sudo pamac install --no-confirm digikam

# Clean old versions
pamac clean --no-confirm


echo "___________________________________________________________________________________"
echo "                      APPLICATIONS - Gnome Extensions                              "    
echo " 1) Touchpad Gestures: 4 instead of 3 fingers, frees up 3-finger gestures for apps "
echo " 2) Hot Corners Extended: allow config of screen hot corners                       " 
echo " 3) Bing Wallpaper: Get a pretty wallpaper                                         "
echo "___________________________________________________________________________________"
# Install system-wide extensions. Will be kept up-to-date by system package manager.
# Install better Extension Manager
sudo pamac install --no-confirm extension-manager
# Install Gesture Improvements
sudo pamac install --no-confirm gnome-gesture-improvements
# Install Custom Hot Corners Extended
sudo pamac install --no-confirm gnome-shell-extension-custom-hot-corners-extended
# Install Improved OSK to support on-screen keyboard in all applications
sudo pamac install --no-confirm gnome-shell-extension-improvedosk

# Install local extensions to be updated automatically by the better Extension Manager that was just installed
cd /tmp
wget -O gnome-shell-extension-installer.sh "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
# Install Bing Wallpaper
bash gnome-shell-extension-installer.sh 1262
# Install "Allow Locked Remote Desktop" 
bash gnome-shell-extension-installer.sh 4338

# Install Walkpaper allowing seperate wallpapers per Workspace
# bash gnome-shell-extension-installer.sh 1262 --yes

# Remove gnome-shell-extension-installer script, user will be able to use better Extension Manager to find/install/remove/configure extensions
rm /tmp/gnome-shell-extension-installer.sh

#Enable extensions (Workspace indicator, thumb drive menu, Gesture Improvements)
gsettings set org.gnome.shell disabled-extensions "['material-shell@papyelgringo', 'vertical-overview@RensAlthuis.github.com', 'dash-to-dock@micxgx.gmail.com', 'unite@hardpixel.eu', 'places-menu@gnome-shell-extensions.gcampax.github.com']"
gsettings set org.gnome.shell enabled-extensions "['pamac-updates@manjaro.org', 'gnome-ui-tune@itstime.tech', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-panel@jderose9.github.com', 'arcmenu@arcmenu.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'custom-hot-corners-extended@G-dH.github.com', 'gestureImprovements@gestures', 'BingWallpaper@ineffable-gmail.com', 'allowlockedremotedesktop@kamens.us', 'improvedosk@nick-shmyrev.dev']"

## Configure Hot Corners
gsettings --schemadir /usr/share/glib-2.0/schemas set org.gnome.shell.extensions.custom-hot-corners-extended.corner:/org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-0/ action 'toggle-arcmenu'
gsettings --schemadir /usr/share/glib-2.0/schemas set org.gnome.shell.extensions.custom-hot-corners-extended.corner:/org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-bottom-right-0/ action 'show-desktop-mon'  
gsettings --schemadir /usr/share/glib-2.0/schemas set org.gnome.shell.extensions.custom-hot-corners-extended.corner:/org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-bottom-left-0/ action 'toggle-overview'  
gsettings --schemadir /usr/share/glib-2.0/schemas set org.gnome.shell.extensions.custom-hot-corners-extended.corner:/org/gnome/shell/extensions/custom-hot-corners-extended//misc panel-menu-enable 'false'

## Configure gestureImprovements
gsettings --schemadir /usr/share/gnome-shell/extensions/gestureImprovements@gestures/schemas set org.gnome.shell.extensions.gestureImprovements pinch-3-finger-gesture 'NONE'
gsettings --schemadir /usr/share/gnome-shell/extensions/gestureImprovements@gestures/schemas set org.gnome.shell.extensions.gestureImprovements pinch-4-finger-gesture 'SHOW_DESKTOP'
gsettings --schemadir /usr/share/gnome-shell/extensions/gestureImprovements@gestures/schemas set org.gnome.shell.extensions.gestureImprovements default-overview-gesture-direction false

## Configure Bing Wallpaper
gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/BingWallpaper@ineffable-gmail.com/schemas set org.gnome.shell.extensions.bingwallpaper icon-name 'low-frame-symbolic'
gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/BingWallpaper@ineffable-gmail.com/schemas set org.gnome.shell.extensions.bingwallpaper download-folder "~/Pictures/Wallpapers/"
gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/BingWallpaper@ineffable-gmail.com/schemas set org.gnome.shell.extensions.bingwallpaper random-interval 18000



echo "___________________________________________________________________________________"
echo "                                                                                   "
echo "                        APPLICATIONS - replace default app                         "
echo "             replace Nautilus filemanager with more friendly/usable Nemo           "
echo "___________________________________________________________________________________"
# Change default filemanager Nautilus for Nemo 
sudo pamac install --no-confirm nemo nemo-audio-tab nemo-bulk-rename nemo-emblems nemo-fileroller nemo-image-converter nemo-preview nemo-share
# Associate Nemo as the default filemanager
# For root
sudo xdg-mime default nemo.desktop inode/directory
sudo update-desktop-database /root/.local/share/applications/
# For current user
xdg-mime default nemo.desktop inode/directory
xdg-mime default nemo.desktop x-directory/normal
xdg-mime default nemo-autorun-software.desktop x-content/unix-software
update-desktop-database ~/.local/share/applications/

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
# Set Nemo bookmarks, reflecting folder that will be renamed later (Videos>Media)
truncate -s 0 $HOME/.config/gtk-3.0/bookmarks
tee -a $HOME/.config/gtk-3.0/bookmarks &>/dev/null << EOF
file:///home/${USER}/Downloads Downloads
file:///home/${USER}/Documents Documents
file:///home/${USER}/Music Music
file:///home/${USER}/Pictures Pictures
file:///home/${USER}/Media Media
EOF

echo "___________________________________________________________________________________"
echo "                                                                                   "
echo "                        APPLICATIONS - replace default app                         "
echo "               Replace Text Editor (gedit) with more intuitive Pluma               "
echo "___________________________________________________________________________________"
# Change default texteditor Gedit to Pluma but keep the nicer looking Text Editor name and icon
sudo pamac remove --no-confirm gedit
sudo pamac install --no-confirm pluma
sudo cp '/usr/share/applications/pluma.desktop' '/usr/share/applications/plumabackup.backup'
sudo sed -i -e 's@Pluma@Text Editor@g' '/usr/share/applications/pluma.desktop'
sudo sed -i -e 's@Icon=accessories-text-editor@Icon=org.gnome.gedit@g' '/usr/share/applications/pluma.desktop'
# Associate Pluma as the default text editor
sudo sed -i -e 's@libreoffice-writer.desktop;pluma.desktop;@pluma.desktop;libreoffice-writer.desktop;@g' /usr/share/applications/mimeinfo.cache
# For current user
xdg-mime default pluma.desktop text/plain
update-desktop-database ~/.local/share/applications/
# For root
sudo xdg-mime default pluma.desktop text/plain
sudo update-desktop-database /root/.local/share/applications/

#Configuration of Pluma for user
gsettings set org.mate.pluma highlight-current-line true
gsettings set org.mate.pluma bracket-matching true
gsettings set org.mate.pluma display-line-numbers true
gsettings set org.mate.pluma display-overview-map true
gsettings set org.mate.pluma auto-indent true
gsettings set org.mate.pluma active-plugins "['time', 'sort', 'snippets', 'modelines', 'filebrowser', 'docinfo']"
gsettings set org.mate.pluma color-scheme 'cobalt'

#Configuration of Pluma for root/elevated privileges
sudo -u root dbus-launch gsettings set org.mate.pluma highlight-current-line true
sudo -u root dbus-launch gsettings set org.mate.pluma bracket-matching true
sudo -u root dbus-launch gsettings set org.mate.pluma display-line-numbers true
sudo -u root dbus-launch gsettings set org.mate.pluma display-overview-map true
sudo -u root dbus-launch gsettings set org.mate.pluma auto-indent true
sudo -u root dbus-launch gsettings set org.mate.pluma active-plugins "['time', 'sort', 'snippets', 'modelines', 'filebrowser', 'docinfo']"
sudo -u root dbus-launch gsettings set org.mate.pluma color-scheme 'cobalt'


echo "___________________________________________________________________________________"
echo "                                                                                   "
echo "                             APPLICATIONS - configure apps                         "
echo "___________________________________________________________________________________"
echo "---------------------------------------" 
echo "OnlyOffice DesktopEditors configuration"
# Enable dark mode, use separate windows instead of tabs
mkdir -p $HOME/.config/onlyoffice
tee -a $HOME/.config/onlyoffice/DesktopEditors.conf &>/dev/null << EOF
UITheme=theme-dark
editorWindowMode=true
EOF
# Cannot enable 125% scaling (default is 150 or more, too high) since it is calculated per display/resolution. Set this yourself

echo "---------------------------------------" 
echo "LibreOffice profile enabling tabbed view, Office-like dark mode icons, Calibri default font and Office365 filetype by default and uto-save every 2min"
cd /tmp
wget -O /tmp/libreoffice-profile.tar.xz "https://github.com/zilexa/manjaro-gnome-post-install/raw/main/files/libreoffice-profile.tar.xz"
tar -xvf /tmp/libreoffice-profile.tar.xz -C $HOME/.config
rm /tmp/libreoffice-profile.tar.xz

echo "---------------------------------------" 
echo "Firefox default settings and addons"
# Enable Firefox support for Wayland
sudo sh -c "echo MOZ_ENABLE_WAYLAND=1 >> /etc/environment"
# For current and future system users and profiles
# Create default policies (install minimal set of extensions and theme, enable syncing of your toolbar layout, disable default Mozilla bookmarks)
# first delete existing profiles
rm -r $HOME/.mozilla/firefox/*.default-release
rm -r $HOME/.mozilla/firefox/*.default
rm $HOME/.mozilla/firefox/profiles.ini

# Enable default Firefox config file
sudo tee -a /usr/lib/firefox/defaults/pref/autoconfig.js &>/dev/null << EOF
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF
# Create default Firefox config file
# -Use system default file manager - include toolbar layout in Sync - Enable bookmarks bar - set toolbar layout
sudo tee -a /usr/lib/firefox/firefox.cfg &>/dev/null << EOF
// IMPORTANT: Start your code on the 2nd line
defaultPref("dom.w3c_touch_events.enabled",1);
defaultPref("widget.use-xdg-desktop-portal.file-picker",1);
defaultPref("widget.use-xdg-desktop-portal.mime-handler",1);
defaultPref("services.sync.prefs.sync.browser.uiCustomization.state",true);
defaultPref("browser.toolbars.bookmarks.visibility", "always");
defaultPref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[\"screenshot-button\",\"print-button\",\"save-to-pocket-button\",\"bookmarks-menu-button\",\"library-button\",\"preferences-button\",\"panic-button\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"downloads-button\",\"ublock0_raymondhill_net-browser-action\",\"urlbar-container\",\"customizableui-special-spring2\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"fxa-toolbar-menu-button\",\"history-panelmenu\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"_d133e097-46d9-4ecc-9903-fa6a722a6e0e_-browser-action\",\"_contain-facebook-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"widget-overflow-fixed-list\",\"PersonalToolbar\"],\"currentVersion\":17,\"newElementCount\":3}");
EOF
# Create default firefox policies
# -Cleanup bookmarks toolbar by disabling default Mozilla bookmarks - install bare minimum extensions
sudo tee -a /usr/lib/firefox/distribution/policies.json &>/dev/null << EOF
{
  "policies": {
    "DisableProfileImport": true,
    "NoDefaultBookmarks": true,
    "Extensions": {
      "Install": ["https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi", "https://addons.mozilla.org/firefox/downloads/latest/bypass-paywalls-clean/latest.xpi", "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi", "https://addons.mozilla.org/firefox/downloads/latest/facebook-container/latest.xpi", "https://addons.mozilla.org/firefox/downloads/latest/google-container/latest.xpi", "https://addons.mozilla.org/firefox/downloads/latest/nord-polar-night-theme/latest.xpi"]
    }
  }
}
EOF

#echo "Timeshift default configuration - DISABLED because changing its config file only changes UI values, it does not actually change its behaviour."
#echo "---------------------------------------" 
# Disable BTRFS Quotas by default and enable 'include @home'
## THIS LEADS TO AN ISSUE: the UI will show Quotas disabled, however Timeshift will keep trying to use quotas, leading to error messages and trouble deleting snapshots.
## You should disable quotas and enable @home inclusion during the first start wizard of Timeshift. 
#
#sudo truncate -s 0 /etc/timeshift/timeshift.json
#sudo tee -a /etc/timeshift/timeshift.json &>/dev/null << EOF
# {
#  "backup_device_uuid" : "",
#  "parent_device_uuid" : "",
#  "do_first_run" : "true",
#  "btrfs_mode" : "true",
#  "include_btrfs_home" : "true",
#  "stop_cron_emails" : "true",
#  "btrfs_use_qgroup" : "false",
#  "schedule_monthly" : "true",
#  "schedule_weekly" : "true",
#  "schedule_daily" : "true",
#  "schedule_hourly" : "false",
#  "schedule_boot" : "false",
#  "count_monthly" : "1",
#  "count_weekly" : "2",
#  "count_daily" : "3",
#  "count_hourly" : "6",
#  "count_boot" : "5",
#  "snapshot_size" : "0",
#  "snapshot_count" : "0",
#  "exclude" : [
#  ],
#  "exclude-apps" : [
#  ]
# }
#EOF


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                                   APPLICATIONS                                    "    
echo "                               Set file associations                               "
echo "___________________________________________________________________________________"
# Common image files should open with image viewer (gThumb) by default, with photo editor (Showfoto, part of DigiKam) and image editor (Pinta) as alternatives
sudo sed -i -e 's@image/jpg=pinta.desktop;@image/jpg=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;pinta.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@image/heic=org.kde.showfoto.desktop;@image/heic=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@image/heif=org.kde.showfoto.desktop;@image/heif=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@image/webp=org.kde.showfoto.desktop;@image/webp=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@tiff=org.gnome.Evince.desktop;org.gnome.gThumb.desktop;org.kde.showfoto.desktop;pinta.desktop;@tiff=org.gnome.gThumb.desktop;org.gnome.Evince.desktop;org.kde.showfoto.desktop;pinta.desktop;@g' /usr/share/applications/mimeinfo.cache

# For some reason, Office and image files are still associated with LibreOffice and Gimp, even if you reinstall OnlyOffice and Gthumb. 
# Discussed in this topic: 
# Manual changes made to /usr/share/applications/mimeinfo.cache will not survive a system or related application update. 
# To solve this (but only for the current user), the xdg-mime command can be used. 
# Associate gThumb by default instead of Gimp
xdg-mime default org.gnome.gThumb.desktop image/bmp
xdg-mime default org.gnome.gThumb.desktop image/jpeg
xdg-mime default org.gnome.gThumb.desktop image/jpg
xdg-mime default org.gnome.gThumb.desktop image/gif
xdg-mime default org.gnome.gThumb.desktop image/png
xdg-mime default org.gnome.gThumb.desktop image/tiff
xdg-mime default org.gnome.gThumb.desktop image/vnd.microsoft.icon
xdg-mime default org.gnome.gThumb.desktop image/x-png
xdg-mime default org.gnome.gThumb.desktop image/vnd.zbrush.pcx
xdg-mime default org.gnome.gThumb.desktop image/x-tga
xdg-mime default org.gnome.gThumb.desktop image/xpm
xdg-mime default org.gnome.gThumb.desktop image/svg+xml
xdg-mime default org.gnome.gThumb.desktop image/webp
xdg-mime default org.gnome.gThumb.desktop image/jxl
# Associate OnlyOffice by default
xdg-mime default org.onlyoffice.desktopeditors.desktop text/comma-separated
xdg-mime default org.onlyoffice.desktopeditors.desktop text/csv
xdg-mime default org.onlyoffice.desktopeditors.desktop text/rtf
xdg-mime default org.onlyoffice.desktopeditors.desktop text/spreadsheet
xdg-mime default org.onlyoffice.desktopeditors.desktop text/tab-separated-values
xdg-mime default org.onlyoffice.desktopeditors.desktop text/x-comma-separated-values
xdg-mime default org.onlyoffice.desktopeditors.desktop text/x-csv
xdg-mime default org.onlyoffice.desktopeditors.desktop application/x-msexcel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/x-ms-excel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/x-excel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/x-doc
xdg-mime default org.onlyoffice.desktopeditors.desktop application/csv
xdg-mime default org.onlyoffice.desktopeditors.desktop application/excel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/msexcel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/mspowerpoint
xdg-mime default org.onlyoffice.desktopeditors.desktop application/msword
xdg-mime default org.onlyoffice.desktopeditors.desktop application/rtf
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel.sheet.binary.macroEnabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel.sheet.binary.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel.sheet.macroEnabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel.sheet.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel.template.macroEnabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-excel.template.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint.presentation.macroEnabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint.presentation.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint.slideshow.macroEnabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint.template.macroEnabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-powerpoint.template.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-word
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-word.document.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.ms-word.template.macroenabled.12
xdg-mime default org.onlyoffice.desktopeditors.desktop application/wordperfect
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.presentation
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.presentation-flat-xml
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.presentation-template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.spreadsheet
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.spreadsheet-flat-xml
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.spreadsheet-template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.text
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.text-flat-xml
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.text-master
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.text-master-template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.text-template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.oasis.opendocument.text-web
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openofficeorg.extension
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.presentation
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.slide
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.slideshow
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.palm
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.rar
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.rn-realmedia
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.rn-realmedia-vbr
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.stardivision.writer-global
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.base
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.calc
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.calc.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.draw
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.draw.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.impress
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.impress.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.math
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.writer
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.writer.global
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.sun.xml.writer.template
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.visio
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.wordperfect
xdg-mime default org.onlyoffice.desktopeditors.desktop application/wordperfect
xdg-mime default org.onlyoffice.desktopeditors.desktop application/x-123
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.presentation
xdg-mime default org.onlyoffice.desktopeditors.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.sheet

# run this command to apply the changes to the mimeapps.list file
update-desktop-database ~/.local/share/applications/


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "  Configure panel (taskbar), App menu (Arcmenu) and common dessktop, GUI settings  "
echo "___________________________________________________________________________________"
# Pin common apps to Arc Menu
gsettings set org.gnome.shell.extensions.arcmenu pinned-app-list "['ONLYOFFICE Desktop Editors', '', 'org.onlyoffice.desktopeditors.desktop', 'LibreOffice Writer', '', 'libreoffice-writer.desktop', 'LibreOffice Calc', '', 'libreoffice-calc.desktop', 'LibreOffice Impress', '', 'libreoffice-impress.desktop', 'Document Scanner', '', 'simple-scan.desktop', 'Pinta Image Editor', '', 'pinta.desktop', 'digiKam', '', 'org.kde.digikam.desktop', 'GNU Image Manipulation Program', '', 'gimp.desktop', 'Strawberry', '', 'org.strawberrymusicplayer.strawberry.desktop', 'Audacity', '', 'audacity.desktop', 'LosslessCut', '', 'losslesscut-bin.desktop', 'Shotcut', '', 'org.shotcut.Shotcut.desktop', 'HandBrake', '', 'fr.handbrake.ghb.desktop', 'BleachBit', '', 'org.bleachbit.BleachBit.desktop', 'Tweaks', '', 'org.gnome.tweaks.desktop', 'Terminal', '', 'org.gnome.Terminal.desktop', 'Extension Manager', '', 'com.mattjakeman.ExtensionManager.desktop', 'Add/Remove Software', '', 'org.manjaro.pamac.manager.desktop']"
# Add most used apps to Panel (favourites)
gsettings set org.gnome.shell favorite-apps "['nemo.desktop', 'firefox.desktop', 'org.gnome.gThumb.desktop', 'pluma.desktop', 'org.gnome.Calculator.desktop']"
# Arc Menu & Dash to Panel
gsettings set org.gnome.shell.extensions.arcmenu arc-menu-placement 'DTP'
gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Eleven'
gsettings set org.gnome.shell disabled-extensions "['material-shell@papyelgringo', 'vertical-overview@RensAlthuis.github.com', 'dash-to-dock@micxgx.gmail.com', 'unite@hardpixel.eu', 'places-menu@gnome-shell-extensions.gcampax.github.com']"
gsettings set org.gnome.shell enabled-extensions "['pamac-updates@manjaro.org', 'gnome-ui-tune@itstime.tech', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-panel@jderose9.github.com', 'arcmenu@arcmenu.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'custom-hot-corners-extended@G-dH.github.com', 'gestureImprovements@gestures', 'BingWallpaper@ineffable-gmail.com']"
gsettings set org.gnome.shell.extensions.arcmenu available-placement "[false, true, false]"
gsettings set org.gnome.shell.extensions.dash-to-panel panel-positions '{"0":"LEFT"}'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.shell.extensions.arcmenu reload-theme true
gsettings set org.gnome.shell.extensions.arcmenu power-options "[(0, true), (1, true), (2, true), (3, true), (4, true), (5, false), (6, true)]"
# Arc Menu Hot corner (top left) 
gsettings set org.gnome.shell.extensions.arcmenu override-hot-corners false
gsettings set org.gnome.shell.extensions.arcmenu hot-corners 'Default'
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
gsettings set org.gnome.shell.extensions.dash-to-panel panel-element-positions '{"0":[{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"centered"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-lengths '{"0":100}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-positions '{"0":"LEFT"}'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 51
gsettings set org.gnome.shell.extensions.dash-to-panel panel-sizes '{"0":51}'
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
#gsettings set org.gnome.shell.extensions.dash-to-panel panel-element-positions 
# Workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 2
# Desktop
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding start-corner 'bottom-left'
gsettings set org.gnome.shell.extensions.ding sort-special-folders true
gsettings set org.gnome.shell.extensions.ding keep-arranged true
# Theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark-Maia'
# Display
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 22.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 8.75
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/wallpapers-2018/palm-beach.jpg'
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 'uint32 480'
# cleanup
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
# Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
# Locale
gsettings set org.gnome.system.location enabled true
gsettings set org.gnome.desktop.datetime automatic-timezone true
gsettings set org.gnome.desktop.calendar show-weekdate true
# Keyboard shortcut: Ctrl+Alt+T opens Terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"                  
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'         
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>T' 
# Remove Gnome <41 (gnome-screenshots tool) default screenshot shortcuts, they are not logical and do not store screenshots in Pictures/Screenshots
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "@as []"
# Remove Gnome 42> (Screenshots tool) default screenshot shortcuts, they use the new tool that requires too much user interaction
gsettings set org.gnome.shell.keybindings screenshot "@as []"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "@as []"
gsettings set org.gnome.shell.keybindings screenshot-window "@as []"
# Create Screenshots folder
mkdir $HOME/Pictures/Screenshots
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/${USER}/Pictures/Screenshots/"
# Create custom screenshot shortcuts using foold old gnome-screenshots, only custom shortcuts ARE stored to the auto-save-directory
# Note gnome-screenshot package needs to be installed (already done by this script)
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/']"     
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Area screenshot to custom folder'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'gnome-screenshot -a'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding 'Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Area screenshot to clipboard'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'gnome-screenshot -a -c'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Shift>Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'Window screenshot to custom folder'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'gnome-screenshot -w -p'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Alt>Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ name 'window screenshot to clipboard'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ command 'gnome-screenshot -w -c'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ binding '<Primary>Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ name 'Interactive screenshot to cust folder'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ command 'gnome-screenshot -i -p'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ binding '<Primary><Shift>Print'


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                          Create systemdrive mountpoint                            "
echo "___________________________________________________________________________________"
# Add an ON-DEMAND mountpoint in FSTAB for the systemdrive, to easily do a manual mount when needed (via "sudo mount /mnt/drives/system")
# create mountpoint
sudo mkdir -p /mnt/drives/system
# Get the systemdrive UUID
fs_uuid=$(findmnt / -o UUID -n)
# Add mountpoint to FSTAB
sudo tee -a /etc/fstab &>/dev/null << EOF

# Allow easy manual mounting of btrfs root subvolume                         
UUID=${fs_uuid} /mnt/drives/system  btrfs   subvolid=5,defaults,noatime,noauto  0  0

EOF
#Get device path of systemdrive, for example "/dev/nvme0n1p2" via #SYSTEM=$(df / | grep / | cut -d" " -f1)


echo "_________________________________________________________________________"
echo "                   SETUP ADDITIONAL BTRFS SUBVOLUMES                     "
echo "  Isolate & simplify userdata, exclude temp data from snapshots/backups  "
echo "_________________________________________________________________________"
echo "Create subvolumes for userdata, for downloads and for user cache" 
echo "-----------------------------------------------"
# Temporarily mount filesystem root to create a new root subvolume
sudo mount /mnt/drives/system

# Create mountpoint for @users
sudo mkdir -p /mnt/users
# create a root subvolume for user personal folders in the root filesystem
sudo btrfs subvolume create /mnt/drives/system/@users
# create a root subvolume for the Downloads folder, to exclude it from snapshots and backups
sudo btrfs subvolume create /mnt/drives/system/@downloads
# create a root subvolume for the $HOME/.cache folder, to exclude it from snapshots and backups
sudo btrfs subvolume create /mnt/drives/system/@usercache
# Get system fs UUID
fs_uuid=$(findmnt / -o UUID -n)

# Add subvolumes to fstab to mount at boot
sudo tee -a /etc/fstab &>/dev/null << EOF
UUID=${fs_uuid} /home/${USER}/.cache  btrfs   subvol=@usercache,defaults,noatime,compress-force=zstd:1  0  0
UUID=${fs_uuid} /home/${USER}/Downloads  btrfs   subvol=@downloads,defaults,noatime,x-gvfs-hide,compress-force=zstd:1  0  0
# Mount @users subvolume
UUID=${fs_uuid} /mnt/users  btrfs   subvol=@users,defaults,noatime,compress-force=zstd:1  0  0
EOF

# Set user permissions and ownership
sudo chown -R ${USER}:${USER} /mnt/users/${USER}
sudo chmod -R 755 /mnt/users/${USER}
sudo chown -R ${USER}:${USER} /mnt/drives/system/@downloads
sudo chmod -R 755 /mnt/drives/system/@downloads
sudo chown -R ${USER}:${USER} /mnt/drives/system/@usercache
sudo chmod -R 755 /mnt/drives/system/@usercache

# Move contents of original folders to subvolumes.  
mv $HOME/Downloads/* /mnt/drives/system/@downloads
mv $HOME/.cache/* /mnt/drives/system/@usercache
#Temporarily rename .cache and create new .cache folder to ensure it is an empty mountpoint. 
mv $HOME/.cache $HOME/.cacheold
mkdir $HOME/.cache

# Mount the new fstab, this will mount @downloads to $HOME/Downloads, @usercache to @HOME/.cache and @users to /mnt/users
sudo systemctl daemon-reload
sudo mount -a

echo "------------------------------------------------------------------------------------"
echo "Move documents folders to subvolume/username/ and link them back to $HOME except for /Downloads" 
echo "Also simplify folder structure" 
# Create Documents folder in subvolume because moving the folder does not seem to work
sudo mkdir -p /mnt/users/${USER}
#sudo chown ${USER}:${USER} /mnt/users/${USER}
## Move personal user folders to the subvolume, rename Videos to Media while doing that
sudo mv --verbose /home/${USER}/Documents /mnt/users/${USER}/
sudo mv --verbose /home/${USER}/Music/ /mnt/users/${USER}/
sudo mv --verbose /home/${USER}/Pictures/ /mnt/users/${USER}/
sudo mv --verbose /home/${USER}/Videos /mnt/users/${USER}/Media

## Move Templates folder into Documents because it does not make sense to be outside it. 
mv --verbose $HOME/Templates /mnt/users/${USER}/Documents/
## Now register default location of personal folder Templates as subfolder of Documents
sed -i -e 's+$HOME/Templates+$HOME/Documents/Templates+g' $HOME/.config/user-dirs.dirs

## Link personal folders inside subvolume back into home subvolume
ln -s /mnt/users/${USER}/Documents $HOME/Documents
ln -s /mnt/users/${USER}/Music $HOME/Music
ln -s /mnt/users/${USER}/Pictures $HOME/Pictures
ln -s /mnt/users/${USER}/Media $HOME/Media
## Rename default location of personal folder Videos to Media
sudo sed -i -e 's+$HOME/Videos+$HOME/Media+g' $HOME/.config/user-dirs.dirs

# Do the same for Desktop, but this folder wil be auto-created immediately in $HOME so we need to...
# temporarily change path of system folder Desktop, then $HOME/Desktop can be moved
sed -i -e 's+$HOME/Desktop+/mnt/users/'${USER}'/Desktop+g' $HOME/.config/user-dirs.dirs 
# Move Desktop folder
sudo mv /home/${USER}/Desktop /mnt/users/${USER}/Desktop
# Link Desktop from subvolume to $HOME
ln -s /mnt/users/${USER}/Desktop $HOME/Desktop
## Now register default location of personal folder Desktop back in its original location
sed -i -e 's+/mnt/users/'${USER}'/Desktop+$HOME/Desktop+g' $HOME/.config/user-dirs.dirs

## Register default location of personal folder Public to Downloads.
sed -i -e 's+$HOME/Public+$HOME/Downloads+g' $HOME/.config/user-dirs.dirs
## Remove Public folder
rmdir $HOME/Public

echo "-------------------------------------------------------------"
echo "Create folders for storing photo albums and for Digikam database"
mkdir $HOME/Pictures/Albums
mkdir -p $HOME/Pictures/Wallpapers/Wallpapers
mkdir $HOME/Pictures/digikam-db
chattr +C $HOME/Pictures/digikam-db


echo "_________________________________________________________________________"
echo "                         OPTIONAL APPLICATIONS                           "
echo "_________________________________________________________________________"
echo "_________________________________________________________________________"
echo "               Configure BTRFS swap and enable hibernation               "
echo "_________________________________________________________________________"
echo "Highly recommended if this is a laptop. It will allow hybrid sleep and hibernation."
echo "Select 'n' if this is your server: You don't need hibernate but zswap instead."
read -p "Configure swapfile for BTRFS and enable hibernation y/n ?" answer
case ${answer:0:1} in
    y|Y )
    cd /tmp
    wget -O /tmp/btrfs-hibernation.sh "https://raw.githubusercontent.com/zilexa/manjaro-gnome-post-install/main/btrfs-hibernation.sh"
    #sudo su -c "bash -x /tmp/btrfs-hibernation.sh" # Script should not be run as sudo, because it contains non-sudo commands at the end
    bash "/tmp/btrfs-hibernation.sh"
    ;;
    * )
        echo "Not configuring BTRFS swapfile and hibernation. It is recommended you configure zswap." 
    ;;
esac

# Install ALL Win10/Office365 fonts
echo "---------------------------------------"
echo "Install all MS Office365 fonts, for full compatibility with MS Office files?"
echo "Only choose 'y' if you believe you have the license and approval of MS to download all their fonts." 
read -p "Your browser will open and you need to download the fonts package. Continue? (Y/n)" answer
case ${answer:0:1} in
    y|Y )
    echo "---------------------------------------" 
    echo "                                       " 
    echo " NOTE: this is the first time Firefox will open (to download Office365 fonts)"
    echo " give it a moment to load its youtube adblocking and paywall bypass addons" 
    echo "                                       " 
    echo "For you to do after it has opened a few tabs automatically:" 
    echo "                                       " 
    echo "1. SponsorBlock tab: Just close it (the default settings work for most people)" 
    echo "2a. Bypass Paywall tab: Click OPT-IN button. Overview of permissions will load: enable all, give permissions, click OPTIONS"   
    echo "2b. Bypass Paywall tab: click GO TO SAVE, uncheck the 'SHOW OPTIONS ON UPDATE', hit SAVE, close tab" 
    echo "3. MEGA download tab. hit download." 
    echo "                                       " 
    echo "When the download of Office fonts is finished, CLOSE FIREFOX." 
    echo "                                       " 
    read -p "Ready to do the above steps? Click enter, Firefox will open to download the file. You can do the above. "
    xdg-open 'https://mega.nz/file/u4p02JCC#HnJOVyK8TYDqEyVXLkwghDLKlKfIq0kOlX6SPxH53u0'
    echo "                                       " 
    read -p "Ignore the error that appeared after you closed Firefox. PLEASE CLICK ENTER"
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


# Install Owncloud Desktop Client for webDAV syncing with FileRun 
echo "---------------------------------------"
echo "If you have your own cloud/homeserver, install the best webDAV desktop client to sync this device?" 
echo "Recommended if you run a FileRun/NextCloud/OwnCloud or other WebDAV server." 
read -p "The NextCloud Desktop Client contains issues, Owncloud Desktop Client is the most stable 2-way sync webDAV app. Install (y / n)?" answer
case ${answer:0:1} in
    y|Y )
    sudo pamac install --no-confirm owncloud-client
    sudo pamac install --as-deps --no-confirm nemo-python python-caja
    ;;
    * )
        echo "Skipping Nextcloud Desktop Client..."
    ;;
esac


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


# Configure RDP credentials, Manjaro Gnome has built-in RDP support for screen sharing. However no UI is available yet to set the credentials.
# After credentials have been created, you can simply enable/disable RDP by toggling "Screen Sharing" via Settings > Sharing. 
#echo "---------------------------------------"
#read -p "Configure Remote Desktop to share your screen securely, if you need support from family/friends? (y/n)" answer
#case ${answer:0:1} in
#    y|Y )
#    echo "Please create credentials to allow access by others:"
#    read -p 'Remote Desktop access username: ' rdpuser
#    read -p 'Remote Desktop access password (only letters and/or numbers!): ' rdppw
#    echo "Your username/password will be $rdpuser/$rdppw."
#    read -p "A self-signed certificate is required and will be created. Hit [ENTER] to start and prepare to answer questions for the certificate." 
    # Download the code snippet that generates RDP credentials
#    cd /tmp
#    wget -O /tmp/grd_rdp_credentials.c "https://gitlab.gnome.org/-/snippets/1778/raw/master/grd_rdp_credentials.c"
    # Compile the file
#    gcc grd_rdp_credentials.c `pkg-config --libs --cflags libsecret-1`
    # Use the program to store the credentials via libsecret
#    ./a.out $rdpuser $rdppw
    # Create the server certificate and private keyfile
#   openssl genrsa -out tls.key 4096
#   openssl req -new -key tls.key -out tls.csr
#   openssl x509 -req -days 730 -signkey tls.key -in tls.csr -out tls.crt
    # Move the certificate and keyfile to a better location
#    mkdir $HOME/.config/remote-desktop
#    mv tls.key $HOME/.config/remote-desktop/tls.key
#    mv tls.crt $HOME/.config/remote-desktop/tls.crt
    # Set the location of the two files
#    dconf write /org/gnome/desktop/remote-desktop/rdp/tls-key "'$HOME/.config/remote-desktop/tls.key'" 
#    dconf write /org/gnome/desktop/remote-desktop/rdp/tls-cert "'$HOME/.config/remote-desktop/tls.crt'"
#    gsettings set org.gnome.desktop.remote-desktop.rdp view-only false
    # Cleanup
#    rm /tmp/tls.csr
#    rm /tmp/a.out
#    rm /tmp/grd_rdp_credentials.c

#    echo "RDP credentials configured. Note RDP is still disabled! You can enable/disable RDP easily via Settings > Sharing > Share Screen."
#    ;;
#    * )
#        echo "RDP credentials not configured. Enabling 'Share Screen' will only work for VNC (slow), not RDP."
#    ;;
#esac


# Install LibreOffice languagepack
echo "---------------------------------------"
echo "Install languagepack for LibreOffice?" answer

case ${answer:0:1} in
    y|Y )
    echo "Please type the 2-letter countrycode for the language you would like to install, for example "de" for German language (no caps):"
    read -p 'countrycode for example "nl" and hit ENTER: ' lang
    sudo pamac install --no-confirm libreoffice-fresh-$lang hunspell-$lang hyphen-$lang
    ;;
    * )
        echo "Not installing a languagepack for LibreOffice..." 
    ;;
esac


# Get a Firefox shortcut for 2 profiles
echo "---------------------------------------"
echo "Firefox: would you like to be able to launch different profiles (2), by simply right-clicking the Firefox shortcut?"
read -p "Only useful if multiple users use this machine and each user has its own Firefox profile. (y/n)?" answer
case ${answer:0:1} in
    y|Y )
    echo adding profiles to right-click of Firefox shortcut... 
    wget --no-check-certificate -P $HOME/.local/share/applications https://raw.githubusercontent.com/zilexa/Ubuntu-Budgie-Post-Install-Script/master/firefox/firefox.desktop
    # The shortcut in ~/.local/share/application overrides the system shortcuts in /usr/share/applications. This also removes file associations. Fix those:
    xdg-settings set default-web-browser firefox.desktop
    xdg-mime default firefox.desktop x-scheme-handler/chrome
    xdg-mime default firefox.desktop application/x-extension-htm
    xdg-mime default firefox.desktop application/x-extension-html
    xdg-mime default firefox.desktop application/x-extension-shtml
    xdg-mime default firefox.desktop application/xhtml+xml
    xdg-mime default firefox.desktop application/x-extension-xhtml
    xdg-mime default firefox.desktop application/x-extension-xht
    ;;
    * )
        echo "Keeping the Firefox shortcut as is..."
    ;;
esac
