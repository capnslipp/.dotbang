# *nix Dotfiles

This is a collection of the dotfiles I use on Mac OS X, Linux (primarily Debian and Ubuntu), and occasionally Cygwin on Windows.


## Repo Organization

The setup of this repository is a little different than how Git repos normally go; there is no `master` branch, and most branches are their own line of code, with little-to-no branching or merging.

Instead, branches are named after the GitHub user the dotfiles setup belongs to. I'm a big fan of Git's ability to folder up branches, so the main branch for each user's repo is `«username»/main`. There may be additional branches from that user (e.g. `«username»/linux` or `«username»/cygwin-hacks`).


## Clone Your Own

If you would like to follow this system, just follow these simple steps:

1. Fork or clone someone else's `.config` project. It doesn't really matter who; you might as well choose someone you admire.
2. Create a new `«your username»/main` branch with the command:  
   `git checkout --orphan «your username»/main`  
   _This will ensure that your branch is completely independent, not branched off of anyone else's._
3. Commit some files to form your first commit.
   You could include a bunch of what you're already using, or to get their current version of this readme, just:  
   `git checkout «someone you admire»/main -- README.md`
4. Make sure there is not `master` branch, and if there is, remove or rename it.  
   _Leaving a master branch doesn't make sense with this setup; everyone's stuff is different. I find it's easier to just remove it and avoid the confusion._
5. Share to GitHub.  
   _(Sharing is caring.)_

Then, down the road, if you see someone else's changes that you want to pull into your repo, you can:

1. Make sure you have their repo set up as a remote. If not, run:  
   `git remote add «their username» git://github.com/«their username»/.config.git` _(notice the read-only URL; this is important for safety, see below)_
2. Also, if you haven't already, fetch their changes _(and the changes of anybody they admire enough to have grabbed their branch(es))_ into your repo:  
   `git fetch «their username»`
3. Cherry-pick the commit(s) or checkout the file(s) you like:
    1. To swipe commits:  
       `git cherry-pick «sha for their commit»`  
       _then optionally_ touch up the file(s) to your liking and `git commit --amend` with commit message changes.
    2. To swipe files:  
       `git checkout «someone you admire»/«‘main’ or some other sub-branch» -- «path(s) to file(s) you'd like»`  
       then stage and commit.
4. Then push that tish!  
   _(Hoarding is douchbaggery.)_


## Local-Only?

If you want to have local-machine only changes stored in this git repo (doing otherwise will probably be a huge pain, since private keys, passwords, e-mails, and other settings in config files are not unusual), **you should be careful**.

It's probably best to git clone your GitHub-hosted `.config` into a intermediate repository:

~~~ bash
git clone --bare git@github.com:«your username»/.config.git ~/.config_intermediate.git
~~~

And clone that repository into a secondary repository that you'll use the files directly out of (I symlink to these files):

~~~ bash
git clone -o 'intermediate' ~/.config_pristine.git ~/.config
cd ~/.config
find . -depth 1 ! -name 'README.md' -and ! -name '.git' -and ! -name '.gitignore' \
	-exec mv ~/'{}' ~/.config/'' \
	-exec ln -s ~/.config/'{}' ~/'{}' \;
~~~

Last, back in the intermediate repository, set up a git update hook to prevent the local branch(es) from ever being pushed in by dropping this script in as `.git/hooks/update`:

~~~ bash
#!/bin/sh
#
# Hook script that blocks creationg of branches with the form '*/local/*', 'local/*', '*/local', or just 'local'.
# Called by "git receive-pack" with arguments: refname sha1-old sha1-new

# --- Command line
refname="$1"
oldrev="$2"
newrev="$3"

# --- Safety check
if [ -z "$GIT_DIR" ]; then
	echo "Don't run this script from the command line." >&2
	echo " (if you want, you could supply GIT_DIR then run" >&2
	echo "  $0 <ref> <oldrev> <newrev>)" >&2
	exit 1
fi

if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
	echo "Usage: $0 <ref> <oldrev> <newrev>" >&2
	exit 1
fi

# --- Check types
# if $newrev is 0000...0000, it's a commit to delete a ref.
zero="0000000000000000000000000000000000000000"
if [ "$newrev" = "$zero" ]; then
	newrev_type=delete
else
	newrev_type=$(git cat-file -t $newrev)
fi

case "$refname","$newrev_type" in
	refs/heads/*/local/*,commit|refs/heads/local/*,commit|refs/heads/*/local,commit|refs/heads/local,commit)
		# 'local' branch
		if [ "$oldrev" = "$zero" ]; then
			echo "*** Creation of branch '$refname' denied;\n    Branches with 'local' for part or all of the branch name are not allowed in this repository." >&2
			exit 1
		fi
		;;
esac

# --- Finished
exit 0
~~~

This way, if you ever accidentally `git push --all` from your `.config` repo, you'll only push to the intermediate repo (not to the wild wild web), and it'll reject any `*local*` branches (with a nice error message). The downside is you do have to cd into your intermediate repo in order to push to GitHub.

If you want to make it easy to keep your local-only changes on top of any new `«your username»/main` changes, you can set up your .git/config like this:

~~~ ini
[branch "«your username»/local/«local-machine name»"]
	remote = .
	merge = «your username»/main
	rebase = true
~~~

Now just `git pull` when on the local-machine branch to pull from your main branch. And if you encounter rebase conflicts when pulling, a `git checkout --theirs «conflicting file name»` will ensure you keep your local variant _(of course, you can revert to the main branch's variant with `--ours` instead of `--theirs`, or you may actually want to hand-merge the changes)_.
