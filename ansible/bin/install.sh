#!/bin/bash
# enable for debug
# set -xe
set -e

if [ "${PWD##*/}" == "bin" ]; then
  REPOSITORY_ROOT=${PWD%%/bin}
else
  REPOSITORY_ROOT=${PWD}
fi

printf "\e[33mInstall pyenv and pyenv-virtualenv:\n\e[0m"

# install pyenv to support multiple python versions
brew install pyenv

# install pyenv virtaulenv to support mutliple ansible version on same python version
brew install pyenv-virtualenv

# add initialisation of pyenv to .zshrc
if [ -f ~/.zshrc ] &&  ! cat ~/.zshrc | grep -Eq "pyenv" ; then
    cat >> ~/.zshrc <<'EOL'

# initalize pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
EOL
fi

# initalize pyenv manually for the scrip
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# intall python versions if not already installed
printf "\e[33mInstall python versions:\n\e[0m"
[ -d "$(pyenv root)/versions/3.10.2" ] || pyenv install 3.10.2

pyenv global system

# install Ansible 5.3.0 environment
printf "\e[33mInstall Ansible 5.3.0 virtualenv:\n\e[0m"
[ -d "$(pyenv root)/versions/3.10.2/envs/ansible530" ] || pyenv virtualenv 3.10.2 ansible530
pyenv shell ansible530
pip install -r ${REPOSITORY_ROOT}/venv/ansible530/requirements.txt

# use Ansible 5.3.0 env per default
pyenv shell ansible530