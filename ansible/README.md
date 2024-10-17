# Ansible

- [Checkout](#checkout)
  - [Install Ansible](#install-ansible)
  - [Prepare Repo](#prepare-repo)
- [Structure](#structure)
- [Development](#development)
- [Documentation](#documentation)
- [Testing](#testing)
- [Deployment](#deployment)
- [Useful Commands](#useful-commands)
  - [Run a Playbook](#run-a-playbook)
  - [List all variables of a Host](#list-all-variables-of-a-host)
  - [Run a single command on a Host or a Group](#run-a-single-command-on-a-host-or-a-group)
  - [Run linter manually for a palybook](#run-linter-manually-for-a-palybook)

## Checkout

### Install Ansible

To keep the setup Ansible the same for all DevOps engineers there is a install script to seupt Ansible on MacOS. 

Details on the install script can be found in [install.md](docs/install.md).

The following script installs Ansible using pyenv and pyenv-virtualenv.

```
./bin/install.sh
```

### Prepare Repo

This script is used to setup the Ansible config, the vault files and pre commit hooks. 

```
./bin/checkout.sh
```

After this script everything should be setup to run playbooks to deploy and configure infrastructure. 

## Structure

This project contains everything to configure the infrastructure of karriere.at and jobs.at. To keep it simple we decided to setup our configmanagemnt in a mono repo. All code is checked in here and we do not version our roles for now. 

* **bin** - shell scripts and git stuff to get the repo working
* **docs** - general documnetation for this repo
* **inventories** - all ansible inventories for our different environments
  * **ansible.cfg**- Ansible config for AWX
* **playbook** - the actual stuff which is applied on server groups
* **roles** - resuable chunks of code for services we configure and deploy
* **tasks** - regular tasks or oneshot tasks for maintenance (tasks which not actually configure our infrastructure)
* **venv** - virtual environments to allow use of multiple ansible/python versions
* **ansible.cfg** - Ansible config for local development

## Development

Describe your development workflow
**Follow Guidelines [Ansible Guidelines](addurl)**

## Documentation

## Testing

## Deployment

## Useful Commands

Most of the roles also have some example commands in ther READMEs. 

### Run a Playbook

```
ansible-playbook -i inventories/<myinventory> playbook/<playbook> [--limit <mygroup|myhosts>] -e [<myvaribles>]
```

### List all variables of a Host
```
ansible <FQDN> -i <INVENTORYFILE> -m setup
``` 

### Run a single command on a Host or a Group
```
ansible -m command -i <inventory> <servers> -b -a "<arguments>"
```

e.g. restart Nginx on all cache servers
```
ansible -m command -i inventories/inventory_local.yml cache -b -a "systemctl restart nginx"
```

### Run linter manually for a palybook
```
ansible-lint playbook/caching.yml
```

