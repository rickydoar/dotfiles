[ -z "$PS1" ] && return

PS1='\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
export CLICOLOR=1
export LS_COLORS=DxGxcxdxCxegedabagacad

echo "In bashrc"

keychain ~/.ssh/id_rsa
. ~/.keychain/$HOSTNAME-sh

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export MP_ENV_TYPE=tim_dev
export GITHUB_ENV_TYPE=server
set -o vi
alias devdb='mysql -u analytics_dev -h mixpanel.com -p'

alias rmpyc='find . -name "*.pyc" | xargs rm -f'

mptype () {
	if [ -n "$1" ]
	then
		export MP_ENV_TYPE=$1
		echo "Set MP_ENV_TYPE to $MP_ENV_TYPE"
	else
		echo "MP_ENV_TYPE is $MP_ENV_TYPE"
	fi
}

mxdb () {
	# Usage: 
	# "./mxdb" will get you app server
	# "./mxdb slave1" will get you slave1
	# ./mxdb HOST USER
	HOST='mixpanel.com'
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
_complete_git() {
    if [ -d .git ]; then
        branches=`git branch -a | cut -c 3-`
        tags=`git tag`
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "${branches} ${tags}" -- ${cur}) )
    fi
}

complete -F _complete_git checkout
