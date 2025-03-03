by default, helm will use ".kube/config" file for installing helm. if we dont want helm to use this file, we can set env variable "KUBECONFIG"

> helm repo list
    list of helm repo
> helm repo add bitnami https://charts.bitnami.com/bitnami

> helm search repo mysql