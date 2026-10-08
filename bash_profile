# ~/.bash_profile

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

function __prv_git_ps1()
{
    declare -F __git_ps1 > /dev/null && __git_ps1
}

export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
PROMPT_COMMAND=__prompt_command

__prompt_command() {
	local EXIT="$?"                # This needs to be first
	#PS1=""
	local RCol='\[\e[0m\]'
	local Red='\[\e[0;31m\]'
	local BRed='\[\e[1;31m\]'
	local Gre='\[\e[0;32m\]'
	local BGre='\[\e[1;32m\]'
	local Yel='\[\e[0;33m\]'
	local BYel='\[\e[1;33m\]'
	local BBlu='\[\e[1;34m\]'
	local Pur='\[\e[0;35m\]'
	local BGrey='\[\e[1;37m\]'

	PS1="\n${BGre}\u${RCol}@${BRed}\h ${Yel}\w${RCol}"
	if [ ${EXIT} != 0 ]; then
		PS1+="${Red} (${EXIT})${RCol}"
	fi
	PS1+="$(__prv_git_ps1 " (%s)")\n$ "
}

export EDITOR=vim

umask 022
