




**Components of Vertical Pod Autoscaler (VPA)**

The Vertical Pod Autoscaler (VPA) project consists of 3 key components that work together to monitor, recommend, and adjust resource requests for Kubernetes pods. These components include the following:

1. Recommender
**Role:** The Recommender continuously monitors the current and past resource consumption (CPU and memory) of containers.
Functionality:
Based on the observed usage, it provides recommended values for the containers' CPU and memory requests.
These recommendations are used by the other components to adjust the resource allocations for containers.
Purpose: Ensures that the resource requests of containers are always optimally set based on their actual usage, helping avoid both over-provisioning and under-provisioning of resources.

2. Updater
**Role:** The Updater is responsible for ensuring that running pods have the correct resource requests as per the Recommender's suggestions.
Functionality:
It checks which of the managed pods have outdated or incorrect resource settings.
If a pod's resources need to be updated, the Updater will evict (terminate) the pod so that it can be recreated by its controller (e.g., Deployment, ReplicaSet) with the updated resource requests.
Purpose: This ensures that the running pods always have the recommended resources by restarting pods with the updated requests if necessary.

3. Admission Plugin
**Role:** The Admission Plugin sets the correct resource requests on new pods, either when they are first created or when they are recreated due to the Updater's action.
Functionality:
It works during the pod creation process, checking if the pod is managed by VPA.
If the pod is managed by VPA, it modifies the pod's resource requests to reflect the recommended values provided by the 

**Recommender.**
**Purpose:** Ensures that newly created or recreated pods start with the optimal resource requests from the very beginning.
These three components (Recommender, Updater, and Admission Plugin) work together to provide dynamic resource allocation for Kubernetes pods, optimizing resource usage and improving cluster efficiency.