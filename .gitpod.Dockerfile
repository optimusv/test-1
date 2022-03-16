FROM gitpod/workspace-base:latest

RUN printf 'alias %s\n' 'ls=ls -la' \
                        'print=echo' \
                        'g=git' >> $HOME/.bash_aliases
                         