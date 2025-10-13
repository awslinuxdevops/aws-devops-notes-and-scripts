# Ansible Playbooks:
```
---
- name: Install
  hosts: all
  become: yes
  tasks:
    - name: Install apache httpd
      ansible.builtin.apt:
        name: apache2
        state: present
        update_cache: yes
    - name: Start and enable httpd service


```



```
---
- name: Install and configure
  hosts: webservers
  become: yes

  tasks:
  - name: Install Apache (httpd)
  	yum:
  	  name: httpd
  	  stage: present
  - name: Install Apache (httpd)
  	service:
  	  name: httpd
  	  stage: present

```
```
# Install Nginx
---
- name: Install Nginx
  hosts: webserver
  become: yes

  tasks: 
  - name: Install Nginx
    yum: 
      name: nginx
      state: present
```

========================================================

---
- name: Install and configure
  hosts: webserver
  become: yes
  tasks:
  - name: Check if Apache2 is Install
    ansible_builtin.shell: dpkg -l | grep -qw apache2
    register: apache2_installed
    ignore_errors: true

  - name: Install Apache2 if not installed
    ansible_builtin.package:
      name: apache2
      state: present
    when: not apache2_installed.rc !=0
  - name: Ensure Apache2 is running and enabled
    ansible.builtin.services:
      name: apache2
      state: started
      enabled: yes
============================================================
