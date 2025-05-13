Ad-hoc commands are one-off Ansible commands you run directly from the shell to perform simple tasks across one or many hosts—without writing a playbook. They’re great for quick checks, simple operations, and one-time fixes.

Key Characteristics
No playbook needed
You invoke them right on the command line using the ansible binary (not ansible-playbook).

Module-driven
You specify a module with -m (e.g. ping, shell, yum, copy) and any module arguments with -a.

Parallel execution
By default they run across all matching hosts in parallel (forks = 5 by default).

Temporary
They do not persist state beyond what the module itself does. If you need more complex logic or idempotency, you’d use a playbook instead.

Basic Syntax

ansible [pattern]           \
  -i [inventory]            \
  -u [remote_user]          \
  -m [module_name]          \
  -a "[module_args]"        \
  [--become] [--ask-become-pass]  \
  [other_options]
pattern
Which hosts or group(s) from your inventory to target (e.g. webservers, db1, all).

-i inventory
Path to your inventory file (defaults to /etc/ansible/hosts).

-u user
SSH user for remote connections.

-m module
The name of the module you want to run (e.g. ping, shell, yum, service).

-a "args"
Arguments passed to the module.

--become / -b
Elevate privileges (e.g. sudo) on the remote host.

--ask-become-pass / -K
Prompt for the sudo password.

Common Examples
1. Test connectivity

ansible all -m ping
Uses the ping module (which does an SSH handshake and runs a small Python snippet) to verify connectivity.

2. Run a shell command

ansible webservers -m shell -a "uptime" -u deploy --become
Runs uptime on every host in the webservers group as user deploy with sudo.

3. Install a package

ansible rhel_hosts -m yum -a "name=httpd state=present" -b
Installs (or ensures present) the httpd package via YUM on all hosts in rhel_hosts.

4. Copy a file

ansible db1 -m copy \
  -a "src=/local/backup.conf dest=/etc/myapp/backup.conf mode=0644" \
  -b
Copies a local file into place on host db1.

5. Manage a service
bash
Copy
Edit
ansible webservers -m service \
  -a "name=nginx state=restarted" \
  -b
Restarts the nginx service on all webservers.

When to Use Ad-Hoc vs. Playbooks
Ad-Hoc Commands	Playbooks
Quick one-off checks or fixes	Complex, repeatable, version-controlled tasks
No need for idempotency guarantees beyond module behavior	Full idempotency, complex workflows, roles
Rapid troubleshooting (e.g. ping, uptime)	Complete environment provisioning, deployments

Tips:

Combine patterns:


ansible "web1,db1" -m ping
ansible "webservers:!web3" -m shell -a "whoami"
Increase parallelism:


ansible all -m ping -f 20   # 20 forks instead of 5
Use --limit to narrow targets:


ansible webservers -m shell -a "df -h" --limit="web[02:05]"
