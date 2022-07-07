FROM axonasif/python-wstest:latest

# Test installing python package from dockerfile
RUN pip install --user cowsay
