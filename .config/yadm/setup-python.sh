#!/usr/bin/sh
#
pip install --user pipx
pipx install pdm
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
