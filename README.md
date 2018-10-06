# Building the OpenVPN Operator from a Helm Chart

```
git clone git@github.com:operator-framework/helm-app-operator-kit.git openvpn-chart-operator
cd openvpn-chart-operator
docker build -t gcr.io/cloudflinger-com-prod/openvpn-operator --build-arg HELM_CHART=./openvpn-1.0.0.tgz --build-arg API_VERSION=brain.cloudflinger.com/v1alpha1 --build-arg KIND=Openvpn .
```

# Helm OpenVPN Operator Kit

This repository is cloned from the [helm-app-operator-kit](https://github.com/coreos/helm-app-operator-kit)

### Prerequisites

- Kubernetes 1.9+ cluster
- `docker` client
- `kubectl` client
- Openvpn Chart

### Instructions

1) Link the chart operator code into the gopath `ln -s $(pwd) $GOPATH/src/github.com/cloudflinger/openvpn-chart-operator`

2) Install dependencies

```sh
cd $GOPATH/src/github.com/cloudflinger/openvpn-chart-operator/helm-app-operator
dep ensure -v
```

Get the chart we're embedding

```
cp ../../chart-releases/openvpn-1.0.0.tgz ./
```

3) Build & push docker image

```sh
$ docker build -t gcr.io/cloudflinger-com-prod/openvpn-operator --build-arg HELM_CHART=/Users/jakegaylor/dev/jhgaylor/cloudflinger/infrastructure/charts/openvpn --build-arg API_VERSION=brain.cloudflinger.com/v1alpha1 --build-arg KIND=Openvpn .
$ docker push gcr.io/cloudflinger-com-prod/openvpn-operator
```

### To Deploy the operator into a cluster

See the documentation in infrastructure/prod/terraform/readme.md
