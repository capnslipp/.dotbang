THIS_FILE_NAME=`basename "$BASH_SOURCE"`
[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME »"


# @from: https://gist.github.com/905583
function tabc {
	NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
	osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$NAME\""
}

function path {
	echo $PATH
}

function pathl {
	echo $PATH | tr ':' "\n"
}


[[ $DEBUG_SHELL_LOADING ]] && echo "$THIS_FILE_NAME «"
