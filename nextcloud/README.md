# Nextcloud

## What is Nextcloud?

Nextcloud is a groupware with focus on file storage. It can replace services like Google Drive or Onedrive. Nextcloud certainly is one of the most popular choices for people and companies who want to take control of their own data instead of relying on the services of big tech companies.

## About this Setup

This example configuration starts Nextcloud as a single Docker container and stores all persistent data (use data and Nextcloud setup) into a subdirectory. This makes it easy to handle the data. The alternative would be saving persistent data into volumes. 

## Quick start

### What has to be done before starting the Nextcloud container

1. Your Linux must be up and running, docker must be installed.
2. You know where you want to store your data. Nextcloud data can easily become a lot to handle! Think about storage before you run Nextcloud!
3. Traefik reverse proxy is already up and running.

### What has to be done after you got this container running

4. Configure and start the database container.
5. During Nextcloud setup select "MySQL" as Database and connect to "cloud-db" with the username and password you set up in the database container's setup.

Yes, I know: Many tutorials put the database configuration into the same docker-compose-file as nextcloud. I decided against that because I like to be able to recreate single container at a later point independently from each other.

### Starting the Nexcloud container

After changing the configuration in docker-compose.yaml to your liking:

```bash
docker-compose up -d
```

## Whats in the docker-compose.yaml

### Container image

```
    image: nextcloud:latest
```

The image to be pulled from docker hub. ```:latest``` means "latest version" 

### Container Name and Behavior

```
    container_name: nextcloud-app
    restart: always
```

The name of the container instance. It will automatically restarted after failure or reboot.

### Persistent Data Configurations

```
    volumes:
      - $PWD/config:/var/www/html/config
      - $PWD/cloud:/var/www/html
      - $PWD/apps:/var/www/html/apps
```

In this section is defined where the persistent data of Nextcloud will be stored. ```$PWD``` is a variable containing the current working directory from which you are running ```docker-compose```. Each line is separated by a colon ```:```. Left of the colon is the local path on your server. This part you can cange to your liking. Right of the colon is the path inside the container. DO NOT CHANGE THIS!.

```
    environment:
      - NEXTCLOUD_DATA_DIR=/var/www/html/data
``` 

Environment variables are readable from inside the container. To learn more about Nextcloud's environment variables, read the documentation please. <https://hub.docker.com/_/nextcloud>

### Labels - Traefik Configuration

```
    labels:
      - "traefik.enable=true"
      - "traefik.port=80"
      - "traefik.docker.network=webproxy"
      # Entrypoint and TLS
      - "traefik.http.routers.cloud.entrypoints=websecure"
      - "traefik.http.routers.cloud.rule=Host(`yourhostname`)" # Put in your hostname here, e.g. subdomain.domain.tld
      - "traefik.http.routers.cloud.tls.certresolver=mytlschallenge"
      # Middlewares:
      - "traefik.http.routers.cloud.middlewares=cloud@docker,cloud-dav@docker"
      # Middleware cloud adds additional headers:
      - "traefik.http.middlewares.cloud.headers.customFrameOptionsValue=SAMEORIGIN"
      - "traefik.http.middlewares.cloud.headers.framedeny=true"
      - "traefik.http.middlewares.cloud.headers.sslredirect=true"
      - "traefik.http.middlewares.cloud.headers.stsIncludeSubdomains=true"
      - "traefik.http.middlewares.cloud.headers.stsPreload=true"
      - "traefik.http.middlewares.cloud.headers.stsSeconds=15552000"
      # Middleware cloud-dav replaces .well-known paths for caldav and carddav with proper nextcloud path
      - "traefik.http.middlewares.cloud-dav.replacepathregex.regex=^/.well-known/ca(l|rd)dav"
      - "traefik.http.middlewares.cloud-dav.replacepathregex.replacement=/remote.php/dav/"
```

Labels are like stickers on a parcel. They can tell the postman how to handle the parcel. In this case they tell the traefik reverse proxy what services to provide.

ITS IMPORTANT THAT YOU AT LEAST CHANGE YOUR HOSTENAME HERE!

Read more about Middlewares here:
<https://docs.traefik.io/middlewares/overview/>

Read more about CalDAV and CardDAV service discovery on Nextcloud here:
<https://docs.nextcloud.com/server/18/admin_manual/issues/general_troubleshooting.html#service-discovery>

Please check you trafik's documentation for further details: <https://docs.traefik.io/>

### Networking

```
    networks:
      - webproxy
      - backend
```

These lines define which networks to use. ```webproxy``` is the network where traefik reverse proxy is running. ```backend``` is the network for services like the database.

### Logging

```
    logging:
      options:
        max-size: '12m'
        max-file: '5'
      driver: json-file
```

These are the individual logging options of the container. Please check out the docker manual to learn more: <https://docs.docker.com/config/containers/logging/configure/>

### Networks

```
networks:
  webproxy: # this is the network provided by traefik
    external:
      name: webproxy
  backend: # your database should be in this network
```

This is the second part of the network configuration. The network ```webproxy``` is being refered to. It must exist before this container is beeing started. ```backend``` is being created at this point.
