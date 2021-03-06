# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Define some colors first:
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
purple='\[\e[0;35m\]'
PURPLE='\[\e[1;35m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
grey='\[\e[0;37m\]'
NC='\[\e[0m\]'              # No Color
BOLD='\[\e[1m\]'

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# export MANPAGER="/bin/sh -c \"col -bx | vim -c 'set ft=man' -\""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


## Get git branch
function current_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/' 
}

PS1="${debian_chroot:+($debian_chroot)}${green}\u@\h${NC}:${cyan}\w${purple}\$(current_git_branch)${NC} \$ "

export PS1="\[\e]0;\u@\h: \w\a\]$PS1" # simple title


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

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

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# don't match .pyc files when tab-completing in bash
export FIGNORE=$FIGNORE:.pyc

keychain ~/.ssh/id_rsa
. ~/.keychain/$HOSTNAME-sh

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/env/bin" ] ; then
    PATH="$HOME/env/bin:$PATH"
fi

if [ -d "/usr/local/go" ] ; then
    PATH="/usr/local/go/bin:$PATH"
fi

export MP_ENV_TYPE=tim
export MP_SUB_ENV_TYPE=django
export GITHUB_ENV_TYPE=server
set -o vi

alias devdb='mysql -u analytics_dev -p'
alias rmpyc='find . -name "*.pyc" | xargs rm -f'
alias pflakes='pyflakes . | grep -v backend | grep -v utils | grep "undefined name "'
alias greppy='grep -rin --include=*.py'
alias ll='ls -alH -I *.pyc'

mptype () {
	if [ -n "$1" ]
	then
		export MP_ENV_TYPE=$1
		echo "Set MP_ENV_TYPE to $MP_ENV_TYPE"
	else
		echo "MP_ENV_TYPE is $MP_ENV_TYPE"
	fi
}

dtype () {
	if [ -n "$1" ]
	then
		export DOCTYL_ENV_TYPE=$1
		echo "Set DOCTYL_ENV_TYPE to $DOCTYL_ENV_TYPE"
	else
		echo "DOCTYL_ENV_TYPE is $DOCTYL_ENV_TYPE"
	fi
}

mxdb () {
	# Usage: 
	# "./mxdb" will get you app server
	# "./mxdb slave1" will get you slave1
	# ./mxdb HOST USER
	HOST='10.36.213.4'
	USER='analytics'

	if [ -n "$1" ]
	then
		HOST=$1
		USER='metrics'
	fi

	if [ -n "$2" ]
	then
		USER=$2
	fi

	echo "host: $HOST"
	echo "user: $USER"
	mysql -u $USER -h $HOST -P 3306 -p 
}


# Autocomplete git branches
_complete_git() {
    if [ -d .git ]; then
        branches=`git branch -a | cut -c 3-`
        tags=`git tag`
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "${branches} ${tags}" -- ${cur}) )
    fi
}
complete -F _complete_git checkout

_fab()
{
    local cur
    COMPREPLY=()
    # Variable to hold the current word
    cur="${COMP_WORDS[COMP_CWORD]}"

    # Build a list of the available tasks using the command 'fab -l'
    local tags=$(fab -l 2>/dev/null | grep "^    " | awk '{print $1;}')

    # Generate possible matches and store them in the
    # array variable COMPREPLY
    COMPREPLY=($(compgen -W "${tags}" $cur))
}

# Assign the auto-completion function _fab for our command fab.
complete -F _fab fab


SSH_ENV="$HOME/.ssh/environment"
function start_agent {
    ssh-agent > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}
if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
fi
if [ -n "$SSH_AGENT_PID" ]; then
    ps ${SSH_AGENT_PID} > /dev/null
    if [ $? -ne 0 ]; then
        start_agent
    fi
else
    start_agent
fi


# start virtualenv
source $HOME/env/bin/activate
stty -ixon -ixoff

export GCC=gcc-4.3
export GOPATH=$GOPATH:~/dev/go/
