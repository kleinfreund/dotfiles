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

The `ntfsfix` command can be used to make it mountable.

sudo ntfsfix /dev/sda4

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

## Start the week on Monday when using English locale

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
