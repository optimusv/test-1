if test ! -x "$PYENV_COMMAND_PATH"; then {
    GP_PYENV_MIRROR="/workspace/.pyenv_mirror";
    for bin in "${GP_PYENV_MIRROR}/site/"*"/bin/$PYENV_COMMAND"; do {
        PYENV_COMMAND_PATH="$bin";
    } done
} fi