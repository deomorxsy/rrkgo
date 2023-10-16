## rrkgo

[WIP] Apache Spark workload orchestration with sparklyr package as API and k3s distro as cluster manager. Monorepo prototype bootstrapping with Ansible.

# Debug purposes

## 0. basic k3s cluster management

Start k3s systemd service with```systemctl start k3s.service```. Stop execution with the script ```k3s-killall.sh```. Uninstall with ```k3s-uninstall.sh```.

Redirect the raw kubectl config view to $HOME so you can use it as a userspace app (i.e. when using k9s)
```
sudo k3s kubectl config view --raw > ~/.kube/config
```



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

## TODO

## Troubleshooting

### container storage virtualization (OCI, CRI)
Have a spare storage with plenty space (HDD, SSD)? You can use bind mount or symbolic links to bind/link the default $PATH for the static container storage detailed on [containers-storage.conf](https://web.archive.org/web/20230714001722/https://github.com/containers/storage/blob/01fccaa58f0663931c4295cf66bddae48fc24fcb/docs/containers-storage.conf.5.md).

__PS: bind mount will have a attack surface greater than soft link because it can pass through chroot! [?].__ Not sure if it can with pivot_root though. Be careful.

With bind mount, you can do manually or just put it on fstab (so every time on startup the mount will be run). For default OCI container storage:
1. with fstab, add at the end of ```/etc/fstab```:
```
# OCI-Containers-storage
/mnt/ssd/path/you/want $HOME/.local/share/containers/storage/ none defaults,bind
```
2. manually:
```
sudo mount -B /mnt/ssd/path/you/want/ $HOME/.local/share/containers/storage/
```

With soft/symbolic çinks: CRI using k3s' kubelet, that is statically linked in the binary, you will need to reinstall the cluster.
```
# =======================================
# k3s setup part adapted from example provided by @/mdrakiburrahman
# at https://github.com/k3s-io/k3s/issues/2068#issuecomment-1374672584
#
# Storage prep to "/mnt/ssd/" drive (~80 GB+)
# =======================================
MNT_DIR="/mnt/ssd/dataStore/k3s-local/local-path-provisioner/storage"
K3S_VERSION="put the k3s version here. You can get the version pattern in the releases page. Example: v1.27.1+k3s1"
# nodefs
#
KUBELET_DIR="${MNT_DIR}/kubelet"
sudo mkdir -p "${KUBELET_DIR}"

# imagefs: containerd has a root and state directory
#
# - https://github.com/containerd/containerd/blob/main/docs/ops.md#base-configuration
#
# containerd root -> /var/lib/rancher/k3s/agent/containerd
#
CONTAINERD_ROOT_DIR_OLD="/var/lib/rancher/k3s/agent"
CONTAINERD_ROOT_DIR_NEW="${MNT_DIR}/containerd-root/containerd"
sudo mkdir -p "${CONTAINERD_ROOT_DIR_OLD}"
sudo mkdir -p "${CONTAINERD_ROOT_DIR_NEW}"
sudo ln -s "${CONTAINERD_ROOT_DIR_NEW}" "${CONTAINERD_ROOT_DIR_OLD}"

# containerd state -> /run/k3s/containerd
#
CONTAINERD_STATE_DIR_OLD="/run/k3s"
CONTAINERD_STATE_DIR_NEW="${MNT_DIR}/containerd-state/containerd"
sudo mkdir -p "${CONTAINERD_STATE_DIR_OLD}"
sudo mkdir -p "${CONTAINERD_STATE_DIR_NEW}"
sudo ln -s "${CONTAINERD_STATE_DIR_NEW}" "${CONTAINERD_STATE_DIR_OLD}"

# pvs -> /var/lib/rancher/k3s/storage
#
PV_DIR_OLD="/var/lib/rancher/k3s"
PV_DIR_NEW="${MNT_DIR}/local-path-provisioner/storage"
sudo mkdir -p "${PV_DIR_OLD}"
sudo mkdir -p "${PV_DIR_NEW}"
sudo ln -s "${PV_DIR_NEW}" "${PV_DIR_OLD}"

# =======
# Install
# =======
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="$K3S_VERSION" INSTALL_K3S_EXEC="--kubelet-arg "root-dir=$KUBELET_DIR"" sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
```
