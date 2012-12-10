THIS_FILE_NAME=`basename "$BASH_SOURCE"`
[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME »"


alias diff_verbose='diff -s' # report identical files
alias xz='xz -v' # be vebose
alias please='sudo' # politeness never hurts
alias e='exec' # because this comes in handy combined with open, ssh, or other one-offs
alias fsrm='rm' # to avoid conflicts with ‘git rm’ when using git-sh

alias gito='git --no-pager'
alias gitoc='git --no-pager -c color.ui=always'
alias gitp='git --paginate'


[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME «"
