#!/usr/bin/env bash

packages=(
	## to get easy_install
	software-properties-common 
	python-software-properties

	python-setuptools 
	python-dev 
	gcc

	## to get this repo
	git

	## nice to have
	vim
)

pip_packages=(
	pipenv
)

sudo apt-get install "${packages[@]}"
sudo easy_install pip
sudo pip install "${pip_packages[@]}"
