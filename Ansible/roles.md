**Ansible role** that installs **Nginx** depending on the **OS family** (supports both Debian-based and RedHat-based systems like Ubuntu, Debian, CentOS, RHEL, etc.).

---

✅ 1. Create the Role Structure

Use the ansible-galaxy command to scaffold the role:

ansible-galaxy init nginx_install

This will create a folder called nginx_install with the proper subdirectories like tasks/, defaults/, meta/, etc.

✅ 2. Edit the Role

Replace the contents of nginx_install/tasks/main.yml with:

---
- name: Install Nginx on Debian/Ubuntu
  apt:
    name: nginx
    state: present
    update_cache: yes
  when: ansible_os_family == "Debian"

- name: Install Nginx on RHEL/CentOS
  yum:
    name: nginx
    state: present
  when: ansible_os_family == "RedHat"




### 📁 Directory structure (for the role named `nginx_install`)
```
roles/
└── nginx_install/
    ├── defaults/
    │   └── main.yml
    ├── tasks/
    │   └── main.yml
    └── meta/
        └── main.yml
```

---

### 📄 `roles/nginx_install/tasks/main.yml`

```yaml
---
- name: Install Nginx on Debian/Ubuntu
  apt:
    name: nginx
    state: present
    update_cache: yes
  when: ansible_os_family == "Debian"

- name: Install Nginx on RHEL/CentOS
  yum:
    name: nginx
    state: present
  when: ansible_os_family == "RedHat"
```

---

### 📄 `roles/nginx_install/defaults/main.yml`

```yaml
---
# Default variables (can be overridden)
nginx_version: latest
```

---

### 📄 `roles/nginx_install/meta/main.yml`

```yaml
---
galaxy_info:
  role_name: nginx_install
  author: your_name
  description: Ansible role to install Nginx based on OS
  license: MIT
  min_ansible_version: 2.9
  platforms:
    - name: Debian
    - name: Ubuntu
    - name: EL
      versions:
        - 7
        - 8
        - 9
```

---

### ✅ Example playbook using the role

```yaml
---
- name: Install Nginx
  hosts: all
  become: true

  roles:
    - nginx_install
```

---

Let me know if you want to add things like starting the service, enabling it, custom config, or support for other OSes!
