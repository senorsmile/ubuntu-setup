#!/usr/bin/env bash

packages=(
	## to get easy_install
	python-setuptools 
	python-dev 
	gcc

	## to get this repo
	git

	## nice to have
	vim
)

sudo apt-get install "${packages[@]}"

pip install ansible
