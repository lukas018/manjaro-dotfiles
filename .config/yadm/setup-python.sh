#!/usr/bin/sh
#
pip install --user pipx
# I don't use pdm that much, but if PEP 582 gets accepted I might start to
pipx install pdm
# Install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
