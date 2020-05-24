# What is Portainer?

Portainer is a docker container management tool. It is very useful for beginners and professionals to administer the containers from this repository.

Learn more here: [www.portainer.io](https://www.portainer.io/)

## How to run

Run ```docker-compose up -d``` from within the folder to create and run the portainer container. Note: The settings will be stored on a volume, not in a local folder.

If necessary open port 9000 on your machine's firewall.

Open a webbrowser and open ```http://name-or-ip-of-server:9000/```. Follow the setup assistent.

## How to update

Portainer will tell you when a new version is available. To update the container, run the following commands:

```bash
docker stop portainer
docker rm portainer
docker pull portainer/portainer:latest
docker-compose up -d
```
