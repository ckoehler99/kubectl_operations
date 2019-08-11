# /bin/bash

# install namespace
kubectl create -f 01_kube-logging.yaml
kubectl get namespaces

# install single instance 
kubectl create -f 02_elasticsearch_svc.yaml
kubectl get services --namespace=kube-logging

# Cluster Config DigitalOcean
kubectl create -f 02_DigitalOcean_elasticsearch_svc.yaml
kubectl get services --namespace=kube-logging

# single instance 
kubectl create -f 03_elasticsearch_deploy.yaml 
kubectl port-forward $(kubectl get pod -o name -n kube-logging | grep elasticsearch) 9200:9200 --namespace=kube-logging

# Cluster Config DigitalOcean
# kubectl create -f 03_DigitalOcean_elasticsearch_statefulset.yaml
# kubectl rollout status sts/es-cluster --namespace=kube-logging
# kubectl port-forward es-cluster-0 9200:9200 --namespace=kube-logging

# install kibana
kubectl create -f 04_kibana.yaml
kubectl rollout status deployment/kibana --namespace=kube-logging
kubectl port-forward $(kubectl get pod -o name -n kube-logging | grep kibana) 5601:5601 --namespace=kube-logging

# install fluentd
kubectl create -f 05_fluentd.yaml 

# status 
kubectl get pods --namespace=kube-logging