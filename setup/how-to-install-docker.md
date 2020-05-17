# Docker Installation

## Script from docker.com

Docker can easily be installed on your linux machine by running these commands:

```bash
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sh get-docker.sh
```

## Docker-Compose Installation

Using phython-pip docker-compose can be installed with this command:

```bash
$ pip install docker-compose
```

## Choose Your Data-Folder

You have to select a folder on a large partition to host all your servers' data. This folder could be /mydatafolder - pick whatever is right for you.

Later in the docker-compose scripts we will use the placeholder variable $pwd to indicate the current working folder. So lets say you are on your /mydatafolder and clone this repository there with ```git clone repository-name```, then you will find the docker-compose files in the /mydatafolder/liberty-server. Usually, when using docker-compose you go into the folder before you run the command.

```bash
$ cd /mydatafolder/liberty-server/traefik
```

After editing the configuration files you run

```bash
$ docker-compose up
```

or

```bash
$ docker-compose up -d
```

Whenever there is a $PWD variable in the docker-compose files, it will automatically replaced with /mydatafolder/liberty-server/traefik

## Docker on Fedora 31 / CgroupsV2

With the update to version 31, Fedora now uses CgroupsV2 – the latest version of the control groups to manage Linux processes in hierarchies. Docker, on the other hand, expects version 1 of the control groups. As long as Docker does not support version 2 of control groups, the kernel needs an extra argument to be backwards compatible. This can be achieved by adding the following arguments in Grub: ```systemd.unified_cgroup_hierarchy=0```.

To add these kernel arguments to grub permanently this command can be used:

```
$  sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0" --make-default
```

## Docker and the Firewall on Fedora 32

Docker handles the firewall settings for it's own services. On Fedora 32 the firewall backend was changed from iptables to nftables.

To further give docker the ability handle the firewall the setting has to be reverted to iptables. To change the firewall settings open firewalld.conf

```sudo vim /etc/firewalld/firewalld.conf```

and change this line

```
FirewallBackend=nftables
```

to

```
FirewallBackend=iptables
```

Then restart firewalld:

```bash
sudo systemctl restart firewalld.service
```