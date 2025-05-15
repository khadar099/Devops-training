On the machine where you have installed Ansible. Goto folder of playbook and run the commands

ansible-playbook -h     shows options that can be used with this command
ansible-playbook --check playbook.yml  Execute a dry-run of the playbook, without running on hosts
ansible-playbook --syntax-check playbook.yml Check the syntax of the playbook without actually running it
ansible-playbook --list-tasks playbook.yml  List all tasks that will be executed by the playbook
ansible-playbook --list-host playbook.yml  List all hosts that will be targeted by the playbook.
