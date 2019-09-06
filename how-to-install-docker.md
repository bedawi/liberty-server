# Docker Installation
Docker can easily be installed on your linux machine by running these commands:
```
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sh get-docker.sh
```

# Docker-Compose Installation
Using phython-pip docker-compose can be installed with this command:
```
$ pip install docker-compose
```

# Choose Your Data-Folder
You have to select a folder on a large partition to host all your servers' data. This folder could be /mydatafolder - pick whatever is right for you.

Later in the docker-compose scripts we will use the placeholder variable $pwd to indicate the current working folder. So lets say you are on your /mydatafolder and clone this repository there with git clone <repository>, then you will find the docker-compose files in the /mydatafolder/liberty-server. Usually, when using docker-compose you go into the folder before you run the command.
```
$ cd /mydatafolder/liberty-server/traefik
```
After editing the configuration files you run
```
$ docker-compose up
```
or
```
$ docker-compose up -d
```

Whenever there is a $PWD variable in the docker-compose files, it will automatically replaced with /mydatafolder/liberty-server/traefik
