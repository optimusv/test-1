FROM axonasif/gitpod-workspace-full-vnc:latest

RUN cd /tmp \
    && curl -Lo discord.deb "https://discord.com/api/download?platform=linux" -o discord.deb \
    && sudo install-packages ./discord.deb

RUN