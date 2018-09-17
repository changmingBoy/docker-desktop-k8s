#!/bin/bash

k8s_ns="k8s.gcr.io"

images=(
    k8sgcr/kube-proxy-amd64:v1.10.3
    k8sgcr/kube-scheduler-amd64:v1.10.3
    k8sgcr/kube-apiserver-amd64:v1.10.3
    k8sgcr/kube-controller-manager-amd64:v1.10.3
    k8sgcr/k8s-dns-dnsmasq-nanny-amd64:1.14.8
    k8sgcr/k8s-dns-sidecar-amd64:1.14.8
    k8sgcr/k8s-dns-kube-dns-amd64:1.14.8
    k8sgcr/etcd-amd64:3.1.12
    k8sgcr/pause-amd64:3.1
    k8sgcr/kubernetes-dashboard-amd64:v1.8.3
)

other_images=(
    docker/kube-compose-controller:v0.3.9
    docker/kube-compose-api-server:v0.3.9
    k8sgcr/tiller:v2.10.0
    k8sgcr/nginx-ingress-controller:0.18.0
    k8sgcr/defaultbackend:1.4
)

for image in ${images[@]} ; do
    docker pull "$image"
    docker tag $image "$k8s_ns/${image##*/}"
    docker rmi $image
done

for image in ${other_images[@]} ; do
    docker pull "$image"
done
