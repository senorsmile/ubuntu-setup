#!/usr/bin/env bash
export ANSIBLE_BASE_RUN_MODE='playbook'
export ANSIBLE_PLAYBOOK='site.yml'

source base_run.sh

./base_run.sh "${@}"

