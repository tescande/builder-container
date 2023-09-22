# ~/.bash_profile

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

function __prv_git_ps1()
{
    declare -F __git_ps1 > /dev/null && __git_ps1
}

export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export PS1='\n\e[1;32m\u\e[0m@\e[41m\e[1;37m\h\e[0m \e[0;33m\w\e[0m$(__prv_git_ps1 " (%s)")\n$ '

export EDITOR=vim

umask 022

export PATH="/usr/local/cargo/bin:${PATH}"
