# ocp-restricted-install


## Download installer program

Download latest installer from https://console.redhat.com/openshift/install

$ tar -xvf openshift-install-linux.tar.gz 

## Download your pull-secret

Download your pull-secret - https://console.redhat.com/openshift/install/pull-secret

## Generate key pair for cluster SSH access

```
$ ssh-keygen -t ed25519 -N '' -f <path>/<file_name>. (or RSA) 
$ eval "$(ssh-agent -s)"
```

## Deploying the cluster

Ensure the directory to store the files has "execute" permission

```
$ mkdir $HOME/mas-install
$ chmod +x $HOME/mas-install
```

Create the manifest file
```
$ ./openshift-install create manifests --dir $HOME/mas-install 
```

Upload the manifest files for etcd encrytion and audit
```
$ cp $HOME/files/xxx.yaml $HOME/mas-install/manifests
```

IPI install the cluster
```
$ ./openshift-install create cluster --dir $HOME/mas-install --log-level=debug

```

## Login to the cluster

```
$ export KUBECONFIG=$HOME/mas-install/auth/kubeconfig
$ oc whoami
```
