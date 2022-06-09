# Manjaro Gnome - The Out of The Box Experience _further improved_

Manjaro Gnome already has a very good Out-Of-The-Box Experience. 
This script will make it more intuitive, practical and easy to use by selecting sane preferences, replacing a few common applications and enabling features that one might expect to be enabled and configured by default. 

- [Features](https://github.com/zilexa/manjaro-gnome-post-install#quick-guide)
- [Full Guide how to install Manjaro Gnome (usb stick creation -> install options)](https://github.com/zilexa/manjaro-gnome-post-install#quick-guide)
- [How to run the script](https://github.com/zilexa/manjaro-gnome-post-install#how-to-get-and-run-the-script)

*** 
&nbsp;

# What does the script do? 

## Remove unnecessary apps
- Geary, Gnome Theme for Firefox, X11-only gnome extensions that throw errors in log because Wayland (instead of X11) is the Manjaro default display manager. (If you really need to switch to X11, for example due to nVidia GPU, you can install the X11 Gestures extension easily.) 

## Configure updates - for system, applications, extensions
- Check biweekly for updates instead of every 6hrs.
- No permanent update icon in systray, only when there are icons.
- Download updates in background. Do not perform updates without user confirmation.
- Enable Arch User Repository, allowing for much more apps and tools in the App Store.
- Include AUR when updating. 
- Rate the latency of all available mirrors and select the fastest to download updates.
- Update the system now. 
- Cleanup old packages. 

## _Install best-in-class applications_ - for everyday use and configure them for instant-readiness 
- New Gnome Extensions Manager - allowing you to browse through extensions, enable/disable them and auto-update user-installed extensions!
- Bleachbit - to cleanup the system.
- Wireguard tools - easily connect to VPN networks with automatic network configation.
- Gnome RDP instead of VNC - for builtin (Gnome) Desktop Sharing.
  - Script allows you to configure credentials for Desktop Sharing.
- Gnome Connections - to connect to other systems via RDP.
- LibreOffice Fresh - additional office suite, next to default OnlyOffice <- is more simplistic but has better compatibility with MS Office documents. 
  - Allows you to easily install a LibreOffice language pack.
  - Allows you to easily install *ALL* Office365 fonts.
  - Script will configure LibreOffice to use MS Office365-like icons and interface and sets autosave to 2min. 
- OnlyOffice - set dark theme and open each document in its own window.
- BingWallpaper extension - periodically changes background with images of flora and fauna or landscapes via Bing.
  - Configured to refresh wallpaper every 5 days and store in $HOME/Pictures/Wallpapers  .
- Strawberry - audioplayer with folder-view support.
- Audacity - to edit audio files or record audio.
- LosslessCut - to cut/trim video files without quality loss and without having to re-encode or transcode. 
- Handbrake - to convert videos to more common/shareable format.
- Pinta - MS Paint-like simple image editor.
- GiMP - more complex image editor, like photoshop or Paint.NET (for RAW photos install DarkTable or RawTherapee). 
- DigiKam - Photo management or photo library manager. 
  - Prepares a folder for its database by disabling BTRFS features for $HOME/Pictures/digikam-db
- Firefox - system-wide defaults configured: 
  - set your own, self-hosted Firefox Sync server (optional) 
  - remove Mozilla bookmarks, enable a clean bookmark bar. 
  - add Sync button too bookmark bar to easily sent tabs to your other devices or open history of all devices)
  - Add history button to bookmark bar to quickly restore closed tabs or sessions
  - Include the toolbar layout when syncing via Firefox Sync.
  - Enable uBlock Origin, CastBlock and Bypass Paywalls extensions. Enable Nord Dark theme.
  - Use the system default file manager (Nemo) when opening folders of downloads, instead of Nautilus (fixing a bug). 

## _Replaced apps_ - for more intuitive, easier to use, more functional apps: 
- Text Editor - Pluma instead of gedit, while maintaining the beautiful icon and name. 
  - More readable colors, also for root user. 
  - Display numbers, closing brackets, file overview, also for root user. 
- File Manager - Nemo instead of Nautilus. 
  - list view instead of large icon view, also for root user.
  - Easy rename of files, also for root user.
  - Reload button, also for root user. 

## _User Experience configuration_ - clean, easy, maximum screen space
- A nice vertical panel with your systray, favourite apps and "start" menu with more pinned apps, maximizing your screen space for actual applications and desktop use (compared to a horizontal panel or doc
- Touchpad gestures extended: 4 finger system gestures (instead of default 3) to allow applications to bind 2 and 3 finger gestures. See Extensions Manager > Touchpad gestures extended for more options. 
- Touchpad scroll direction set to mouse scroll direction (= disable natural scrolling)
- Hotcorners improved: instead of 1 hotcorner, every corner of the screen can be configured. Top left triggers App menu, bottom left triggers Overview, bottom-right Desktop. See Extensions Manager > Hotcorners. 
- Several Panel, Arc Menu, Desktop settings and File Manager settings to make it much more intuitive
- Week numbers in Calendar
- Show battery percentage in taskbar
- Enable auto night light and configured
- Hide Home folder on desktop
- The Power-off button will hibernate the system
- Closing the lid will suspend-then-hibernate the system
- Enable the most modern form of standby: suspend-then-hibernate! When system goes into standby, it will wake up after 2 hours to go into hibernation and turn-off completely, saving battery life. This allows for very quick standby and (within 2hrs) wakeup. 
- Configure filesystem and kernel for hibernation to swapfile on BTRFS subvolume. 
- Enable auto-cleanup
- Automatic timezone
- Instant screenshots of an area (`PrintScr`button) or fullscreen (`Shift+PrintScr`) instead of Gnome 42 new interactive screenshot tool that cannot take instant screenshots. You can still trigger the tool via `Ctrl+Shift+PrintScr`. 
- Keyboard shortcut for Terminal (`Shift+Alt+T`)
- Fix file associations for images and documents - it is very difficult for the end-user to restore the file associations of default apps for image viewing (gThumb) and documents (OnlyOffice) after installing an image editor or other office suite, (even reinstalling gThumb or OnlyOffice has no effect!). The script re-associates gThumb and OnlyOffice for each filetype they support. 

## Simplify folder structure - easy for cloud backup/syncing or local backups
- move Templates to Documents folder, remove Public folder and rename Videos to Media
- Replace /Downloads and /.cache with root subvolumes, this way, snapshots/backups of your /home folder stay clean, without temporary files. 
-  Create a root subvolume @users mounted to `/mnt/users/` and move Desktop/Documents/Pictures/Media into a subfolder (`/mnt/users/username`), symlink the personal folders into /home/username/ - this way, you can simply sync 1 folder with your favourite cloud provider and easily create seperate, isolated snapshots/backups of your system, your configuration and your personal data.

###Optional tasks (the script will ask you)
- Installation of all MS Office 365 fonts for max compatibility.
- Install NextCloud Desktop Client to have a 2-way sync to your webDAV server.
- Configure swap and hibernation support for BTRFS, highly recommended on laptops.

*** 
&nbsp;

# Quick Guide
### _1. Download Manjaro, Gnome edition:_
https://manjaro.org/download/

## _2. Create a USB stick with the image._ 
If on Gnome, go to Disks, select the usb stick, go to the 3-dot menu and select "restore from image". \
If not on Linux, use [Rufus](https://rufus.ie/en/) for Windows or [UNetbootin](https://unetbootin.github.io/) for Linux/MacOS/Windows.  

## _3. Configure BIOS to not use legacy BIOS, enable boot from USB_
UEFI Bios still supports booting from legacy bios. This is the moment to disable legacy bios to ensure EFI boot is used. Changing this after installing an OS will prevent you from booting. 

## _4. Boot into Live via USB_
- Google your motherboard, miniPC or laptop brand + Boot Menu Key to find out which key will allow you to select the boot device.
- Turn your system off, insert USB. Turn on the system and tap the correct F-key until you get a menu that allows you to select your USB stick (usually brand name). 
- When booted and not connected via ethernet: go to the top-right system icons, click, select "WiFi not connected > Select network and connect to WiFi. 

## _5. Launch installer_
After the boot from live USB process has finished, you can use Manjaro already and see how it works or continue installing it permanently.
- First, make sure you have internet connection, the top right icons allow you to find your WiFi and connect if you are not linked via ethernet.
- During installation, select your preffered language (like British English en_GB) and locale (like nl_NL) and keyboard (Note for EU users that prefer US International keyboard layout, there is a "_**US - Euro on 5**_").  
- Make sure you select the correct drive to install on. You want to install on an NVME SSD.  
- Select **_"Erase disk"_** and **_"BTRFS"_** as file system. Also make sure to select **_no swap_**.

*** 
&nbsp;

## How to get and run the script
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
