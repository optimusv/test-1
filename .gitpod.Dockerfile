FROM axonasif/workspace-python:latest

# Test installing python package from dockerfile
RUN pip install cowsay && ls /home/gitpod/.pyenv/versions/3.8.13/lib/python3.8/site-packages/cowsay && sleep 30