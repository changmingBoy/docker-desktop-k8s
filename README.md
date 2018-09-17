# Docker Desktop Kubernetes

在 Docker Desktop 玩 Kubernetes 单机集群 , 使用简单 , 支持 LB 驱动 , Windows / Mac 轻松使用([版本](./VERSION.md)) .

## 推送

在 Docker Desktop 开启代理 , 成功启动 Docker Desktop For Kubernetes 之后 , 执行[推送脚本](./push.sh) .

## 拉取

在 Docker Desktop 没有代理 , 成功启动 Docker Desktop 之后 , 执行[拉取脚本](./pull.sh) .

## Helm

安装 helm 服务 , 下载二进制文件 .

[Windows](./https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-windows-amd64.zip) / [Mac](./https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-darwin-amd64.tar.gz) 

``` bash

kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller \
--clusterrole="cluster-admin" \
--serviceaccount="kube-system:tiller"

helm init \
--tiller-image="k8sgcr/tiller:v2.10.0" \
--service-account="tiller"

```

## Ingress

使用 nginx 作为 ingress , 毕竟这个用得多并熟悉 .

``` bash

kubectl apply -f ./ingress/nginx.yaml

```

## Dashboard

管理界面以 ingress 导出 , 修改 ing.yaml 的 host 后执行安装 .

``` bash

kubectl apply -f ./dashboard/

```

## Rancher

官方仓库地址: https://github.com/rancher/server-chart

``` bash

helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

helm install stable/cert-manager \
--name cert-manager \
--namespace kube-system

helm install rancher-stable/rancher \
--name rancher \
--namespace cattle-system \
--set hostname=rancher.lanmingle.com

```
