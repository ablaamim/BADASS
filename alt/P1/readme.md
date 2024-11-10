# Install Docker

https://docs.docker.com/engine/install/ubuntu/

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo

To run docker command without sudo, you need to add your user (who has root privileges) to docker group. For this run following command:

```bash
sudo gpasswd -a $USER docker
newgrp docker
```

# Install wireshark
https://www.cherryservers.com/blog/install-wireshark-ubuntu

```bash
sudo add-apt-repository ppa:wireshark-dev/stable -y
sudo update
sudo apt install wireshark
sudo usermod -aG wireshark $USER
newgrp wireshark
```

# Install GNS3

https://docs.gns3.com/docs/getting-started/installation/linux/

sudo add-apt-repository ppa:gns3/ppa
sudo apt update                                
sudo apt install gns3-gui gns3-server

# Create images

```bash
bash ./build.sh
```

Just to test

```bash
docker run routeur_aben-ham --privileged
```

# GNS3

- create the docker container from the gns3 interface
  - Edit -> Preferences -> Docker -> Docker Containers -> New

- Change Icon
  - Host icon -> classic docker_guest
  - Router icon -> classic router_switch

