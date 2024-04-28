Running the terraform script I encountered a problem. The config file to the newly created eks cluster was not generated. I had to run the following command in the aws clooudshell to get it generated:

aws eks get-token --cluster-name my-eks-cluster

then I applied it to my config file

-------------------------------------------------------------------------------------------------------------------------------
I have defined a custom path to my Kubernetes cluster config file, that now is this folder project.

----------------------------------------------------------------------------------------------------
Should apply Infraestructure best pratices of Infraestructure as clooudshell

I had an error in my aws context. The context was set as my ARN, and therefore couldn't communicate with my local cluster.
I had to create a new context, change the context to that new one.

Also, in my main.tf I have my Kubernetes section commented. This section does not work. The reason is that the cluster is not yet created, when the kubernetes files are deployed. After the cluster is created and both files are applied, everything runs perfectly. The list of commands are:

-aws eks update-kubeconfig --name my-eks-cluster --region eu-central-1
-kubectl apply -f deployment.yaml
-kubectl apply -f service.yaml

TODO: Have every step in the main.tf file