# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source ~/git-completion.bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# vi mode ftw
# set -o vi

# Preserve the physical directory structure when following symlinks
set -o physical

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Git should prompt for credentials:
export GIT_TERMINAL_PROMPT=1

# For git info in terminal prompt. See: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source ~/.git-prompt.sh # Not needed, seems to be pre-installed
GIT_PS1_SHOWDIRTYSTATE=true # unstaged changes *, staged changed +
GIT_PS1_SHOWSTASHSTATE=true # stashed changes $
GIT_PS1_SHOWUNTRACKEDFILES=true # untracked files %
GIT_PS1_SHOWUPSTREAM="git auto" # behind origin <, ahead of origin >, diverged from origin <>, no difference = (could also use verbose & name options for more info)
GIT_PS1_DESCRIBE_STYLE="branch" # when detached head, shows commit relative to newer tag or branch (e.g. master~4)
GIT_PS1_HIDE_IF_PWD_IGNORED=true # do nothing if current directory ignored by git

if [ "$color_prompt" = yes ]; then
    GIT_PS1_SHOWCOLORHINTS=true # dirty state and untracked file indicators are color-coded
    if [[ ${EUID} == 0 ]] ; then
        PRE_PROMPT_COMMAND='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W'
    else
        PRE_PROMPT_COMMAND='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w'
    fi
    POST_PROMPT_COMMAND='\n\$\[\033[00m\] '
else
    PRE_PROMPT_COMMAND='${debian_chroot:+($debian_chroot)}\u@\h \w'
    POST_PROMPT_COMMAND='\n\$ '
fi
unset color_prompt force_color_prompt

ERROR_CODE_COMMAND='\[\033[01;31m\]$(RESULT=$?; if (( RESULT != 0 )); then echo " ERROR: $RESULT"; fi)\[\033[01;34m\]'
POST_PROMPT_COMMAND="$ERROR_CODE_COMMAND$POST_PROMPT_COMMAND"

PROMPT_COMMAND="__git_ps1 '$PRE_PROMPT_COMMAND' '$POST_PROMPT_COMMAND'"
unset PRE_PROMPT_COMMAND POST_PROMPT_COMMAND

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GO111MODULE=off
