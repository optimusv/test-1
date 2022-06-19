GP_PYENV_MIRROR="/workspace/.pyenv";
gitpod_shims=();
for file in "$GP_PYENV_MIRROR"/versions/*/lib/python*/site-packages/bin/*; do {
    gitpod_shims+=("${file##*/}");
} done
make_shims "${gitpod_shims[@]}"