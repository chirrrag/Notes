# PODS
> kubectl run nginx --image nginx
> kubectl run redis --image redis --namespace finance
LISt pods
> kubectl get pods

Get detailed info about pod:- 
    > kubectl describe pod <POD NAME>

#   KIND        |       VERSION
1.  POD                 v1
2. Service              v1
3. ReplicaSet           apps/v1
4. Deployment           apps/v1


We use kubectl run command with --dry-run=client -o yaml option to create a manifest file :-
> kubectl run redis --image=redis123 --dry-run=client -o yaml > redis-definition.yaml

After that, using kubectl create -f command to create a resource from the manifest file :-
> kubectl create -f redis-definition.yaml 

Verify the work by running kubectl get command :-
> kubectl get pods

Use the kubectl edit command to update the image of the pod to redis.
> kubectl edit pod redis

If you used a pod definition file then update the image from redis123 to redis in the definition file via Vi or Nano editor and then run kubectl apply command to update the image :-
> kubectl apply -f redis-definition.yaml 

> kubectl run nginx --image=nginx --dry-run=client -o yaml > redis.yaml


# RC ReplicaSet
main diff b/w both is RS requires selector defintion, to match pod which will be managed by RS, also RS will use apps/v1 as apiVersion becoz replica set also manages those pods which were not part of replica set creation.
## Scale the replicaSet
modify definition file, than run kubectl replace command
> kubectl replace -f replicaset.yaml
OR OR OR
> kubectl scale --replicas=6 -f replicaset.yaml
OR give name of RS
> kubectl scale --replicas=6 replicaset myapp-rs

# namespaces
> kubectl get pod --namespace=kube-system
> kubectl create -f pod-definition.yaml --namespace=dev
we can also move namespace into manifest file like this
metadata:
    namespace:dev

# create a new namespace
namespace-dev.yaml

apiVersion: v1
kind: Namespace
metadata:
    name: dev

> kubectl create -f namespace-dev.yaml

OR OR 
> kubectl create namespace dev

### switch to namespace permanently
> kubectl config set-context $(kubectl config current-context) --namespace=dev
> kubectl get pod

# view pods in all namespaces
> kubectl get pod --all-namespaces

To limit resources in a namespace, create a resourceQuota