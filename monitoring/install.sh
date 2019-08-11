# /bin/bash

kubectl create -f 01_namespace.yaml 
kubectl create -f 02_prometheus.yaml
kubectl create -f 03_nodeexporter.yaml 
kubectl create -f 04_cadvisor.yaml

helm install --namespace kube-monitoring stable/grafana


