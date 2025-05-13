Below is a line-by-line breakdown of the playbook:

yaml
Copy
Edit
---
- name: Install Nginx on Debian and Java 17 on other OSes
  hosts: webservers
  become: yes
  gather_facts: yes

  vars:
    nginx_pkg: nginx
    java_pkg: java-17-openjdk-devel

  tasks:
    - name: Install Nginx (Debian/Ubuntu)
      apt:
        name: "{{ nginx_pkg }}"
        state: present
        update_cache: yes
      when: ansible_os_family == "Debian"
      notify: Restart Nginx

    - name: Ensure Nginx is running (Debian/Ubuntu)
      service:
        name: "{{ nginx_pkg }}"
        state: started
        enabled: yes
      when: ansible_os_family == "Debian"

    - name: Install Java 17 (RHEL/CentOS and all non-Debian)
      yum:
        name: "{{ java_pkg }}"
        state: present
      when: ansible_os_family != "Debian"

  handlers:
    - name: Restart Nginx
      service:
        name: "{{ nginx_pkg }}"
        state: restarted
Play and Play-level directives
---
Begins a YAML document.

- name: Install Nginx on Debian and Java 17 on other OSes
A human-readable identifier for the play.

hosts: webservers
Targets all hosts in your inventory group webservers.

become: yes
Elevates privilege (e.g. uses sudo) for all tasks in this play.

gather_facts: yes
Instructs Ansible to collect system facts (OS, network, memory, etc.) before running tasks. These facts drive the when conditions below.

vars section
vars:
Defines play-scoped variables that can be overridden from the command line or inventory.

nginx_pkg: nginx
Sets nginx_pkg to the package name “nginx.” Used in both install and service tasks.

java_pkg: java-17-openjdk-devel
Sets java_pkg to the JDK package name on RHEL/CentOS.

tasks section
Each item under tasks: is a discrete action run on the target hosts, in order.

Install Nginx on Debian

yaml
Copy
Edit
- name: Install Nginx (Debian/Ubuntu)
  apt:
    name: "{{ nginx_pkg }}"
    state: present
    update_cache: yes
  when: ansible_os_family == "Debian"
  notify: Restart Nginx
name:: Descriptive label for the task.

apt:: Uses the APT module (Debian/Ubuntu package manager).

name: "{{ nginx_pkg }}" installs the “nginx” package.

state: present ensures it’s installed (but does not remove it if already present).

update_cache: yes runs apt-get update to refresh package indices first.

when:: Conditional — runs only if the collected fact ansible_os_family equals "Debian".

notify: Restart Nginx: If this task makes any change (e.g. newly installs or upgrades nginx), it will queue up the handler named “Restart Nginx” to run at the end of the play.

Ensure Nginx is running

yaml
Copy
Edit
- name: Ensure Nginx is running (Debian/Ubuntu)
  service:
    name: "{{ nginx_pkg }}"
    state: started
    enabled: yes
  when: ansible_os_family == "Debian"
service:: Manages system services via init, systemd, etc.

state: started makes sure nginx is up and running.

enabled: yes ensures nginx will automatically start on boot.

when:: Again only for Debian-family hosts.

Install Java 17 on non-Debian

yaml
Copy
Edit
- name: Install Java 17 (RHEL/CentOS and all non-Debian)
  yum:
    name: "{{ java_pkg }}"
    state: present
  when: ansible_os_family != "Debian"
yum:: Uses the YUM module (RHEL/CentOS package manager).

name: "{{ java_pkg }}" installs the OpenJDK 17 development package.

state: present ensures installation.

when:: Runs only if ansible_os_family is not Debian (i.e., RedHat, Fedora, etc.).

handlers section
Handlers are like special tasks triggered by notify. They execute once per play at the end, only if notified.

yaml
Copy
Edit
handlers:
  - name: Restart Nginx
    service:
      name: "{{ nginx_pkg }}"
      state: restarted
name: Restart Nginx
Matches the notify: directive above.

service:

state: restarted cleanly stops and starts the nginx service, picking up any new configuration or package changes.

Handlers help avoid unnecessary restarts—if nginx didn’t change, the handler never runs.

