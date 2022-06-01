# Manjaro Gnome - The Out of The Box Experience _further improved_

Manjaro Gnome already has a very good Out-Of-The-Box Experience. 
This script will make it more intuitive, practical and easy to use by selecting sane preferences, replacing a few common applications and enabling features that one might expect to be enabled and configured by default. 

- [Features](https://github.com/zilexa/manjaro-gnome-post-install#quick-guide)
- [Quick Guide how to install Manjaro Gnome and run this script](https://github.com/zilexa/manjaro-gnome-post-install#quick-guide)

# Features

### Desktop layout: minimal, easy, maximizing available screen
- Dock disabled, Vertical Panel enabled with Favourite apps and an Arc Menu with "Eleven" layout
- Pinned common applications to the menu and favourite apps to the Panel
- Several toggles enabled/disabled to provide a smooth experience
  - Several Panel, Arc Menu, Desktop settings
  - Week numbers in Calendar
  - Show battery percentage in taskbar
  - Enable auto night light
  - Hide Home folder on desktop
  - Configure Night Light
  - Configure display time out and hibernate time
  - Enable auto-cleanup
  - Automatic timezone
  - PrintScr button allows Area selection and saves to /Pictures/Screenshots folder
  - Touchpad scroll direction set to mouse scroll direction (= disable natural scrolling)

### Gestures
- Touchpad gestures extended: 4 finger system gestures (instead of default 3) to allow applications to bind 2 and 3 finger gestures. 
- Hotcorners improved: instead of 1 hotcorner, every corner of the screen can be configured. Top left triggers App menu, bottom left triggers Overview, bottom-right Desktop.

### Reduce amount of personal folders
- move Templates to Documents folder
- Remove Public folder (is now Downloads)
- Rename Videos to Media

### Replaced apps for more intuitive, easier to use and more functional apps: 
- Replaced gedit with Pluma as Text Editor, while maintaining the beautiful icon and name. 
- Added Nemo and made it default Filemanager (cannot remove the default Nautilus).
- Added FreeOffice as default for Word/Excel/Powerpoint, in addition to OnlyOffice.

### Per-application configuration
#### App Store (Add/Remove programs, aka Pamac)
- Weekly check for updates (instead of 6 hours)
- Enable AUR and updates
- Download updates and hide systray icon if no update is available
- Test and rank mirrors and select the fastest mirror to download updates from

#### File Manager (Nemo instead of Nautilus)
- List view instead of large icon view, also for root user
- Easy rename of files, also for root user
- Reload button

#### Text Editor (Pluma instead of gedit)
- More readable colors
- Display numbers, closing brackets, file overview

#### Firefox
- Allow syncing the toolbar layout with your Firefox profile
- Optionally set your own Sync Server. 

#### Install common applications, can be managed via Add/Remove Programs:
- Bleachbit (to cleanup the system)
- Variety (periodically changes background with images of nature via Bing)
- Strawberry (audioplayer with folder-view support)
- Audacity (to edit audio files or record audio)
- LosslessCut (to cut/trim video files without quality loss)
- Handbrake (to convert videos to more common/shareable format)
- Pinta (Paint like simple image editor)
- Darktable (Photoshop alternative)
- DigiKam (Photo Library manager)

#### Optional tasks (the script will ask you)
- Installation of all MS Office 365 fonts for max compatibility
- Configure Remote Desktop (RDP) credentials, because Manjaro Gnome supports RDP but it has no UI element yet to create credentials. RDP will not work without.
- Set your custom Firefox Sync server path
- Install NextCloud Desktop Client to have a 2-way sync to your webDAV server
- Install Spotify
- Isolate personal data by moving the personal folders into a BTRFS subvolume (userdata), allows for Timemachine-like snapshots and backups and easy system re-install. highly recommended on personal devices such as PCs and laptops.
- Configure swap and hibernation support for BTRFS, highly recommended on laptops.


# Quick Guide
_1. Download Manjaro, Gnome edition:_
https://manjaro.org/download/

_2. Create a USB stick with the image._ \
If on Gnome, go to Disks, select the usb stick, go to the 3-dot menu and select "restore from image". \
If not on Linux, use [Rufus](https://rufus.ie/en/) for Windows or [UNetbootin](https://unetbootin.github.io/) for Linux/MacOS/Windows.  

_3. Configure BIOS to not use legacy BIOS, enable boot from USB_
UEFI Bios still supports booting from legacy bios. This is the moment to disable legacy bios to ensure EFI boot is used. Changing this after installing an OS will prevent you from booting. 

_4. Boot into Live via USB_
- Google your motherboard, miniPC or laptop brand + Boot Menu Key to find out which key will allow you to select the boot device.
- Turn your system off, insert USB. Turn on the system and tap the correct F-key until you get a menu that allows you to select your USB stick (usually brand name). 
- When booted and not connected via ethernet: go to the top-right system icons, click, select "WiFi not connected > Select network and connect to WiFi. 

_5. Launch installer_
After the boot from live USB process has finished, you can use Manjaro already and see how it works or continue installing it permanently.
- First, make sure you have internet connection, the top right icons allow you to find your WiFi and connect if you are not linked via ethernet.
- During installation, select your preffered language (like British English en_GB) and locale (like nl_NL) and keyboard (Note for EU users that prefer US International keyboard layout, there is a "_**US - Euro on 5**_").  
- Make sure you select the correct drive to install on. You want to install on an NVME SSD.  
- Select **_"Erase disk"_** and **_"BTRFS"_** as file system. Also make sure to select **_no swap_**.


_When installation is finished, close the "Welcome" window and launch Terminal_ \
The Terminal icon ![Terminal-icon](https://user-images.githubusercontent.com/3430004/141796815-32347b36-f890-4e43-ba18-33a221c5bf70.png)  is shown on the dock at the bottom. 

_Copy paste the following, the script should not be run from the Downloads folder, so we use /tmp instead:_
```
cd /tmp && wget https://raw.githubusercontent.com/zilexa/manjaro-gnome-post-install/main/post-install.sh
```

Optionally, read the script and adjust to your needs.

_Now, run the script, note you will be asked to make choices (y/n) or enter information:_ 
```
bash post-install.sh
```

When done, close the window and reboot. Enjoy!
