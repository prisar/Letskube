
eval $(minikube docker-env)

kubectl cluster-info
Kubernetes master is running at https://192.168.64.3:8443

kubectl run letskube-deployment --image=letskube:local --port=80 --replicas=3

kubectl expose deployment letskube-deployment --type=NodePort

