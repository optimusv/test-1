FROM gitpod/base

RUN sudo install -d -m755 -o $(id -u) -g $(id -g) /nix \
    && curl -L https://nixos.org/nix/install | sh