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
sudo pacman-mirrors -g --continent -P https --api && sudo pacman -Syyu --noconfirm


echo "___________________________________________________________________________________"
echo "                                                                                   "
echo "                                   APPLICATIONS                                    "
echo "                                 remove unused apps                                "
echo "___________________________________________________________________________________"
# Remove unused apps
sudo pacman -Rsn --noconfirm geary
sudo pacman -Rsn --noconfirm onlyoffice-desktopeditors
sudo pacman -Rsn --noconfirm firefox-gnome-theme-maia
# -R removes package, -s removes its dependencies if they are not required by other packages, -n remove install configuration files


echo "___________________________________________________________________________________"
echo "                                                                                   "
echo "                                   APPLICATIONS                                    "
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
echo "                                   APPLICATIONS                                    " 
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
sudo cp '/usr/share/applications/pluma.desktop' '/usr/share/applications/plumabackup.backup'
sudo sed -i -e 's@Pluma@Text Editor@g' '/usr/share/applications/pluma.desktop'
sudo sed -i -e 's@Icon=accessories-text-editor@Icon=org.gnome.gedit@g' '/usr/share/applications/pluma.desktop'
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
gsettings set org.mate.pluma color-scheme 'cobalt'

## also when opening files as with elevated privileges (root user)
sudo -u root dbus-launch gsettings set org.mate.pluma highlight-current-line true
sudo -u root dbus-launch gsettings set org.mate.pluma bracket-matching true
sudo -u root dbus-launch gsettings set org.mate.pluma display-line-numbers true
sudo -u root dbus-launch gsettings set org.mate.pluma display-overview-map true
sudo -u root dbus-launch gsettings set org.mate.pluma auto-indent true
sudo -u root dbus-launch gsettings set org.mate.pluma active-plugins "['time', 'spell', 'sort', 'snippets', 'modelines', 'filebrowser', 'docinfo']"
sudo -u root dbus-launch gsettings set org.mate.pluma color-scheme 'cobalt'


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                                   APPLICATIONS                                    "    
echo "         Install must-have applications for various common tasks                   "
echo "___________________________________________________________________________________"
# Install system cleanup tool
sudo pacman -S --noconfirm bleachbit

# Install MS Office alternative with touch support
sudo pacman -S --noconfirm freeoffice

# Install MS Office alternative with lots of features
sudo pacman -S --noconfirm libreoffice-fresh

# Install handy desktop tools
sudo pacman -S --noconfirm variety

# Install a musicplayer that supports folder view library
sudo pacman -S --noconfirm strawberry

# Install Audacity audio editor and recorder
sudo pacman -S --noconfirm audacity

# Install simple video editor (cut/trim videos) from AUR repository
sudo pamac install --no-confirm losslesscut-bin

# Install handbrake to convert videos
sudo pacman -S --noconfirm handbrake

# Install simple image editor (like Paint)
sudo pacman -S --noconfirm pinta

# Install Darktable photo editor (like Adobe Photoshop)
sudo pacman -S --noconfirm darktable

# Install photo library management
sudo pacman -S --noconfirm digikam


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                            Firefox default settings                               "
echo "         (Applied for for all Firefox profiles created in the future.)             "
echo "___________________________________________________________________________________"
echo "      Create a default profile setting to enable syncing of your toolbar layout    " 
echo "___________________________________________________________________________________"
# delete existing profiles
rm -r /home/madhuri/.mozilla/firefox/*.default-release
rm -r /home/madhuri/.mozilla/firefox/*.default-release
rm -r /home/madhuri/.mozilla/firefox/*.default
rm /home/madhuri/.mozilla/firefox/profiles.ini

# Enable default config
sudo tee -a /usr/lib/firefox/defaults/pref/autoconfig.js &>/dev/null << EOF
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF
# Create default policies (install extensions and theme)
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
# Create default config
sudo tee -a /usr/lib/firefox/firefox.cfg &>/dev/null << EOF
// IMPORTANT: Start your code on the 2nd line
defaultPref("services.sync.prefs.sync.browser.uiCustomization.state",true);
defaultPref("browser.toolbars.bookmarks.visibility", "always");
defaultPref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[\"screenshot-button\",\"print-button\",\"save-to-pocket-button\",\"bookmarks-menu-button\",\"library-button\",\"preferences-button\",\"panic-button\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"downloads-button\",\"ublock0_raymondhill_net-browser-action\",\"urlbar-container\",\"customizableui-special-spring2\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"fxa-toolbar-menu-button\",\"history-panelmenu\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"_d133e097-46d9-4ecc-9903-fa6a722a6e0e_-browser-action\",\"_contain-facebook-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"widget-overflow-fixed-list\",\"PersonalToolbar\"],\"currentVersion\":17,\"newElementCount\":3}");
EOF


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                                   APPLICATIONS                                    "    
echo "                  Set default apps, pin to Panel and Arc Menu                      "
echo "___________________________________________________________________________________"
# Common image files should open with image viewer (gThumb) by default, with photo editor (Showfoto, part of DigiKam) and image editor (Pinta) as alternatives
sudo sed -i -e 's@image/jpg=pinta.desktop;@image/jpg=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;pinta.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@image/heic=org.kde.showfoto.desktop;@image/heic=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@image/heif=org.kde.showfoto.desktop;@image/heif=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@image/webp=org.kde.showfoto.desktop;@image/webp=org.gnome.gThumb.desktop;org.kde.showfoto.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@tiff=org.gnome.Evince.desktop;org.gnome.gThumb.desktop;org.kde.showfoto.desktop;pinta.desktop;@tiff=org.gnome.gThumb.desktop;org.gnome.Evince.desktop;org.kde.showfoto.desktop;pinta.desktop;@g' /usr/share/applications/mimeinfo.cache
# plain text files should open with text editor (Pluma) by default except for .csv files. Spreadsheet programs as backup (and default for .csv)
sudo sed -i -e 's@text/plain=libreoffice-writer.desktop;pluma.desktop;@text/plain=pluma.desktop;libreoffice-writer.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@text/tab-separated-values=libreoffice-calc.desktop;@text/tab-separated-values=pluma.desktop;libreoffice-calc.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@text/comma-separated-values=libreoffice-calc.desktop;@text/comma-separated-values=pluma.desktop;libreoffice-calc.desktop;@g' /usr/share/applications/mimeinfo.cache
sudo sed -i -e 's@text/csv=freeoffice-planmaker.desktop;libreoffice-calc.desktop;@text/csv=freeoffice-planmaker.desktop;libreoffice-calc.desktop;pluma.desktop;@g' /usr/share/applications/mimeinfo.cache

# Pin common apps to Arc Menu
gsettings set org.gnome.shell.extensions.arcmenu pinned-app-list "['FreeOffice TextMaker', '', 'freeoffice-textmaker.desktop', 'FreeOffice PlanMaker', '', 'freeoffice-planmaker.desktop', 'FreeOffice Presentations', '', 'freeoffice-presentations.desktop', 'ONLYOFFICE Desktop Editors', '', 'org.onlyoffice.desktopeditors.desktop', 'Document Scanner', '', 'simple-scan.desktop', 'Pinta Image Editor', '', 'pinta.desktop', 'digiKam', '', 'org.kde.digikam.desktop', 'Darktable Photo Workflow Software', '', 'darktable.desktop', 'Strawberry', '', 'org.strawberrymusicplayer.strawberry.desktop', 'Audacity', '', 'audacity.desktop', 'HandBrake', '', 'fr.handbrake.ghb.desktop', 'LosslessCut', '', 'losslesscut-bin.desktop', 'Add/Remove Software', '', 'org.manjaro.pamac.manager.desktop', 'BleachBit', '', 'org.bleachbit.BleachBit.desktop', 'Tweaks', '', 'org.gnome.tweaks.desktop', 'Extensions', '', 'org.gnome.Extensions.desktop', 'Terminal', '', 'org.gnome.Terminal.desktop']"
# Add most used apps to Panel (favourites)
gsettings set org.gnome.shell favorite-apps "['nemo.desktop', 'firefox.desktop', 'org.gnome.gThumb.desktop', 'pluma.desktop', 'org.gnome.Calculator.desktop']"


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "     Configure panel (taskbar), App menu (Arcmenu) and common dessktop, GUI settings      "
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
gsettings set org.gnome.shell.extensions.dash-to-panel panel-element-positions '{"0":[{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"centered"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}'
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
gsettings set org.gnome.shell.extensions.dash-to-panel panel-element-positions 
# Worspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 2
# Desktop
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding start-corner 'bottom-left'
# Theme
gsettings set org.gnome.desktop.interface gtk-theme 'Matcha-dark-sea'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark-Maia'
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
# Keyboard shortcut: Ctrl+Alt+T opens Terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"                  
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'         
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>T' 
# Remove Gnome default screenshot shortcuts as they will always be stored in /Pictures instead of /Pictures/Screenshots
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "@as []"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "@as []"
# Create Screenshots folder
mkdir $HOME/Pictures/Screenshots
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/${USER}/Pictures/Screenshots/"
# Create custom screenshot shortcuts, only custom shortcuts ARE stored to the auto-save-directory
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
echo "                   1) Touchpad Gestures: 4 instead of 3 fingers:                   "
echo "       this way, you can use 3-finger touchpad gestures within applications        "
echo "           2) Hot Corners Extended: allow config of screen hot corners             " 
echo "___________________________________________________________________________________"
# Download the gnome extension "Gesture Improvements"
#wget -O $HOME/Downloads/gestures.zip https://extensions.gnome.org/extension-data/gestureImprovementsgestures.v17.shell-extension.zip
# Get the UUID of the extension
#EXTUUID1=$(unzip -c $HOME/Downloads/gestures.zip metadata.json | grep uuid | cut -d \" -f4)
# Create a subfolder in the Extensions folder with the UUID as name
#mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTUUID1
# Unzip the files there
#unzip $HOME/Downloads/gestures.zip -d $HOME/.local/share/gnome-shell/extensions/$EXTUUID1/

# Do the same for extension "Custom Hot Corners Extended" 
#wget -O $HOME/Downloads/hotcorners.zip https://extensions.gnome.org/extension-data/custom-hot-corners-extendedG-dH.github.com.v10.shell-extension.zip
#EXTUUID2=$(unzip -c $HOME/Downloads/hotcorners.zip metadata.json | grep uuid | cut -d \" -f4)
#mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTUUID2
#unzip $HOME/Downloads/hotcorners.zip -d $HOME/.local/share/gnome-shell/extensions/$EXTUUID2/
## FIX FOR ARCMENU - can be deleted after fix is released via updates
#sudo wget -O /usr/share/gnome-shell/extensions/arcmenu@arcmenu.com/controller.js https://gitlab.com/arcmenu/ArcMenu/-/raw/master/controller.js 

# Install via Pamac, to enable auto-update
sudo pamac install --no-confirm gnome-gesture-improvements
sudo pamac install --no-confirm gnome-shell-extension-custom-hot-corners-extended

# Configure Hot Corners
gsettings set org.gnome.desktop.interface.enable-hot-corners false
gsettings set org.gnome.shell.extensions.custom-hot-corners-extended.monitor-0-top-left-0 action 'toggle-arcmenu'
gsettings set org.gnome.shell.extensions.custom-hot-corners-extended.monitor-0-bottom-right-0 action 'show-desktop-mon'
gsettings set org.gnome.shell.extensions.custom-hot-corners-extended.monitor-0-bottom-left-0 action 'toggle-overview'

#Enable extensions (Workspace indicator, thumb drive menu, Gesture Improvements), keep Hot Corners disabled due to Arc Menu Hot Corner conflict 
gsettings set org.gnome.shell disabled-extensions "['material-shell@papyelgringo', 'vertical-overview@RensAlthuis.github.com', 'dash-to-dock@micxgx.gmail.com', 'unite@hardpixel.eu', 'places-menu@gnome-shell-extensions.gcampax.github.com']"
gsettings set org.gnome.shell enabled-extensions "['pamac-updates@manjaro.org', 'gnome-ui-tune@itstime.tech', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-panel@jderose9.github.com', 'arcmenu@arcmenu.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', '$EXTUUID1', '$EXTUUID2']"


echo "___________________________________________________________________________________"
echo "                                                                                   " 
echo "                          Simplify $HOME personal folders                          "
echo "___________________________________________________________________________________"
# Change default location of personal folders by editing $HOME/.config/user-dirs.dirs
## Move /Templates to be subfolder of /Documents. 
sudo sed -i -e 's+$HOME/Templates+$HOME/Documents/Templates+g' $HOME/.config/user-dirs.dirs
## Disable Public folder because nobody uses it. 
sudo sed -i -e 's+$HOME/Public+$HOME/Downloads+g' $HOME/.config/user-dirs.dirs
## Rename Videos to Media making it the folder for tvshows/movies downloads or anything else that is not suppose to be in Photos. 
sudo sed -i -e 's+$HOME/Videos+$HOME/Media+g' $HOME/.config/user-dirs.dirs

# Now make the changes to the actual folders: 
## Remove unused Pubic folder
rmdir $HOME/Public
## Move Templates folder into Documents because it does not make sense to be outside it. 
mv $HOME/Templates $HOME/Documents/
## Rename and move contents from Pictures to Photos, Videos to Media.
mv /home/${USER}/Videos /home/${USER}/Media
#mv /home/${USER}/Pictures /home/${USER}/Photos
org.nemo.window-state sidebar-bookmark-breakpoint 4
org.nemo.window-state sidebar-bookmark-breakpoint 3
# Create folders for storing photo albums and for Digikam database
mkdir $HOME/Pictures/Albums
mkdir $HOME/Pictures/digikam-db && chattr +C $HOME/Pictures/digikam-db


echo "_________________________________________________________________________"
echo "                         OPTIONAL APPLICATIONS                           "
echo "_________________________________________________________________________"
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

# Configure RDP credentials, Manjaro Gnome has built-in RDP support for screen sharing. However no UI is available yet to set the credentials.
# After credentials have been created, you can simply enable/disable RDP by toggling "Screen Sharing" via Settings > Sharing. 
echo "---------------------------------------"
read -p "Configure Remote Desktop to share your screen securely, if you need support from family/friends? (y/n)" answer
case ${answer:0:1} in
    y|Y )
    sudo pacman -S --noconfirm gnome-remote-desktop
    echo "Please create credentials to allow access by others:"
    read -p 'Remote Desktop access username: ' rdpuser
    read -p 'Remote Desktop access password: ' rdppw
    echo "Your username/password will be $rdpuser/$rdppw."
    read -p "A self-signed certificate is required and will be created. Hit [ENTER] to start and prepare to answer questions for the certificate." 
    # Download the code snippet that generates RDP credentials
    wget -O $HOME/Downloads/grd_rdp_credentials.c https://gitlab.gnome.org/-/snippets/1778/raw/master/grd_rdp_credentials.c
    # Compile the file
    gcc grd_rdp_credentials.c `pkg-config --libs --cflags libsecret-1`
    # Use the program to store the credentials via libsecret
    ./a.out $rdpuser $rdppw
    # Create the server certificate and private keyfile
    openssl genrsa -out tls.key 4096
    openssl req -new -key tls.key -out tls.csr
    openssl x509 -req -days 730 -signkey tls.key -in tls.csr -out tls.crt
    # Move the certificate and keyfile to a better location
    mkdir $HOME/.config/remote-desktop
    mv $HOME/Downloads/tls.key $HOME/.config/remote-desktop/tls.key
    mv $HOME/Downloads/tls.crt $HOME/.config/remote-desktop/tls.crt
    # Set the location of the two files
    dconf write /org/gnome/desktop/remote-desktop/rdp/tls-key "'$HOME/.config/remote-desktop/tls.key'" 
    dconf write /org/gnome/desktop/remote-desktop/rdp/tls-cert "'$HOME/.config/remote-desktop/tls.crt'"
    # Cleanup
    rm $HOME/Downloads/tls.csr
    rm $HOME/Downloads/a.out
    rm $HOME/Downloads/grd_rdp_credentials.c

    echo "RDP credentials configured. Note RDP is still disabled! You can enable/disable RDP easily via Settings > Sharing > Share Screen."
    ;;
    * )
        echo "RDP credentials not configured. Enabling 'Share Screen' will only work for VNC (slow), not RDP."
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

# Get a Firefox shortcut for 2 profiles
echo "---------------------------------------"
echo "Firefox: would you like to be able to launch different profiles (2), by simply right-clicking the Firefox shortcut?"
read -p "Only useful if multiple users use this machine and each user has its own Firefox profile. (y/n)?" answer
case ${answer:0:1} in
    y|Y )
        echo adding profiles to right-click of Firefox shortcut... 
        wget --no-check-certificate -P $HOME/.local/share/applications https://raw.githubusercontent.com/zilexa/Ubuntu-Budgie-Post-Install-Script/master/firefox/firefox.desktop
    ;;
    * )
        echo "Keeping the Firefox shortcut as is..."
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
SYSTEMDRIVE=$(df / | grep / | cut -d" " -f1)
sudo mount -o subvolid=5 $SYSTEMDRIVE /mnt/system
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
sudo mv /home/${USER}/Pictures /mnt/userdata/
## Link personal folders inside subvolume back into home subvolume
ln -s /mnt/userdata/Documents $HOME/Documents
ln -s /mnt/userdata/Desktop $HOME/Desktop
ln -s /mnt/userdata/Downloads $HOME/Downloads
ln -s /mnt/userdata/Media $HOME/Media
ln -s /mnt/userdata/Music $HOME/Music
ln -s /mnt/userdata/Pictures $HOME/Pictures
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
wget -O $HOME/Downloads/swapforbtrfs.sh https://raw.githubusercontent.com/zilexa/manjaro-gnome-post-install/main/swap-for-btrfs
sudo su -c "bash -x $HOME/Downloads/swapforbtrfs.sh"
    ;;
    * )
        echo "Not configuring BTRFS swapfile and hibernation. It is recommended you configure zswap." 
    ;;
esac
