# Ansible Notes:

**Ansible**

Ansible is an **open-source IT engine** that automates **application deployment, cloud provisioning, intra-service orchestration,** and other IT tools. It is an **automation and orchestration tool** popular for the following reasons: 

1. Simple to Install.
2. Free and open source.
3. Lightweight and consistent.
4. OpenSSH security features make it very secure.


## 🧩 Ansible Architecture (Simple Explanation)

1. Control Node:

*    The main machine where you install Ansible.

*    You run commands or playbooks from here.

*    It controls all the managed nodes.

*    Any system with Python can be a control node, except Windows.

2. Managed Nodes:

*    These are the servers or devices you want to configure or manage.

*    Ansible connects to them using SSH (no need to install Ansible here).

3. Inventory:

* A file that lists all managed nodes (hosts).

* You can group servers (like web, DB, app) for easy management.

**Example:** /etc/ansible/hosts file.

4. Modules:

* Ready-made scripts or programs used to perform specific tasks.

**Example:** install a package, copy a file, create a user, etc.

* You can use them in ad-hoc commands or playbooks.

5. Tasks:

* Each action Ansible performs (like installing a package).

* Tasks are written inside playbooks and use modules to do the job.


### Ansible Playbook 

```
---
- hosts: all
  tasks:
    - name: Install the Apache web server
      apt:
        name: apache2
        state: present
```

* **Hosts:** Host in ansible play book defines no.of remote host that playbook will executed and performs the task specified.
* **Vars:** Vars in anisble playbook defines the variables which can be used through out the playbook.
* **Tasks:** This is the section where we are going tot mention the type of task to be executed in the host servers


### Ansible Tower

- Ansible tower provides web-based user interface to manage the playbooks which are used to configuring the software's. Ansible tower will acts as an medium to manage and execute the task like playbooks and adding the new host to the ansible.

1. **Security:** Ansible tower provides the Role-based access control (RBAC) which can be used to manage the access of users and can assign permissions to the playbooks and other resources. You can make sure the which user should which type permissions to access the resources in the ansible tower.
2. **Job scheduling:** Ansible tower provide the option for scheduling the jobs to execute which will execute automatically in the interval's of time This can help to automate tasks such as daily backups or weekly system updates.


### Ansible Modules

Ansible modules are scripts which can be reused and performs the tasks which have mentioned init in the host servers on behalf of you. Instead of performing the installation of softwares manually on each server ansible will automate the process. The tasks which you want to perform can be done on multiple OS also as mentioned following.

- Linux
- Windows
- macOS

#### Types of Ansible Modules

Following are the some modules which are frequently used in the ansible.

1. System modules
2. Application modules
3. Cloud modules
4. Networking modules
5. Command modules

