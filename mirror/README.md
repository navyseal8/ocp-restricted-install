# Mirror registry


## Install 4.10.28 (Latest n-1 release)

## Download oc client
  https://access.redhat.com/downloads/content/290/ver=4.10/rhel---8/4.10.28/x86_64/product-software

## Standup a registry v2
```
  $ podman run -d -p 5000:5000 --restart=always --name registry registry:2
```

## Setup your registry passwd, and generate base64 user/passwd
```
  $ echo -n '<user_name>:<password>' | base64 -w0
```

## Download your pull-secret
  https://console.redhat.com/openshift/install/pull-secret

```
  json the secret
  $ cat ./pull-secret | jq . > pull_secret.json
```

## modify the pull_secret.json with your mirror registry base64 credentials

```
{
  "auths": {
    "cloud.openshift.com": {
      "auth": "b3BlbnNo...",
      "email": "you@example.com"
    },
    "quay.io": {
      "auth": "b3BlbnNo...",
      "email": "you@example.com"
    },
    "registry.connect.redhat.com": {
      "auth": "NTE3Njg5Nj...",
      "email": "you@example.com"
    },
    "registry.redhat.io": {
      "auth": "NTE3Njg5Nj...",
      "email": "you@example.com"
    },
    "<mirror_registry>": { 
      "auth": "<credentials>", 
      "email": "you@example.com"
    }
  }
}
```


## Setup your environment

```
OCP_RELEASE=4.10.28
LOCAL_REGISTRY='<local_registry_host_name>:<local_registry_host_port>'
LOCAL_REPOSITORY='<local_repository_name>'
PRODUCT_REPO='openshift-release-dev'
LOCAL_SECRET_JSON='<path_to_pull_secret>'
RELEASE_NAME="ocp-release"
ARCHITECTURE=x86_64
REMOVABLE_MEDIA_PATH=<path>
```


## Mirror your the OCP release into your registry

```
$ oc adm release mirror -a ${LOCAL_SECRET_JSON} \
   --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
   --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
   --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE} \
   --dry-run
```
