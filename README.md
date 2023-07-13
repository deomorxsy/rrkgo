## rrkgo

Apache Spark workload orchestration with sparklyr package as API and k3s distro as cluster manager. Monorepo prototype bootstrapping with Ansible.



# Debug purposes

## 1. container observability one-liners

Start insecure registry at boot (local usage only)
```
sudo podman run --privileged -d --name registry -p 5000:5000 -v /var/lib/registry:/var/lib/registry --restart=always registry:2
```

Stop or start the registry
```
#podman stop/start registry
```

Deploy image to local registry
```
buildah bud -t localhost:5000/sparklyr-demo-v1:01
```

Check current images on registry:
```
curl --cacert domain.crt http://localhost:5000/v2/_catalog
```

Get image ID
```
podman images | grep sparklyr-demo-v2 | awk 'NR>-1 {print $3}'
```

Check image size on local registry
```
skopeo inspect docker://localhost:5000/sparklyr-demo-v2:03 | jq '[ .LayersData[].Size] | add' | numfmt --to=iec-i --suffix=B
```

Explore the image with bash as entrypoint
````
podman run --rm -it --entrypoint=/bin/bash localhost:5000/sparklyr-demo-v2:02
```
