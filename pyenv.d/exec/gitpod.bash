GP_PYENV_MIRROR="/workspace/.pyenv_mirror";
export PYTHONPATH="${GP_PYENV_MIRROR}/site/${PYENV_VERSION}";
export PYTHONUSERBASE="$GP_PYENV_MIRROR/user"; # `pip install --user` will use this path.

# Do not set PIP_TARGET when `--user` arg is passed to `pip install` to avoid
# ERROR: Can not combine '--user' and '--target'
if [[ ! "$*" =~ ^pip\ install.*--user ]]; then {
    export PIP_TARGET="$PYTHONPATH" PIP_UPGRADE=true;
} fi

# TODO: Add $PYTHONUSERBASE to system PATH