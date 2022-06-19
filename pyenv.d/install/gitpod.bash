GP_PYENV_MIRROR="/workspace/.pyenv_mirror";
ORIG_PYENV_ROOT="$PYENV_ROOT";
PYENV_ROOT="$GP_PYENV_MIRROR/fakeroot"; # Temporarily hijack PYENV_ROOT

after_install "ln -s $PYENV_ROOT/versions/$DEFINITION $ORIG_PYENV_ROOT/versions"; # Symlink to the original PYENV_ROOT under $HOME