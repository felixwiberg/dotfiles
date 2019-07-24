#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias comp='javac *.java'
alias cd..='cd ..'
alias termconf='vim ~/.config/xfce4/terminal/terminalrc'
alias i3conf='vim ~/.i3/config'
alias i3blocksconf='sudo vim /etc/i3blocks.conf'
alias patchrir='pip install ~/rirnet --user '
alias reboob='reboot'
alias rpi='ssh felix@192.168.0.222'
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

PS1='[\u@\h \W]\$ '
