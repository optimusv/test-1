GP_PYENV_MIRROR="/workspace/.pyenv_mirror";
FAKEROOT="$GP_PYENV_MIRROR/fakeroot";

function fake_cleanup() { # function read()
    # builtin read "$@";
    # if [[ "${REPLY,,}" =~ ^y ]]; then {
        MIRROR_VER_DIR="$FAKEROOT/versions/${VERSION_NAME}";
        ORIG_VER_DIR="$PYENV_ROOT/versions/$VERSION_NAME";
        if test -e "$MIRROR_VER_DIR"; then {
            rm -r "$MIRROR_VER_DIR";
            # rm "$ORIG_VER_DIR" && mkdir "$ORIG_VER_DIR";
        } fi
    # } fi
}
after_uninstall "fake_cleanup";