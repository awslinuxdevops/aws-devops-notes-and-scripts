# Docker commands basic to Advance:
```
# creating a docker image
docker build -t <image_name> .
```
#### Options: 
-t, --tag  "Name and optionally a tag (format: name:tag)
```
# creating a docker container
docker run -d -p 80:80 --name Nginx-app nginx-app:latest
```
#### Options:
* -d, --detach  Run container in background and print container ID
* -p,   option is used for port mapping between container and Host machine.
* --name, Option is used to assign a name to the container.



#### Command to run to export a Docker image as a Archive?
```
docker save -o  <output_file_name>.tar 	<image_name>
```

####  Command to run to import a Pre-exported Docker images Into Another Docker Host? 
```
docker load -i  <output_file_name>.tar 	
```

#### Paused Container be removed form Docker?
```
docker rm <container_id> 
```

#### Containers running, paused and stopped ? 
```
docker ps -q | wc -l

docker ps -aq -f   “status=paused” | wc -l
	
docker ps -aq -f “status=exited” | wc -l 
```
* **start  command** # "docker start < container_name>" 

* **stop  command** # "docker stop < container_name>" 

* **kill  command** # "docker kill < container_name>" 

#### docker volumes stored in Docker?
```
Docker volume will be stored on the host machine in the directory “/var/lib/docker/volumes”.
```

#### The Dockerfile supports the following instructions:

**Instruction Description:**
```
ADD 			Add local or remote files and directories.

ARG	    		Use build-time variables.

CMD		    	Specify default commands.

COPY			Copy files and directories.

ENTRYPOINT	    Specify default executable.

ENV			    Set environment variables.

EXPOSE		    Describe which ports your application is listening on.

FROM			Create a new build stage from a base image.

HEALTHCHECK	    Check a container's health on startup.

LABEL		    Add metadata to an image.

MAINTAINER	    Specify the author of an image.

ONBUILD		    Specify instructions for when the image is used in a build.

RUN			    Execute build commands.

SHELL		    Set the default shell of an image.

STOPSIGNAL	    Specify the system call signal for exiting a container.

USER			Set user and group ID.

VOLUME		    Create volume mounts.

WORKDIR		    Change working directory.

```
### Docker commands;
```
* docker save -o  <output_file_name>.tar 	<image_name>     ( Image as an Archieve)
			
* docker load -i  <input_file_name>.tar 				     ( Import the image)

* docker run –restart		                                 (  restart image )				               

* docker rm <container_name>                                 (  remove image )	

* docker inspect <image_name>                                ( inspect image with details )

* docker rmi `docker image ls | egrep "^mailcow/" | awk '{print $3}'`

* docker rmi `docker image ls | egrep "^mailcow/" | awk "{print $1" }
```  

### Docker commands: 


#### Remove all containers:
```
* docker ps -a

* docker system prune

* docker system prune -a

* docker images -a

* docker rmi <Image> <Image>

* docker images -f dangling=true

* docker image prune

* docker images -a | grep "pattern"

* docker images -a | grep "pattern" | awk '{print $1":$2}' | xargs docker rmi

# remove all containers:
------------------------

* docker stop $(docker ps -a -q)

* docker rm $(docker ps -a -q)

* docker rmi $(docker images -a -q)

* docker rm -f &(docker ps -a -q)

* docker run --rm image_name

* docker ps -a -f status=exited

* docker rm $(docker ps -a -f status=exited -q)

* docker ps -a -f status=exited -f status=created

* docker rm $(docker ps -a -f status=exited -f status=created -q) 

# remove containers according to a pattern:

list:
* docker ps -a | grep "pattern"

Remove:
* docker ps -a | grep "pattern" | awk '{print $1}' | xargs docker rm

# Remove unused docker Images:
* ***docker image prune --all*** 

* docker system prune --all --volumes
```
********************************************************************************

###  Name the Essential Docker Commands: 
```
$ docker version:

$ docker search:

$ docker pull:

$ docker restart: 

$ docker ps

$ docker kill

$ docker login

$ docker commit 

$ docker push

$ docker commit

$ docker network

$ docker history

$ docker rmi 

$ docker ps -a

$ docker logs

$ docker copy

$ docker volume

$ docker logout

$ docker build         This command will buld the docker image using Dockerfile 	
 
$ docker run	       This command is used to run the docker iamges as a container 

$ docker ps            This command will list the running containers in the docker

$ docker exec          Its helps to execute the commands in running container 

$ docker stop	       Running container will be stop using this command. 

$ docker system prune  removel of unused data on inclusion of stopped containers. 
```
#### Docker Subcommands:
|Command|Description|
|docker container attach	Attach local standard input, output, and error streams to a running container
docker container commit	Create a new image from a container's changes
docker container cp	Copy files/folders between a container and the local filesystem
docker container create	Create a new container
docker container diff	Inspect changes to files or directories on a container's filesystem
docker container export	Export a container's filesystem as a tar archive
docker container inspect	Display detailed information on one or more containers
docker container kill	Kill one or more running containers
docker container logs	Fetch the logs of a container
docker container pause	Pause all processes within one or more containers
docker container port	List port mappings or a specific mapping for the container
docker container prune	Remove all stopped containers
docker container rename	Rename a container
docker container restart	Restart one or more containers
docker container rm	Remove one or more containers
docker container start	Start one or more stopped containers
docker container stats	Display a live stream of container(s) resource usage statistics
docker container stop	Stop one or more running containers
docker container top	Display the running processes of a container
docker container unpause	Unpause all processes within one or more containers
docker container update	Update configuration of one or more containers
docker container wait	Block until one or more containers stop, then print their exit codes
docker container exec	Execute a command in a running container
docker container ls	List containers
docker container run	Create and run a new container from an image

Docker Commands
Installation
•sudo apt update
•sudo apt install docker.io
•sudo service docker start
•sudo systemctl enable docker
•sudo systemctl status docker
Docker Hub
•
### docker pull img_name: download an image from Docker Hub
Running Containers
•docker run image-name/image-id: create a container from an image
•docker run img_name: create a container
•docker run --detach/-d img_name: pull, start, and create a container
•docker run -d --name cont_name container_id: create a container with a name
Listing Containers and Images
•docker ps: show running containers
•docker ps -a/--all: show all containers (running and stopped)
•docker container ls: show all containers (running and stopped)
•docker images: show a list of images
Deleting Containers and Images
•docker rmi img_name: delete an image
•docker rmi $(docker images -a) / docker image prune / docker rmi $(docker image ls):
remove all images
•docker stop container_id: stop a container
•docker rm container_id: delete a stopped container
•docker rm $(docker ps -a / docker container ls -a) / docker container prune: delete all
stopped containers
Working with Containers
•docker exec -it container_id /bin/bash: start working in a container
•docker inspect container_id: show all information about a container
•docker run -d --name name nginx: create a container with a name
•docker history img_id: show all layers of an imagePort Mapping
•docker run -d -p80(ec2-port):80(container-port) img_id: map a port for an existing image
•docker run -d --name name -p80(ec2-port):(container-port) nginx: create a container with
port mapping
Creating Images
•docker commit container_id name: create an image from a container
•docker save > img_name.tar: create a tar file of an image
•docker export container_id > file_name.tar: create a tar file of a container
Volumes
•docker run -d --name name -p80(ec2-port):(container-port) -v path of directory:project
directory path in container img_name: create a container with a volume
•docker volume create vol_name: create a named volume
Environment Variables
•docker run -d --name merabaladb1 -e MYSQL_ROOT_PASSWORD='Pass@123' MySQL:
create a MySQL container with environment variables
•docker run -d --name sqlvol -v /home/ubuntu/sqlvol:/var/lib/mysql -e
MYSQL_ROOT_PASSWORD='pass@123' -e MYSQL_DATABASE="facebook" MySQL: create a
MySQL container with a database name and mount with a bind volume
Linking Containers
•
docker run -d --name wordpress -p80:80 -e WORDPRESS_DB_HOST=mydb -e
WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=pass123 -e
WORDPRESS_DB_NAME=db1 --link mydb:mysql wordpress: link a MySQL container to a
WordPress container
Dockerfile
Components of Dockerfile
•FROM: use for base images or to pull an image (can be used multiple times)
•RUN: for installing software or running Linux commands (can be used multiple times)
•EXPOSE: to open a port number
•COPY: to copy files and directories from the host to the image
•ENV: to set environment variables
•CMD: specifies the command to run when a container is run from the image (can only be
used once)
•ENTRYPOINT: specifies the command to run when a container is run from the image, but
allows additional arguments to be passed in (can only be used once)•ADD: copies files from the host to the image, downloads zip or tar files from a given link, and
extracts them automatically
•ARG: defines a variable that is passed to the container while building the image
•VOLUME: creates a volume, sets a volume
•WORKDIR: sets the working directory
•MAINTAINER: sets the name and email of the author/user
•LABEL: adds metadata (data about data)
•USER: sets the user (root, ec2-user, docker, etc.)
•HEALTHCHECK: specifies the path for a health check or checks the health of a mentioned URL
•SHELL: specifies the shell to be used to run commands
•STOPSIGNAL: specifies the signal to be sent to the container to stop it gracefully
•ONBUILD: specifies the instruction to be used when the
Docker Build
•docker build -f file_name .: run a file (if file name is different)
•docker build -t tag_name -f file_name . --> run file with tag
•docker system df --> for check container space
Docker Network
•docker network ls: show a list of networks
•docker network create name: create a network
•docker network inspect name: show all information about a network
•docker network rm name: delete a network
•docker run -d --name cont_name --network network_name image_id: create a container in
a network
•docker network connect network_name cont_name: add a container to a network
•docker network disconnect network_name cont_name: remove a container from a network
Docker Compose
•docker-compose up -d: run a compose file (if the file name is docker-compose.yml)
•docker-compose -f file_name up -d: run a compose file with a different name
•docker-compose down: delete containers
Docker System
•
docker system df: check container space