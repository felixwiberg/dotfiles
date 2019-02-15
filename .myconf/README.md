use:

    git init --bare $HOME/.myconf
    alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
    config config status.showUntrackedFiles no

where the ~/.myconf directory is a git bare repository. Then any file within the home folder can be versioned with normal commands like:

    config status
    config add .vimrc
    config commit -m "Add vimrc"
    config add .config/redshift.conf
    config commit -m "Add redshift config"
    config push

And so one…

No extra tooling, no symlinks, files are tracked on a version control system, you can use different branches for different computers, you can replicate you configuration easily on new installation.

////////////////
To complete the description of the workflow (for others), you can replicate your home directory on a new machine using the following command:

   git clone --separate-git-dir=~/.myconf /path/to/repo ~

For posterity, note that this will fail if your home directory isn't empty. To get around that, clone the repo's working directory into a temporary directory first and then delete that directory,

    git clone --separate-git-dir=$HOME/.myconf /path/to/repo $HOME/myconf-tmp
    cp ~/myconf-tmp/.gitmodules ~  # If you use Git submodules
    rm -r ~/myconf-tmp/
    alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

and then proceed as before.
//////////////////
