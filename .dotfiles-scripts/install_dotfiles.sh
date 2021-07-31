# Cloning repo
git clone --bare https://github.com/Isak-Evaldsson/dotfiles $HOME/.dotfiles

# Temporary alias 
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# Tries to checkout, if unsuccesfull backup older configs
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p .config-backup
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

# Force backed-up old config files to be overwritten
config checkout -f

# Avoids nightmare when using config status
config config status.showUntrackedFiles no
