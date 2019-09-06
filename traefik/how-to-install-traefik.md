# What is Traefik?
Traefik is a modern reverse-proxy. It handles the traffic from the internet to your dockerized applications.

Traefik also negotiates SSL-certificates for your services with let's encrypt.
Check out https://traefik.io for more information.

# How to make it fly?

## Run It on Linux
This howto refers to the usage on a Linux. It was tested on Fedora (Server) 30

## Register a Domain Name
To work with traefik you need to have a domain name associated to your server. If you are running a home server behind a router on a dial-in connection (VDSL, Cable, Fiber) and you are not having a fixed but a dynamic ip address, then you need to set up a DNS with dyndns. Pick any provider you like. This my be dyndns, no-ip, Strato or any other.

Hint: A professional DNS hoster from Germany is strato.de. Their domain package offers dynamic DNS service that can be used with many routers or ddclient on Linux.

## Forward Ports
If you are behind a router then you have to set up port forwarding:

Router:80 --> Server:80

Router:443 --> Server:443

## Add a Network in Docker
You got docker installed and started it? Create a virtual network that connects traefik to your containers:

docker network create traefik_reverseproxy

## Set Permissions
Go to /mydatafolder/liberty-server/traefik/config/ACME and run

```
$ chmod 600 acme.json
```

## Edit the configuration file
Pick an editor and edit the file

/mydatafolder/liberty-server/traefik/config/traefik.toml

* set your domain name
* set your eMail address
* set a admin-password for the webgui

To create the password, run this command:

```
$ htdigest -c passwordfile Administration admin
$ cat passwordfile
```

Example output for the password "test":

admin:Administration:fc8b8d90787cc5cb465bbdfd5c678d29

Copy your output into your traefik.toml, but leave the middle part away

users = ["admin:fc8b8d90787cc5cb465bbdfd5c678d29"]

## Start the Traefik Container
```
cd /mydatafolder/liberty-server/traefik
docker-compose up
```
... if there are no error messages, break it with ctrl+c and run
```
docker-compose up -d
```
