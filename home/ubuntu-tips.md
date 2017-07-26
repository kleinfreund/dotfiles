# Ubuntu Setup Tips

Setting up a newly installed operating system can become frustrating quickly. Especially when it was forced upon ourselves (e.g. the hard drive died again).

This is a collection of tips that are part of my backup strategy. Here, I try to document what things I configure with my operating system, what software I install, etc.

Beware, as this is opinionated. This setup works for me. It might not work for you. Maybe I’m doing things inefficiently, maybe I make things unnecessarily complicated. I’m open for suggestions.





## General Ubuntu Settings

When something was configured via `gsettings set`, this can be reverted back to its original state via `gsettings reset`.

### Disable touchpad when mouse is connected

```
gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled-on-external-mouse
```

### Disable locking when closing laptop lid

```
sudo sed -i 's/IgnoreLid=false/IgnoreLid=true/g' /etc/UPower/UPower.conf
service upower restart
```

### Disable tab/application switch on scrolling

I don’t like the Ubuntu behavior of switching applications/tabs when scrolling in some specific areas. Sadly, this can’t be disabled for *Google Chrome* and *Gnome Terminal*.

**Sublime Text: User Preferences**:

```
"mouse_wheel_switches_tabs": false
```

### Show date in top bar

```
gsettings set com.canonical.indicator.datetime show-date true
```

### Disable Screenshot Sound

```
sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture.oga /usr/share/sounds/freedesktop/stereo/screen-capture-disabled.oga
```

### Disable wallpaper dots on login screen

```
sudo xhost +SI:localuser:lightdm
sudo su lightdm -s /bin/bash
gsettings set com.canonical.unity-greeter draw-grid false
```

## Keybindings

### Ctrl-Alt-Up/Down

```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
```

## Disable mouse wheel click to minimize window

```
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'
```





## Software

### Google Chrome

- As per answer to [Ask Ubuntu: How to install Google Chrome](http://askubuntu.com/a/510186)

```
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```

### `git`

```
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```

### Sublime Text, `subl` (code editor)

- [Website](https://www.sublimetext.com)

```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text
```

### `gnome-tweak-tool`

```
sudo apt update
sudo apt install gnome-tweak-tool
```

#### Disable Caps Lock

- Open “Tweak Tool”
- Select category “Typing”
- Select “Caps Lock key behavior”
- Select “Caps Lock is disabled”

#### Enable selecting via Ctrl+Pos1/End

- Open “Tweak Tool”
- Select category “Typing”
- Select “Miscellaneous compatibility options”
- Select “Numlock on: digits, shift switches to arrow keys, Numlock off: always arrow keys (as in MS Windows)”

### CompizConfig Settings Manager

```
sudo apt update
sudo apt install compizconfig-settings-manager
```

#### Application Switcher

- Next window (All windows): `<Alt>Tab`
- Prev window (All windows): `<Shift><Alt>Tab`

#### Grid

- Map all “Put … Key” actions to numpad
- Maximize Key: `<Super>Up`
- Restore: `<Super>Down`
- Left Maximize: `<Super>Left`
- Right Maximize: `<Super>Right`

### `ag` (command line search, faster than `ack`)

- [GitHub](https://github.com/ggreer/the_silver_searcher)

```
sudo apt update
sudo apt install silversearcher-ag
ag "thing to search for" /path/to/search/in
```

### `vtop` (command line activity monitor)

- [GitHub](https://github.com/MrRio/vtop)

```
npm install -g vtop
vtop
```

### `mascii`, `telnet mapscii`

- [GitHub](https://github.com/rastapasta/mapscii)
- Usage via telnet: `telnet mapscii.me`

```
npm install -g mapscii
mapscii
```

### Zsh & Oh My Zsh

- [Oh My Zsh](http://ohmyz.sh/)

```
sudo apt update
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```





## Dracula Theme

### Sublime Text

- Open “Package Control: Install Package”
- Install “Dracula Color Scheme”

### ZSH

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
subl ~/.zshrc
```

Add the plugin like this:

```
plugins=([plugins...] zsh-syntax-highlighting)
```

### Gnome Terminal Colors

The [Dracula Theme](https://draculatheme.com/) is available for a variety of applications. Using it in Sublime Text is as easy as installing the package.

Applying it to Gnome Terminal is done by executing an install as follows:

```
git clone git@github.com:dracula/gnome-terminal.git dracula-gnome-terminal
cd dracula-gnome-terminal
./install.sh -s Dracula -p default
```

Alternatively, the [terminal.sexy](https://terminal.sexy) can be used to convert the macOS Terminal theme to a Gnome Terminal theme.

- Download `Dracula.terminal` from https://github.com/dracula/terminal.app (that’s for the macOS’ Terminal.app)
- Open [terminal.sexy](https://terminal.sexy)
  - Import > Format: Terminal.app
  - Paste the contents of `Dracula.terminal` into the text box
  - Click “Import”
  - Export > Format: Gnome Terminal
  - Click “Export”
  - Download the file
  - Add the colors via adding a new profile by running the downloaded file as a script:

```
mv terminal.sexy.txt terminal.sexy.sh
chmod +x terminal.sexy.sh
./terminal.sexy.sh
```

  - Open Terminal
  - Preferences > Profiles > Profile used when launching a new terminal:
    terminal.sexy





## Miscellaneous

### Mount Windows partition:

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

```
sudo ntfsfix /dev/sda4
```

Alternatively, the hibernation file can be deleted:

```
sudo mount -t "ntfs" -o remove_hiberfile "/dev/sda4" "/media/phil/Boot"
```

### Simple static HTTP Server

```
python3 -m http.server 8000
```

```
server() {
  local port="${1:-8080}"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
  xdg-open "http://localhost:${port}/"
}
```
