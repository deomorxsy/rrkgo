## rrkgo

[WIP] Apache Spark workload orchestration with sparklyr package as API and k3s distro as cluster manager. Monorepo prototype bootstrapping with Ansible.

# Debug purposes

## 0. todo

## 1. container observability one-liners

PS: This section is not production-ready, just to test locally the OCI image. Remember Kubelet's CRI have its own registry directory hard-coded when installing the cluster, and hence does not share the same pattern as the OCI ones ([containers-storage.conf(5)](https://web.archive.org/web/20230714001722/https://github.com/containers/storage/blob/01fccaa58f0663931c4295cf66bddae48fc24fcb/docs/containers-storage.conf.5.md)), even using an OCI-compliant high level container runtime such as containerd.


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
buildah bud -f ./core/Dockerfile -t localhost:5000/sparklyr-demo-v1:01
```

Check current images on registry:
```
curl --cacert domain.crt http://localhost:5000/v2/_catalog
```

Get image ID
```
podman images | grep sparklyr-demo-v1 | awk 'NR>-1 {print $3}'
```

Check image size on local registry
```
skopeo inspect docker://localhost:5000/sparklyr-demo-v1:01 | jq '[ .LayersData[].Size] | add' | numfmt --to=iec-i --suffix=B
```

Explore the image with bash as entrypoint
```
podman run --rm -it --entrypoint=/bin/bash localhost:5000/sparklyr-demo-v1:01
```


