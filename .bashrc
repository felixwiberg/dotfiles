#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cd..='cd ..'
alias matlab='/usr/local/MATLAB/R2020b/bin/matlab & disown'
PS1='[\u@\h \W]\$ '
