# ~/.bashrc: executed by bash(1) for non-login shells.
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

[ -f '/etc/bash_completion.d/git-prompt.sh' ] && \
  GIT_PROMPT_SH='/etc/bash_completion.d/git-prompt.sh' || \
  GIT_PROMPT_SH='/usr/lib/git-core/git-sh-prompt'

if [ "$color_prompt" = yes ]; then
    if [ "$UID" = 0 ]; then
        PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n#$nc "
    elif [ -f "$GIT_PROMPT_SH" ]; then
        source "$GIT_PROMPT_SH"
        # https://dev.to/bunnyladame/display-git-branch-info-in-bash-prompts-3nf5
        GIT_PS1_SHOWDIRTYSTATE='y'
        GIT_PS1_SHOWSTASHSTATE='y'
        GIT_PS1_SHOWUNTRACKEDFILES='y'
        GIT_PS1_DESCRIBE_STYLE='contains'
        GIT_PS1_SHOWUPSTREAM='auto'
        CURR_BRANCH="\$(__git_ps1)"

        PS1="$CYAN\u$nc@$yellow\H$nc:$BLUE\w$PURPLE${CURR_BRANCH}$nc\\n\$$nc "
     else
        PS1="$CYAN\u$nc@$yellow\H$nc:$BLUE\w$nc\\n\$$nc "
     fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# QTerminal still doesn't provide login shells
# https://github.com/lxqt/qterminal/issues/103
if [ -f "$HOME/.profile" ]; then
	DID_BASHRC=true
	. "$HOME/.profile"
	DID_BASHRC=
fi
