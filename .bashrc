#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias sudo='sudo '
alias pacup='pacman -Syu'
alias aurup='pacaur -yu'
alias ls='ls --color=auto'
PS1='\[$(tput setaf 2)\]\A\[$(tput setaf 1)\] \W \[$(tput sgr0)\]> '

export TERM=xterm
