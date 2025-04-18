1. Remove Docker
Stop Docker service:

sudo systemctl stop docker
sudo systemctl stop docker.socket

Remove Docker packages:

sudo apt-get purge docker-ce docker-ce-cli containerd.io
Remove additional Docker-related files: This will remove all Docker images, containers, volumes, and networks:

sudo rm -rf /var/lib/docker
Remove Docker group and other Docker-related files:

sudo groupdel docker
sudo rm /etc/systemd/system/docker.service
sudo rm /etc/systemd/system/docker.socket
sudo rm -rf /etc/docker
Clean up any remaining dependencies and cache:

sudo apt-get autoremove -y
sudo apt-get clean
2. Remove Kubernetes
If you installed Kubernetes using kubeadm or apt, follow these steps to completely remove it.

Stop Kubernetes services:

sudo systemctl stop kubelet
sudo systemctl stop kube-proxy
Remove Kubernetes packages:

sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni
Remove Kubernetes configuration files:

sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/kubelet
sudo rm -rf /var/lib/etcd
sudo rm -rf ~/.kube
Clean up any remaining Kubernetes dependencies and cache:

sudo apt-get autoremove -y
sudo apt-get clean
3. Remove Kubernetes Network CNI Plugins (if applicable)
If you installed CNI plugins (e.g., Calico, Flannel), you may need to remove those as well:

Remove CNI plugins:

sudo rm -rf /opt/cni
4. Clean up Networking Configurations (if applicable)
Remove network bridge interfaces (if created by Docker or Kubernetes):

sudo ip link delete docker0
Remove any other network interfaces created by Kubernetes or Docker (such as flannel or cni interfaces):

sudo ip link delete <interface_name>
To list all interfaces:

ip addr show
Clean up network-related iptables rules:

sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -X
Check for any residual network configurations in /etc/network/interfaces or netplan configuration files, and clean them up if needed:

sudo nano /etc/network/interfaces
or for netplan configurations:

sudo nano /etc/netplan/*.yaml
5. Reboot the System
After you’ve completed all of the above steps, reboot your system to ensure all changes take effect:

sudo reboot
