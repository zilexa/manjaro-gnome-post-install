Download Manjaro, Gnome edition: 
https://manjaro.org/download/

_Create a USB stick with the image._
If on Gnome, go to Disks, select the usb stick, go to the 3-dot menu and select "restore from image".
If not on Linux, use [Rufus](https://rufus.ie/en/) for Windows or [UNetbootin](https://unetbootin.github.io/) for Linux/MacOS/Windows.  

_Boot via USB_
Figure out the F-key that will show the boot menu of your system. Select the USB stick.

_Erase disk during install_
Make sure you select "Erase disk" and "BTRFS" as file system. Also make sure to select no swap. 

_When installation is finished, close the "Welcome" window and launch Terminal, the icon looks like this:_
![Terminal-icon](https://user-images.githubusercontent.com/3430004/141796815-32347b36-f890-4e43-ba18-33a221c5bf70.png)

_Copy paste the following, this will change path to your Downloads folder and download the post-install script:_ 
```
cd Downloads && wget https://raw.githubusercontent.com/zilexa/Ubuntu-Budgie-Post-Install-Script/master/postinstall.sh
```

Optionally, read the script and adjust to your needs. 

_Now, run the script, note you will be asked to make choices (y/n) or enter information:_ 
```
bash postinstall.sh
```
