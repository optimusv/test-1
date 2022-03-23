FROM axonasif/gitpod-workspace-full-vnc:latest

RUN cd /tmp \
    && curl -Lo discord.deb "https://discord.com/api/download?platform=linux" -o discord.deb \
    && sudo install-packages ./discord.deb

RUN ws_discord_dir="/workspace/.discord" \
    && home_discord_dir="$HOME/.config/discord" \
    && printf '%s\n' "if test ! -e $ws_discord_dir; then" \
                        "   mkdir -p $ws_discord_dir && ln -srf $ws_discord_dir $home_discord_dir" \
                     "fi" >> $HOME/.bashrc