#!/bin/bash

git clone --bare --branch main --depth=1 --no-tags https://github.com/yogendra/cloud-ci.git $HOME/.cloud-ci
git --git-dir=$HOME/.cloud-ci/ --work-tree=$HOME checkout --force


grep "source \$HOME/.bashrc.cloud-ci" ~/.bashrc >> /dev/null || echo "[[ -f \$HOME/.bashrc.cloud-ci ]] &&  source \$HOME/.bashrc.cloud-ci" >> $HOME/.bashrc

sudo usermod -g docker $USER
