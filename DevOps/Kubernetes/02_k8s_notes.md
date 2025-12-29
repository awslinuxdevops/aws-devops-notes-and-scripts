**What is a DaemonSet in Kubernetes?**

**Answer:**

A DaemonSet in Kubernetes ensures that a specific Pod runs on every node in the cluster. It’s typically used for background system-level services like log collectors, monitoring agents, or networking components that need to be present on all nodes. When new nodes are added, the DaemonSet automatically deploys the Pod on them. If nodes are removed, those Pods are cleaned up automatically.


| **Term**           | **Example** | **What it means**                                                                                 |
| -------------- | ------- | --------------------------------------------------------------------------------------------- |
| **targetPort** | `80`    | The **port inside the pod** (where your app is actually running).                             |
| **port**       | `8080`  | The **port on the Service (inside cluster)** — other pods use this to talk to your app.       |
| **nodePort**   | `30001` | The **port on the Kubernetes node (host machine)** — used to access from outside the cluster. |



### Taints VS Tolerations: 

`Taints` and `Tolerations` are used to control which pods can be scheduled on which nodes. A taint is `applied on a node` to repel a set of pods, and a toleration is `applied on a pod` to allow it to be scheduled on that node.

For example, in our production cluster, we tainted a node used for database workloads so that only database pods with matching tolerations can run there.
This helps isolate workloads, ensure performance, and avoid resource contention.


**Taints are applied on Nodes.**
→ They tell “Don’t schedule pods here unless they can tolerate me.”

**Tolerations are applied on Pods.**
→ They tell “I can tolerate that taint, so you can schedule me there.”

So basically:

* Taint = restriction (on node)
* Toleration = permission (on pod)




Kubectx and Kubens - Command Line Utilities
Through out the course, you have had to work on several different namespaces in the practice lab environments. In some labs, you also had to switch between several contexts.



While this is excellent for hands-on practice, in a real “live” kubernetes cluster implemented for production, there could be a possibility of often switching between a large number of namespaces and clusters.



This can quickly become and confusing and overwhelming task if you had to rely on kubectl alone.



This is where command line tools such as kubectx and kubens come in to picture.



Reference: https://github.com/ahmetb/kubectx



Kubectx:

With this tool, you don't have to make use of lengthy “kubectl config” commands to switch between contexts. This tool is particularly useful to switch context between clusters in a multi-cluster environment.



Installation:

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx


Syntax:

To list all contexts:

kubectx



To switch to a new context:

kubectx <context_name>



To switch back to previous context:

kubectx -



To see current context:

kubectx -c





Kubens:

This tool allows users to switch between namespaces quickly with a simple command.

Installation:

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens


Syntax:

To switch to a new namespace:

kubens <new_namespace>



To switch back to previous namespace:

kubens -