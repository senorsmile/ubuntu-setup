#!/usr/bin/env bash
source base_run.sh

export ANSIBLE_BASE_RUN_MODE='playbook'
export ANSIBLE_PLAYBOOK='site.yml'
./base_run.sh "${@}"

