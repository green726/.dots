#
# ~/.bashrc
#

# [[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

export VISUAL=nvim
export EDITOR="$VISUAL"


# if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
#     export MOZ_ENABLE_WAYLAND=1
# fi



# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen
_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1
ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}



alias dotfiles='git -C /home/green726/.dots --work-tree=/'
dot(){
  if [[ "$#" -eq 0 ]]; then
    (cd /
    for i in $(dotfiles ls-files); do
      echo -n "$(dotfiles -c color.status=always status $i -s | sed "s#$i##")"
      echo -e "¬/$i¬\e[0;33m$(dotfiles -c color.ui=always log -1 --format="%s" -- $i)\e[0m"
    done
    ) | column -t --separator=¬ -T2
  else
    dotfiles $*
  fi
}

alias zotgit='git -C ~/Zotero/storage/'
alias zotpull='git -C ~/.logseq/ pull'

zotPushFn() {
    git -C ~/Zotero/storage/ add .
    git -C ~/Zotero/storage/ commit -m "laptop"
    git -C ~/Zotero/storage/ push
}

alias zotpush=zotPushFn





alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
[[ "$(whoami)" = "root" ]] && return
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'
## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc
_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.
    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi
    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}
#------------------------------------------------------------
## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##
# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################
export TERM=kitty
alias ls='lsd -a'
alias batinfo='bat /sys/class/power_supply/BAT0/capacity'
alias awesomecon='nvim-qt ~/.config/awesome'
alias mirror-update='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=43200 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist'

alias ny-vpn='sudo openvpn /etc/openvpn/usny2-ovpn-tcp.ovpn'

# alias cls='clear'
alias nvimcon='nvim-qt ~/.config/nvim'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'

alias wakeDesktop='wol -p 7 -i 71.167.215.220 0C:9D:92:79:60:FD && wol 0C:9D:92:79:60:FD'

# alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.11.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool'

alias bat-perc='cat /sys/class/power_supply/BAT0/capacity'

alias submod='git submodule update --recursive --remote'
alias lilvim='nvim --clean'
alias logpull='git -C ~/.logseq/ pull'

logpushFn() {
    git -C ~/.logseq/ add .
    git -C ~/.logseq/ commit -m "laptop"
    git -C ~/.logseq/ push
}

alias logpush=logpushFn

ugrep() {
    last=${@:$#} # last parameter 
    other=${*%${!#}} # all parameters except the last
    unbuffer $other | grep "$last"
}


eval "$(starship init bash)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/green726/coding/bash-scripts/
export NNN_OPENER=/home/green726/coding/bash-scripts/nnn-handlr-open.sh
export NNN_OPTS="c"

# export PATH=$PATH:/home/green726/coding/robotics/pathplanner/build/linux/x64/debug/bundle

export PATH=$PATH:/home/green726/.config/nvim/scripts/linux-stuff
export PATH=$PATH:/home/green726/.local/bin
export PATH=$PATH:~/coding/SWO/Language/bin/Debug/net6.0/linux-x64/

export PATH=$PATH:~/.ghcup/bin/
export PATH=$PATH:~/.ghcup/ghc/9.2.4/bin/
export PATH=$PATH:~/wsudo-dir/

export PATH=$PATH:/usr/lib/jvm/java-17-openjdk/bin
# export WLR_RENDERER_ALLOW_SOFTWARE=1
export HYPRLAND_LOG_WLR=1

# set bg
# swaybg -i ~/Downloads/ship-bridge-bg.png

# [[ ${BLE_VERSION-} ]] && ble-attach

# opam configuration
test -r /home/green726/.opam/opam-init/init.sh && . /home/green726/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
