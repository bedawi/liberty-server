# SELinux

SELinux is a complicated topic and whoever can contribute useful facts to this document is kindly asked to do so.
About how Docker works with SELinux there is a very useful article available on: <https://prefetch.net/blog/2017/09/30/using-docker-volumes-on-selinux-enabled-servers/>

Docker can be configured to set the right SELinux context to mounted folders automatically when binding them. This is done by adding :Z to the volume.parameters in the ```docker-compose.yaml``` file. Example:

```
    volumes: 
      - $PWD/config:/var/www/html/config:Z
           │           │                  └── SELinux, set context when binding.  
           │           └───────────────────── Path inside the container
           └───────────────────────────────── Path on the server
```

Please note: a capital Z is used, then only one container accesses the folder; a small z is used, when multiple containers access a folder.

## List all Docker related security contexts

```bash
$ cat /etc/selinux/targeted/contexts/lxc_contexts
process = "system_u:system_r:container_t:s0"
content = "system_u:object_r:virt_var_lib_t:s0"
file = "system_u:object_r:container_file_t:s0"
ro_file="system_u:object_r:container_ro_file_t:s0"
sandbox_kvm_process = "system_u:system_r:svirt_qemu_net_t:s0"
sandbox_kvm_process = "system_u:system_r:svirt_qemu_net_t:s0"
sandbox_lxc_process = "system_u:system_r:container_t:s0"
```

## Set context of folders containing container data

If an old context has to be removed:

```bash
$ sudo semanage fcontext -d /mydatafolder
```

To set the context and change all files and folders recursively:

```bash
$ sudo semanage fcontext -a -t container_file_t /mydatafolder
$ sudo chcon -R -u system_u -r object_r -t container_file_t /mydatafolder
```

## Further reading

[Redhat Documentation on SELinux](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/using_selinux/index)

[Redhat Documentation on Docker in RHEL7](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/container_security_guide/docker_selinux_security_policy)

[Prefetch Technologies: Using docker volumes on SELinux-enabled servers](https://prefetch.net/blog/2017/09/30/using-docker-volumes-on-selinux-enabled-servers/)