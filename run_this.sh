#!/usr/bin/env bash
export ANSIBLE_BASE_RUN_MODE='playbook'
export ANSIBLE_PLAYBOOK='site.yml'

export ANSIBLE_CALLBACK_WHITELIST='timer,profile_tasks'


export USE_ANSIBLE_MODE=git
export USE_ANSIBLE_VER='v2.4.1.0-1'
#export USE_ANSIBLE_VER='v2.3.3.0-1'

source base_run.sh

./base_run.sh "${@}"

