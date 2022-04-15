# docker-compose Tinkerbell

This directory contains docker-compose configuration for operating Tinkerbell


## Kubernetes Resource Model

To operate Tinkerbell and Kubernetes as the datastore, use the provided
`docker-compose.k8s.yml` file.

Because the work is in-progress, you'll need to build several images first for
Tinkerbell, Boots, and Hegel:

```sh
GOPATH=${GOPATH:-~/go}
mkdir -p $GOPATH/src/github.com/tinkerbell
cd $GOPATH/src/github.com/tinkerbell

git clone https://github.com/micahhausler/tink.git
git -C ./tink checkout krm/tink-server
# This will make the tinkerbell server and controller images
make images

git clone https://github.com/micahhausler/boots.git
git -C ./boots checkout krm/client
# This will make the boots image
make image

git clone https://github.com/chrisdoherty4/hegel.git
git -C ./hegel checkout cpd/impl-kubernetes-client
make image

# Update the images in .env with the ones you built
cat << EOF>> .env
BOOTS_SERVER_IMAGE=boots:latest
TINK_CONTROLLER_IMAGE=tink-controller:latest
TINK_SERVER_IMAGE=tink-server:latest

K3S_TOKEN=${RANDOM}${RANDOM}${RANDOM}
EOF
```

You can now start your Tinkerbell stack

```sh
docker-compose -f docker-compose.k8s.yml up -d
```

Once everything is up, you can get the status of it
```sh
docker-compose -f docker-compose.k8s.yml ps

docker-compose -f docker-compose.k8s.yml logs tink-server
```

And to access the K3s Kubernetes API, just set your KUBECONFIG to the generated
file:

```sh
export KUBECONFIG=$(pwd)/k3s/kubeconfig.yaml
sudo chmod 644 $KUBECONFIG
```
