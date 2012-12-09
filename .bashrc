## Non-Login Shell Script
## Shell script that runs on new sub-shell (e.g. by running ‘bash’ on the CLI), and on new xterm session.
## 
## 
## @note: Non-login shell script load order on Mac OS X is first ‘/etc/bashrc’, then second ‘~/.bashrc’.
## 	See also ‘~/.bash_profile’.
THIS_FILE_NAME=`basename "$BASH_SOURCE"`

# Uncomment to turn on debugging. @fixme: Should probably be doing some kind of or-equals and using 1/0 toggling instead uncommented/commented.
#DEBUG_SHELL_LOADING=1

[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME »"


[[ $DEBUG_SHELL_LOADING ]] && echo '	'"Add RVM to PATH for scripting"
PATH=$PATH:"$HOME/.rvm/bin"

[[ $DEBUG_SHELL_LOADING ]] && echo '	'"Homebrew PATHs"
PATH="/usr/local/sbin":$PATH
PATH="/usr/local/bin":$PATH

[[ $DEBUG_SHELL_LOADING ]] && echo '	'"User-level bins are the most important. No arguing with this; everyone has the right to fuck themselves."
PATH="$HOME/bin":$PATH

[[ $DEBUG_SHELL_LOADING ]] && echo '	'"Load git completion."
[[ -f ~/'bin/git-completion.sh' ]] &&
	source ~/'bin/git-completion.sh'


[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME «"
