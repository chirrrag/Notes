Certification Tip: Formatting Output with kubectl
                                                                       

The default output format for all kubectl commands is the human-readable plain-text format.

The -o flag allows us to output the details in several different formats.



kubectl [command] [TYPE] [NAME] -o <output_format>

Here are some of the commonly used formats:



-o jsonOutput a JSON formatted API object.

-o namePrint only the resource name and nothing else.

-o wideOutput in the plain-text format with any additional information.

-o yamlOutput a YAML formatted API object.

Here are some useful examples:

Output with JSON format:

master $ kubectl create namespace test-123 --dry-run -o json
{
    "kind": "Namespace",
    "apiVersion": "v1",
    "metadata": {
        "name": "test-123",
        "creationTimestamp": null
    },
    "spec": {},
    "status": {}
}
master $


Output with YAML format:

master $ kubectl create namespace test-123 --dry-run -o yaml
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: test-123
spec: {}
status: {}


Output with wide (additional details):

Probably the most common format used to print additional details about the object:

master $ kubectl get pods -o wide
NAME      READY   STATUS    RESTARTS   AGE     IP          NODE     NOMINATED NODE   READINESS GATES
busybox   1/1     Running   0          3m39s   10.36.0.2   node01   <none>           <none>
ningx     1/1     Running   0          7m32s   10.44.0.1   node03   <none>           <none>
redis     1/1     Running   0          3m59s   10.36.0.1   node01   <none>           <none>
master $


For more details, refer:


###
###
###
###
###
###
###
###
###
###
###
Certification Tip: Imperative Commands
While you would be working mostly the declarative way - using definition files, imperative commands can help in getting one-time tasks done quickly, as well as generate a definition template easily. This would help save a considerable amount of time during your exams.

Before we begin, familiarize yourself with the two options that can come in handy while working with the below commands:

--dry-run: By default, as soon as the command is run, the resource will be created. If you simply want to test your command, use the --dry-run=client option. This will not create the resource. Instead, tell you whether the resource can be created and if your command is right.

-o yaml: This will output the resource definition in YAML format on the screen.



Use the above two in combination along with Linux output redirection to generate a resource definition file quickly, that you can then modify and create resources as required, instead of creating the files from scratch.



kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx-pod.yaml



POD
Create an NGINX Pod

kubectl run nginx --image=nginx



Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)

kubectl run nginx --image=nginx --dry-run=client -o yaml



Deployment
Create a deployment

kubectl create deployment --image=nginx nginx



Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)

kubectl create deployment --image=nginx nginx --dry-run -o yaml



Generate Deployment with 4 Replicas

kubectl create deployment nginx --image=nginx --replicas=4



You can also scale deployment using the kubectl scale command.

kubectl scale deployment nginx --replicas=4



Another way to do this is to save the YAML definition to a file and modify

kubectl create deployment nginx --image=nginx--dry-run=client -o yaml > nginx-deployment.yaml



You can then update the YAML file with the replicas or any other field before creating the deployment.



Service
Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379

kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml

(This will automatically use the pod's labels as selectors)

Or

kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml (This will not use the pods' labels as selectors; instead it will assume selectors as app=redis. You cannot pass in selectors as an option. So it does not work well if your pod has a different label set. So generate the file and modify the selectors before creating the service)



Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes:

kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml

(This will automatically use the pod's labels as selectors, but you cannot specify the node port. You have to generate a definition file and then add the node port in manually before creating the service with the pod.)

Or

kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml

(This will not use the pods' labels as selectors)

Both the above commands have their own challenges. While one of it cannot accept a selector the other cannot accept a node port. I would recommend going with the `kubectl expose` command. If you need to specify a node port, generate a definition file using the same command and manually input the nodeport before creating the service.



Reference:

https://kubernetes.io/docs/reference/kubectl/conventions/
## #########
## #########
## #########
## #########
## #########
## #########
## #########
## #########
## #########
## #########
## #########
## #########
## #########

Run the command to generate the definition file:

kubectl run redis --image=redis:alpine --dry-run=client -oyaml > redis-pod.yaml
Add given labels tier=db under the metadata section.

---
apiVersion: v1
kind: Pod
metadata:
  labels:
    tier: db
  name: redis
spec:
  containers:
  - image: redis:alpine
    name: redis
  dnsPolicy: ClusterFirst
  restartPolicy: Always
Then run the command: kubectl create -f redis-pod.yaml to create the pod from the definition file.

OR

Use the imperative command: -

kubectl run redis -l tier=db --image=redis:alpine

# to create a service
> Run the command: kubectl expose pod redis --port=6379 --name redis-service
# create deployment
Run the command: kubectl create deployment  webapp --image=kodekloud/webapp-color --replicas=3
# create pod and run on container port
kubectl run custom-nginx --image=nginx --port=8080
# CREATE NAMESPACE
Run the command: kubectl create namespace dev-ns or kubectl create ns dev-ns
# Create a pod called httpd using the image httpd:alpine in the default namespace. Next, create a service of type ClusterIP by the same name (httpd). The target port for the service should be 80.
> Run the command: kubectl run httpd --image=httpd:alpine --port=80 --expose


###
###
###
###
###
###
A quick note on editing Pods and Deployments
Edit a POD
Remember, you CANNOT edit specifications of an existing POD other than the below.

spec.containers[*].image

spec.initContainers[*].image

spec.activeDeadlineSeconds

spec.tolerations

For example you cannot edit the environment variables, service accounts, resource limits (all of which we will discuss later) of a running pod. But if you really want to, you have 2 options:

1. Run the kubectl edit pod <pod name> command.  This will open the pod specification in an editor (vi editor). Then edit the required properties. When you try to save it, you will be denied. This is because you are attempting to edit a field on the pod that is not editable.



A copy of the file with your changes is saved in a temporary location as shown above.

You can then delete the existing pod by running the command:

kubectl delete pod webapp



Then create a new pod with your changes using the temporary file

kubectl create -f /tmp/kubectl-edit-ccvrq.yaml



2. The second option is to extract the pod definition in YAML format to a file using the command

kubectl get pod webapp -o yaml > my-new-pod.yaml

Then make the changes to the exported file using an editor (vi editor). Save the changes

vi my-new-pod.yaml

Then delete the existing pod

kubectl delete pod webapp

Then create a new pod with the edited file

kubectl create -f my-new-pod.yaml



Edit Deployments
With Deployments you can easily edit any field/property of the POD template. Since the pod template is a child of the deployment specification,  with every change the deployment will automatically delete and create a new pod with the new changes. So if you are asked to edit a property of a POD part of a deployment you may do that simply by running the command

kubectl edit deployment my-deployment