alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Shortcuts
alias dp='cd ~/Dropbox'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias rp='cd ~/dev/repos'

# SSH into my Uberspace
alias uber='ssh phl@markab.uberspace.de'

# cd into exercise directory and show directories
alias prog='cd ~/Dropbox/mi/15-ss/prog/uebungen; ls -1p'
alias ray='cd ~/Dropbox/mi/15-ss/prog/uebungen/08/raytracer; ls -1p'
alias pvs='cd ~/Dropbox/mi/15-ws/pvs/uebungen; ls -1p'
alias ad='cd ~/Dropbox/mi/15-ws/ad/uebungen; ls -1p'
alias se='cd ~/Dropbox/mi/15-ws/se/uebungen; ls -1p'
alias db='cd ~/Dropbox/mi/15-ws/db/uebungen; ls -1p'

# Replace one character in all file and directory names with another one
# Usage: replace_all _ -
replace_all() {
    if [ "$#" -ne 2 ] || [ ${#1} -gt 1 ] || [ ${#2} -gt 1 ]; then
        echo "Usage:   ${FUNCNAME[0]} CHAR_TO_REPLACE NEW_CHAR" >&2
        echo "Example: ${FUNCNAME[0]} _ -" >&2
        return 1
    fi

    old_char=$1
    new_char=$2

    for filename in *"${old_char}"*; do
        mv -- "$filename" "${filename//${old_char}/${new_char}}"
    done
}

# Opening files with Sublime Text
alias o=subl

alias python2="/c/Python27/python"
alias python3="$HOME/AppData/Local/Programs/Python/Python35-32/python"
