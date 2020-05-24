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

## Important advise on security

Portainer needs access to the docker socket and therefor has full access to ALL containers and their content. Be aware of this when using portainer or any other tool with such privileges.

I suggest to consider the following minimal security precautions:

1. Never make the portainer port available on the internet or inside an untrusted network.
2. Never log in over unencrypted http protocol from an untrutested network.
3. Use a unique and complex password.
4. Consider using SSL encryption.
