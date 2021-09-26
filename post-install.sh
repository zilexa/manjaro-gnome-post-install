
Before installing apps:
/usr/share/applications/mimeinfo.cache do this:

sudo replace org.gnome.Nautilus.desktop with nemo.desktop;
sudo replace org.gnome.gedit.desktop; with pluma.desktop;

$HOME/.config/mimeapps.list should be:
[Added Associations]
application/pdf=org.gnome.Evince.desktop;libreoffice-draw.desktop;

[Default Applications]
inode/directory=nemo.desktop;
text/plain=pluma.desktop;


File: /usr/share/applications/org.gnome.gedit.desktop
replace gedit with pluma
set Icon=org.gnome.pluma to Icon=org.gnome.gedit
rename file to pluma.desktop
