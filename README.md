# ansible-playground

Flaws with existing server setup

Operating System - Ubuntu 12.04 LTS end of life April 2017, some packages out of support already:

```
ubuntu@ip-172-31-44-99:~$ ubuntu-support-status --show-unsupported
Support status summary of 'ip-172-31-44-99':

You have 7 packages (1.6%) supported until October 2013 (18m)
You have 3 packages (0.7%) supported until August 2018 (18m)
You have 414 packages (96.7%) supported until April 2017 (5y)

You have 0 packages (0.0%) that can not/no-longer be downloaded
You have 4 packages (0.9%) that are unsupported

No longer downloadable:

Unsupported:
chkconfig nodejs python-pip rlwrap
```

No SSL configured - potentially handled upstream.
NTP not configured.
Apache not installed via package manager - manually uploaded, meaning won't be updated by OS patching

Apache init script broken:
```
root@ip-172-31-44-99:/home/ubuntu# service httpd status
/etc/init.d/httpd: 94: /etc/init.d/httpd: lynx: not found
```
default commented config left in - makes actual configuration hard to read
Apache running as root a problem?
Allowing indexes and options BAD??
no separate /var partition
Apache logging to /opt
Apache binary not in PATH
Apache running on old version
777 perms on Apache directory
Apache only set to start on rc2, no shutdown

Security scan revealed high threat level 'Login Cross Site Request Forgery'
Timezone PST - could cause confusion on investigating issues, Ansible task to ensure this is set correctly.
Nodejs port available globally - assume server may not be directly available on the internet in reality.

Apache compiled with security issue
```
root@ip-172-31-44-99:~# /opt/apache/bin/httpd -V
...
 -D BIG_SECURITY_HOLE
...
```

Nodejs unsupported version v0.10.37 installed via package manager but not running
Node 5.0.0 installed and running - from well known but unsupported Chris Lea PPA added.

Due to the above issues with Apache I decided to replace with a supported version of Apache2 installed via the package manager.

● Produce some code to automate the build of a server
Code contained within 'ansible' directory of this repo

● Provide clear instructions for running your code
Assumes Docker installed
```
# docker build -t ansible .
# docker run -it ansible bash
```
Within container run Ansible Playbook
```
# ansible-playbook /etc/ansible/site.yml
```
● State clearly any assumptions made (either in code comments or as a separate README
file)
● Use source control

● You may use any configuration management frameworks/tools as you see fit
Ansible selected
● The code must be idempotent
The changes that materially affect the server are all idempotent, in order to test whether the uploaded vhost config is valid each time, currently that uploads and then removes the files each time, therefore showing as 4 'changed' items in the Playbook output. With more time I would compare the existing config with the file from source control before uploading anything to ensure Ansible only reflected changes when they had actually gone ahead.
● The code must check for and report errors
Tested each element and does report errors correctly when the new Apache vhost config is invalid.
● The code should meet the requirements and be able to support future extension
Future changes to the config elements placed under Ansible control should be straight forward (changing ports, modules or vhost)
● Consider how you might test that your changes haven’t affected functionality
Content is checked to ensure the word 'University' is present.
