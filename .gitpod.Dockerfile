FROM axonasif/workspace-python:dev

# Test installing python package from dockerfile
RUN pip install --user cowsay
