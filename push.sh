#!/bin/bash

hub_ns="k8sgcr"
images=(
    k8s.gcr.io/kube-proxy-amd64:v1.10.3
    k8s.gcr.io/kube-scheduler-amd64:v1.10.3
    k8s.gcr.io/kube-apiserver-amd64:v1.10.3
    k8s.gcr.io/kube-controller-manager-amd64:v1.10.3
    k8s.gcr.io/k8s-dns-dnsmasq-nanny-amd64:1.14.8
    k8s.gcr.io/k8s-dns-sidecar-amd64:1.14.8
    k8s.gcr.io/k8s-dns-kube-dns-amd64:1.14.8
    k8s.gcr.io/etcd-amd64:3.1.12
    k8s.gcr.io/pause-amd64:3.1
    k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3
)

for image in ${images[@]} ; do
    new_image="$hub_ns/${image##*/}"
    docker tag "$image" "$new_image"
    docker push "$new_image"
    docker rmi "$new_image"
done
