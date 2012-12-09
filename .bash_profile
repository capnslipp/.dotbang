## Login Shell Script
## Shell script that runs on new Terminal window/tab, and on SSH connection (both per session).
## 
## @note: Login shell script load order on Mac OS X is first ‘/etc/profile’, then second ‘~/.bash_profile’, or if that doesn't exist, ‘~/.bash_login’, or if that doesn't exist, ‘~/.profile’.
## 	Therefore, it's completely unnecessary to put code into ‘~/.bash_login’ or ‘~/.profile’ file; just put the contents here.
## 	However, some scripts auto-add code to ‘~/.bash_login’ and ‘~/.profile’, so they're included if they exist.
## 	
## 	Note: ‘~/.bashrc’ is a different story.
THIS_FILE_NAME=`basename "$BASH_SOURCE"`

# Uncomment to turn on debugging. @fixme: Should probably be doing some kind of or-equals and using 1/0 toggling instead uncommented/commented.
#DEBUG_SHELL_LOADING=1

[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME »"


[[ -f ~/'.bash_login' ]] &&
	source ~/'.bash_login'
[[ -f ~/'.profile' ]] &&
	source ~/'.profile'


[[ -f ~/'.bashrc' ]] &&
	source ~/'.bashrc'


[[ -f ~/'.bash_colors' ]] &&
	source ~/'.bash_colors'


[[ $DEBUG_SHELL_LOADING ]] && echo '	'"Load git prompt."
if [ -f ~/'bin/git-prompt.sh' ]; then
	source ~/'bin/git-prompt.sh'
	PS1_GIT="\$(__git_ps1 '${BGDefault} ${BGBlack}${FGWhite}[git: ${FGBrightBlue}%s${FGWhite}]')"
fi

export PS1="${FGBrightRed}\u${FGDarkGray}@${FGLightGray}\h${FGDarkGray}:${FGBlack}${BGYellow}\w${PS1_GIT}${BGDefault}${FGDarkGray}\$${FGDefault} "
export PS2="${BFGRed}>${FGDefault} "


[[ -f ~/'.bash_functions' ]] &&
	source ~/'.bash_functions'
[[ -f ~/'.bash_aliases' ]] &&
	source ~/'.bash_aliases'


export CLICOLOR='true'
export LSCOLORS='gxfxcxdxbxegedabagacad'

export EDITOR='mate -w'


[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME «"
