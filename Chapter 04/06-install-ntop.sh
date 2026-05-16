 
# On ubuntu
wget https://packages.ntop.org/apt/ntop.key | sudo apt-key add -   

add-apt-repository "deb https://packages.ntop.org/apt/$(lsb_release -cs) ./"   

apt update   
apt install ntopng   
apt install nprobe   


# on Rocky Linux
curl https://packages.ntop.org/centos-stable/ntop.repo |sudo tee  /etc/yum.repos.d/ntop.repo 

dnf config-manager --set-enabled crb 
dnf install epel-release 
dnf install ntopng
dnf install nprobe


# Check and restart the ntopng service is needed
systemctl status ntopng 
systemctl restart ntopng
