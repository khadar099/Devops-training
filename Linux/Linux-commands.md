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

