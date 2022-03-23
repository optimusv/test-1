FROM gitpod/workspace-full:latest 

ENV PATH=/usr/games:$PATH

RUN sudo install-packages cowsay # Just FYI, `install-packages` is an shell-script wrapper for `apt-get` command