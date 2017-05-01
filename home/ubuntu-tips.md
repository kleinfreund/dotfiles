## Mount Windows partition:

When mounting the Windows partition, an error like this might appear:

```
$ sudo mount -t "ntfs" -o remove_hiberfile "/dev/sda4" "/media/phil/Boot"
The disk contains an unclean file system (0, 0).
Metadata kept in Windows cache, refused to mount.
Failed to mount '/dev/sda4': Operation not permitted
The NTFS partition is in an unsafe state. Please resume and shutdown
Windows fully (no hibernation or fast restarting), or mount the volume
read-only with the 'ro' mount option.
```

The `ntfsfix` command can be used to make it mountable if Windows is not in fact hibernated.

sudo ntfsfix /dev/sda4

Alternative, the hibernation file can be deleted:

sudo mount -t "ntfs" -o remove_hiberfile "/dev/sda4" "/media/phil/Boot"

## Keybindings

### Ctrl-Alt-Up/Down

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"

**Undo**

gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-up
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-down

## Disable mouse wheel click to minimize window

gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'

**Undo**

gsettings reset org.gnome.desktop.wm.preferences action-middle-click-titlebar

## Scrolling switches tabs

### Google Chrome

Not known.

### Gnome Terminal

Not known.

### Sublime Text

**Disable:**

"mouse_wheel_switches_tabs": false

**Enable:**

"mouse_wheel_switches_tabs": true

## Show date in top bar

gsettings set com.canonical.indicator.datetime show-date true

**Undo**

gsettings reset com.canonical.indicator.datetime show-date true

## Disable Screenshot Sound

sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture.oga /usr/share/sounds/freedesktop/stereo/screen-capture-disabled‌​.oga

**Undo**

sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture-disabled‌​.oga /usr/share/sounds/freedesktop/stereo/screen-capture.oga

## Start the week on Monday when using English locale (fix this!)

```
cp /usr/share/i18n/locales/en_US ~/en_US_modified
mkdir ~/.locales
sed -i 's/first_weekday\t1/first_weekday\t2/g' ~/en_US_modified
localedef -c -i ~/en_US_modified -f UTF-8 ~/.locales/en_US.utf8
# Backup locale
sudo cp -r /usr/lib/locale/en_US.utf8 /usr/lib/locale/en_US.utf8_ORIGINAL
# Copy new locale
sudo cp -r ~/.locales/en_US.utf8 /usr/lib/locale
```

## Install latest Google Chrome

As per: http://askubuntu.com/a/510186

```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## Disable touchpad when mouse is connected

```
sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get install touchpad-indicator
```

After that, start the application and open preferences:

- Activity: Check “Disable touchpad when mouse plugged”
- General options: Check “Autostart”
- General options: Check “Start hidden”
- Touchpad configuration: Check “Natural scrolling”

## Disable Caps Lock & enable selecting via Ctrl+Pos1/End

```
sudo apt install gnome-tweak-tool
```

Start “Tweak Tool”:

- Typing:
  - Miscellaneous compatibility options:
    - Choose “Numlock on: digits, shift switches to arrow keys, Numlock off: always arrow keys (as in MS Windows)”
  - Caps Lock key behavior:
    - Choose “Caps Lock is disabled”
