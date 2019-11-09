# This is the home of your matrix-data

Well, you know there are different ways to store persistent data from containers. One way is, to write it to the host's file systems. Its not the best way if you are concerned about security. Also, if you run multiple instances of containers, you might want to think bigger and implement solutions like StorageOS. For smaller projects like homeservers, writing persistent data directly to disk is often good enough. The advantage is that the data is easier to handle. Anyways, you as the admin know best. 

If however you want to write your matrix data to disk, this folder here might contain your stuff. If you want to change the folder, please edit this line when starting the container from shell: ```-v $PWD/data:/data``` and the following section in your docker-compose file:

```    volumes:
      - $PWD/data:/data # important: this is a relative path!
```

Hint: When mapping folders in docker then part left of the colon (here its $PWD/data) is pointing to your host. The part right of the colon (here its /data) is pointing to the file system inside the container. This mean that whenever your containerized application writes stuff to /data it will be written to the folder you stated left of the colon.