**1. Linux File System Structure**

In Linux, everything is organized into a tree-like structure, starting at / (root directory).

Here are some important folders you’ll use often:

Directory	Purpose	Example Use

/etc	Stores configuration files for the system and applications	Apache config → /etc/httpd/conf/httpd.conf

/var	Variable data files (logs, caches, temporary files)	Logs → /var/log/syslog

/home	Personal directories for each user	/home/khadar/ stores that user’s files

/bin	Essential system commands	Commands like ls, cp, mv are here

/usr	User programs and libraries	Application files like /usr/bin/python3

Example:

cd /var/log       # Go to system logs

ls -l             # See log files like syslog, messages

cat syslog        # View log content

**2. Navigation Commands**

Command	What it Does	Example

pwd	Show current directory path	pwd → /home/khadar

ls	List files/folders	ls -l → Detailed list with permissions

cd	Change directory	cd /etc → Go to /etc folder


Example:

pwd            # /home/khadar

cd /etc

pwd            # /etc

ls -l          # See config files

**3. File Management Commands**

Command	What it Does	Example

cp	Copy files	cp file1.txt file2.txt

mv	Move or rename files	mv file.txt /home/khadar/

rm	Delete files	rm oldfile.txt

cat	Display file content	cat config.txt

nano	Edit file in terminal	nano notes.txt


Example:

cp index.html backup_index.html   # Copy

mv backup_index.html /tmp         # Move

cat /etc/hostname                 # View system hostname

nano /etc/motd                    # Edit welcome message


**4. User & Permissions**

Linux controls who can read, write, or execute a file.

Permissions are shown like:

-rwxr-xr--

r = read, w = write, x = execute

First set = owner, second = group, third = others

Change permissions:

chmod 755 script.sh  # Owner: rwx, Group: r-x, Others: r-x

Change file owner:

chown ubuntu:ubuntu file.txt  # Set owner and group


**5. Package Managers**

These install and manage software.

Debian/Ubuntu → apt

sudo apt update

sudo apt install nginx

CentOS/Red Hat → yum (or dnf for newer versions)


sudo yum install httpd

sudo systemctl start httpd

**Example Scenario:**

You launch an AWS EC2 Ubuntu instance and want to host a webpage:

sudo apt update

sudo apt install apache2 -y

sudo systemctl start apache2

Now your server is running Apache and can serve websites.



📁** 1. File and Directory Commands**

Command	Description	Example

pwd	Print Working Directory (shows your current location)	pwd → /home/khadar/

ls	List files in a directory	ls -l → long format list

cd	Change directory	cd /etc → move to /etc folder

mkdir	Make a new directory	mkdir myfolder

rmdir	Remove an empty directory	rmdir myfolder

rm	Remove files or directories	rm file.txt, rm -r folder/

touch	Create a new empty file	touch hello.txt

cp	Copy files or directories	cp a.txt b.txt, cp -r dir1 dir2

mv	Move or rename files	mv file.txt /tmp/ or mv a.txt b.txt

cat	Display content of a file	cat notes.txt

more / less	View large files one screen at a time	less log.txt

find	Find files/folders	find / -name "*.log"

🔐 2. Permissions & Ownership

Command	Description	Example

chmod	Change file permissions	chmod 755 script.sh

chown	Change file owner	chown user:user file.txt

ls -l	View permissions and ownership	shows -rwxr-xr-- and owners

**👥 3. User Management**

Command	Description	Example

whoami	Show current user	whoami → khadar

adduser	Add a new user	sudo adduser john

passwd	Change password	passwd john

usermod	Modify user (e.g., add to group)	usermod -aG sudo john

deluser	Delete user	deluser john

groups	List groups of a user	groups john

💻 4. Process & System Monitoring

Command	Description	Example

ps	Show running processes	ps aux

top	Real-time process monitor	press q to quit

htop	Enhanced top (needs install)	sudo apt install htop

kill	Kill process by PID	kill 1234

uptime	How long system has been running	uptime

df -h	Disk space usage (human readable)	df -h

free -m	Memory usage	free -m


📦 5. Package Management

👉 Depends on distribution:

Ubuntu/Debian (apt)

Command	Description	Example

apt update	Refresh package list	sudo apt update

apt upgrade	Upgrade all packages	sudo apt upgrade

apt install	Install package	sudo apt install nginx

apt remove	Remove package	sudo apt remove nginx


RHEL/CentOS (yum or dnf)

Command	Description	Example

yum install	Install package	sudo yum install httpd

yum remove	Remove package	sudo yum remove httpd

⚙️ 6. System Services

Command	Description	Example

systemctl status	Check service status	systemctl status ssh

systemctl start	Start service	sudo systemctl start nginx

systemctl stop	Stop service	sudo systemctl stop nginx

systemctl restart	Restart service	sudo systemctl restart nginx

systemctl enable	Auto-start on boot	sudo systemctl enable nginx

🌐 7. Networking

Command	Description	Example

ip a	Show IP addresses	ip a

ping	Check network connection	ping google.com

netstat	View network connections	netstat -tulnp

curl	Fetch URL contents	curl https://example.com

**🗂 8. Archiving & Compression**

Command	Description	Example

tar	Archive/extract files	tar -czvf archive.tar.gz folder/

unzip	Extract zip files	unzip file.zip

gzip / gunzip	Compress/Decompress	gzip file.txt


**⏰ 9. Scheduling Jobs**

Command	Description	Example

crontab -e	Edit cron jobs	0 3 * * * /home/user/backup.sh (daily at 3AM)

at	Run a command once at a time	`echo "uptime"

**📝 10. Basic Shell Scripting**


#!/bin/bash

echo "Hello, $USER!"

date

Save as hello.sh and run:

chmod +x hello.sh

./hello.sh

