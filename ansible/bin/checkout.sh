#!/bin/bash

# set variables depending on working directory
if [ "${PWD##*/}" == "bin" ]; then
  REPOSITORY_ROOT=${PWD%%/bin}
else
  REPOSITORY_ROOT=${PWD}
fi

ANSIBLE_VAULT_FILE=${REPOSITORY_ROOT}/vaultpassword
ANSIBLE_LOCAL_CFG_FILE=${REPOSITORY_ROOT}/ansible.cfg
ANSIBLE_AWX_CFG_FILE=${REPOSITORY_ROOT}/inventories/ansible.cfg

# create "vaultpassword" if not exist
if [ ! -f $ANSIBLE_VAULT_FILE ]; then
  printf "\e[33mVault Password (See Passbolt): \e[0m"
  read -s VAULTPASSWORD
  echo -e "$VAULTPASSWORD" > $ANSIBLE_VAULT_FILE
else
  printf "\e[33mAnsible Password file exists and will not be created.\n\e[0m"
fi

# create ansible.cfg if not exist
if [ ! -f $ANSIBLE_LOCAL_CFG_FILE ]; then
  cp $ANSIBLE_AWX_CFG_FILE $ANSIBLE_LOCAL_CFG_FILE
else
  printf "\e[33mAnsible configfile $ANSIBLE_LOCAL_CFG_FILE exists.\n\e[0m"
fi

# configure vault_password_file in local ansible.cfg
sed -E -i '' 's/^#+(vault_password_file =).*$/\1 vaultpassword/g' "$ANSIBLE_LOCAL_CFG_FILE"

# copy pre-commit hook file to .git/hooks
printf "\e[33mInstalling pre-commit hook ...\n\e[0m"
cp ${REPOSITORY_ROOT}/bin/git/pre-commit ${REPOSITORY_ROOT}/.git/hooks/pre-commit
chmod 0755 ${REPOSITORY_ROOT}/.git/hooks/pre-commit
