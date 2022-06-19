GP_PYENV_MIRROR="/workspace/.pyenv";
export PYTHONPATH="${GP_PYENV_MIRROR}/versions/${PYENV_VERSION}/lib/python${PYENV_VERSION%.*}/site-packages";
export PIP_TARGET="$PYTHONPATH";