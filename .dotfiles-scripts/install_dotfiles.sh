#
# Install script when managing your dotfiles using the git bare method
# modified version of a script by Nicola Paolucci (see article at https://www.atlassian.com/git/tutorials/dotfiles)
#

# Defining some variables
bare_repo_dir=.dotfiles
backup_dir=.config-backup

# Cloning repo
git clone --bare https://github.com/Isak-Evaldsson/dotfiles $HOME/$bare_repo_dir

# Temporary alias 
function config {
   /usr/bin/git --git-dir=$HOME/$bare_repo_dir/ --work-tree=$HOME $@
}

# Tries to checkout, if unsuccesfull backup older configs
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p $backup_dir
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $backup_dir/{}
fi;

# Force backed-up old config files to be overwritten
config checkout -f

# Avoids nightmare when using config status
config config status.showUntrackedFiles no