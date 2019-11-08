# How to use traefik (v2.x)

## Note: This is a let's encrypt example

My traefik v2.x configuration example uses let's encrypt to obtain ssl certificates. There are different methods to acquire a certificate: TLS Challenge, HTTP Challenge, and DNS Challenge. While my traefik v1.x example used HTTP Challenge, this traefik v2.0 example uses TLS Challenge. The advantage of TLS over HTTP Challenge is that you do not need to open port 80 to the public anymore.

Read more about the different configurations here: <https://docs.traefik.io/v2.0/user-guides/docker-compose/acme-tls/>

## New labels for your containers

Add the following labels to your containers to make them available in traefik:

```
      - "traefik.enable=true"
      - "traefik.http.routers.whoami.rule=Host(`whoami.mydomain.com`)"
      - "traefik.http.routers.whoami.entrypoints=websecure"
      - "traefik.http.routers.whoami.tls.certresolver=mytlschallenge"
```

Replace "whoami" with the container name and edit the hostname.

## Switch from traefik 1 to traefik 2

1. Add the new labels to your containers
2. Change into the traefik2 folder and edit the docker-compose.yaml file. The change that must be done is adding your email address. 
3. Stop your old traefik1 container
4. Run docker-compose up -d from the traefik2-folder to start the new service.
5. Check the traefik's status on <http://localhost:8080>
