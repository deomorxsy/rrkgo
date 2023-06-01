## Useful commands

Apache Spark workload orchestration with K3S. Monorepo prototype bootstrapping with Ansible.



## Debug purposes
1. Check current images on registry:

```
curl --cacert domain.crt http://localhost:5000/v2/_catalog
```

## run image generated locally with podman

2. Enter the container from the image

````
podman run --rm -it --entrypoint=/bin/bash localhost:5000/sparklyr-demo-v2:02
```
