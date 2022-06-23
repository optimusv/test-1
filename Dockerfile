#
# Dockerfile
#
FROM gitpod/workspace-full
ENV PYTHONUNBUFFERED True

# Google Cloud SDK
ARG CLOUD_SDK_VERSION=383.0.1
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
RUN sudo apt-get update && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    sudo apt-get -y install apt-transport-https ca-certificates gnupg software-properties-common texlive latexmk texlive-latex-extra texlive-extra-utils libgbm1 && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    sudo apt-get update && sudo apt-get -y install vault google-cloud-sdk && sudo apt-get -y install google-cloud-sdk-app-engine-python && \
    sudo setcap cap_ipc_lock= $(readlink -f $(which vault)) && \
    curl -sL https://firebase.tools | sudo bash

# Additional installation for gitpod user
USER gitpod
RUN if ! grep -q "export PIP_USER=no" "$HOME/.bashrc"; then printf '%s\n' "export PIP_USER=no" >> "$HOME/.bashrc"; fi && \
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.12 && export PYENV_VERSION=3.7.12 && pyenv global 3.7.12
RUN npm --location=global install @mermaid-js/mermaid-cli
