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
   `git remote add «their username» git://github.com/«their username»/.config.git`
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
