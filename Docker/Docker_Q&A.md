# Interview Questions and Answers:

### What is a Docker? 

Docker is a containerization platform that allows to package an application with all its dependencies into one single entity as single container which can be easily deployed and run on any machine that supports docker. 

**Dockerfile Vs Docker-Compose:**

Dockerfile: A Dockerfile is a text document that contains all the commands a user needs to build a docker image, a file used to execute code in a docker container. When a user runs the Docker run commands and specifies WordPress.

**Docker-Compose:**

Docker compose is a tool for defining and running Docker containers by reading configuration data from a YAML file, which is a human-readable data-serialization lang used for configuration files and in application where data is being stored or transmitted. 

* ***RUN*** Mainly used to build images and install applications and packages, RUN builds a new layer over an existing image by commiting the results.

* ***CMD*** Sets default parameters that can be overidden from the Docker Command Line Interface(CLI) when a container is running.

* ***ENTRYPOINT*** Default parameters that cannot be overidden when Docker Containers run with CLI parameters.


### Difference between CMD and ENTRYPOINT?

**CMD:** The default parameters that can be overridden when running a container. CMD commands are ignored if parameters are stated in the docker run command.

**ENTRYPOINT:** the default parameters that cannot be overridden when running a container. ENTRYPOINT instructions are appeneded as command-line parameters. 

For example: 
<instruciton> <command> ---> Shell form
<instruction> ["<executable>","<parameter>"] ---> exec form

**Note:** If mulitple **CMD** instructions are passed in a Dockerfile, all expect the last instruction will be ignored.

**Note:** The default nature of ENTRYPOINT in Dockerfile is not to be overridden by parameters passed in command, but with some explicit docker flags, it can be overriden. 




### What is Containerd?

Containerd in simple terms is a container runtime that is, Containerd is a software responsible for running and managing containers on a host system. It is a resource manager which manages the container processes, image, snapshots, container metadata and its dependencies. 

### Functionality of a Hypervisor?

A hypervisor is a 'virtualization' software that helps in running multiple operating systems ( Guest OS ) on a single physical host system by providing an isolation between the virtual machines and manages their resources. 