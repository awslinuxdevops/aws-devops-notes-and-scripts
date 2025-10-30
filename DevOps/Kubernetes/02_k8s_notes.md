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