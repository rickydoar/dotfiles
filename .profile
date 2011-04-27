# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export MP_ENV_TYPE=tim_dev
export GITHUB_ENV_TYPE=server
set -o vi
alias ml='mysql -u analytics -p'
alias nginxstart='sudo /etc/init.d/nginx start'
alias nginxstop='sudo /etc/init.d/nginx stop'
alias apachestart='sudo /etc/init.d/apache2 start'
alias apachestop='sudo /etc/init.d/apache2 stop'
alias apachereload='sudo /etc/init.d/apache2 reload'
alias rmdirf='rmdir --ignore-fail-on-non-empty'
alias mg='mysql -u github -p'
alias devdb='mysql -u analytics_dev -h mixpanel.com -p'

alias rmpyc='find . -name "*.pyc" | xargs rm -f'

greppy () {
	# greppy "print" billing/ 
	grep -rin --include=*.py $1 $2
}

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
