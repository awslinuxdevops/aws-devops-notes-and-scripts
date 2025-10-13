# Docker files of Sample templates:

### Dockerfile specifications with an Entrypoint command:     
```
FROM ubuntu:latest
LABEL maintainer="murthy" Name="<your_email@example.com>"
RUN apt-get update
RUN apt-get install -y python
RUN mkdir /app
WORKDIR /app
COPY ./opt/source code
ENTRYPOINT [ "echo","Hello","Murthy" ]
```


```
vi index.html

# Base Image
FROM nginx:apline

# Maintainer of the Dockerfile
LABEL murthy <123test@gmail.com>

# Copy the index.html file to the /usr/share/nginx/html directory
COPY index.html /usr/share/nginx/html/

#Expose Nginx Port
EXPOSE 80

#start Nginx Service
CMD ["nginx", "-g", "daemon off;"]
```
