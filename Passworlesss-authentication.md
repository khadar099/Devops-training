## ssh-copy-id ubuntu@publicip - troubleshooting

1. Check SSH Service Name
On some systems, especially in non-standard environments or containers, the service name might be different. You can check for any SSH-related services by listing all active services:

systemctl list-units --type=service | grep ssh

If you find a service like ssh.service or sshd.socket, try restarting that service instead:

sudo systemctl restart ssh.service

2. Install SSH Server (if not installed)

If the SSH server is not installed, you need to install it. On most Linux distributions, 
you can install the SSH server package using the following commands:

For Ubuntu/Debian-based systems:

sudo apt update
sudo apt install openssh-server

For Red Hat/CentOS/Fedora-based systems:

sudo yum install openssh-server

For newer versions of CentOS/Fedora (using dnf):

sudo dnf install openssh-server
After installation, start and enable the SSH service:

sudo systemctl enable --now ssh

3. Check SSH Installation
4. 
Verify that SSH is properly installed by checking its version:

ssh -V
You can also check if the sshd binary is available:

which sshd

4. Manually Start SSH Server
5. 
If the sshd binary is installed but the service is not running, try manually starting the SSH server:


## Using Password

Go to the file /etc/ssh/sshd_config.d/60-cloudimg-settings.conf

Update PasswordAuthentication yes

Restart SSH -> sudo systemctl restart ssh


sudo /usr/sbin/sshd
