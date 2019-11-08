# Create acme.json

Traefik stores its certificates in a file called ```acme.json```. This file needs special permissions: It must only be readable and writeable by the owner.

To create the file do the following:

1. Change into the traefik2/letsencrypt folder.
2. ```touch acme.json``` to create the file.
3. ```chmod 600 acme.json``` to set the privileges.
