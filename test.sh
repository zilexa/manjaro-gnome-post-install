#!/bin/bash

wget -O $HOME/Downloads/gestures.zip https://extensions.gnome.org/extension-data/gestureImprovementsgestures.v17.shell-extension.zip
EXTUUID=$(unzip -c $HOME/Downloads/gestures.zip metadata.json | grep uuid | cut -d \" -f4)
mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTUUID
unzip $HOME/Downloads/gestures.zip -d $HOME/.local/share/gnome-shell/extensions/$EXTUUID/
#gnome-extensions enable $EXTUUID
gsettings set org.gnome.shell enabled-extensions "['pamac-updates@manjaro.org', 'gnome-ui-tune@itstime.tech', 'x11gestures@joseexposito.github.io', 'ding@rastersoft.com', 'appindicatorsupport@rgcjonas.gmail.com', 'dash-to-panel@jderose9.github.com', 'arcmenu@arcmenu.com', '$EXTUUID']"

