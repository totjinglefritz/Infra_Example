This directory contains Ansible data for management of software and
settings on the hosts in inventory.yml.

1. Add new hosts to inventory.yml

2.  Update the following roles as required:
roles/apache2
roles/firewall

3. Run the appropriate playbook. e.g.

`ansible-playbook -i inventory.yml --limit <host> playbooks/play_provision_bastion.yml`
-or-
`ansible-playbook -i inventory.yml --limit <host> playbooks/play_provision_webhost.yml`

To run only a specific role in the play book supply the tag to the command. e.g.

`ansible-playbook -i inventory.yml --limit <host> --tags firewall playbooks/play_provision_bastion.yml`
-or-
`ansible-playbook -i inventory.yml --limit <host> --tags firewall playbooks/play_provision_webhost.yml`
