# Docker Basic Hands-on Guide

## What is Docker?

## Advanatges of using docker

## Install docker
 * [Docker For Mac](https://docs.docker.com/v17.12/docker-for-mac/install/)
 * [Linux machine](https://runnable.com/docker/install-docker-on-linux)
 * Windows - You are already a warrior. :P

## demo-app-nodejs

  * Open a terminal and install express-generator from npm (node-package-manager).
  * After installing express-generator
        
    ```
    npm install -g express-generator  //install express-generator
    
    express desiredNameofTheApp      //vanilla template for express NodeJs project
    
    cd desiredNameofTheApp 
    
    npm install
    ```
    
## Add Dockerfile
 * Inside the desiredNameofTheApp/
 * initialize a git repository to track the changes
 
 ``` 
 git add .
 git commit -m "Initial Commit."
 touch Dockerfile
 
 ```
 * Copy-Paste contents to the Dockerfile
 
 ```
  # My first docker file.
  FROM node:latest
  MAINTAINER Vaibhav Aggarwal (XXXXXX@gmail.com)

  RUN echo "Tryin to build demo application"
  COPY . /var/www 
  WORKDIR /var/www
  RUN npm install
  # EXPOSE 3000
  ENTRYPOINT ["npm","start"]
 ```
 * We have a Dockerfile for our node application. We can build an image using the Dockerfile.
 
 ```
 docker build -t desiredName .  //builds an image with name desiredName
 docker image ls                //lists out all images available
 ```
 
 ![Screenshot 2020-01-30 at 1 43 06 PM](https://user-images.githubusercontent.com/23367724/73444941-a8caec00-437f-11ea-9174-a1cd3737a4ae.png)
 
 
 > docker run -p <HOST_PORT>:<CONTAINER_PORT> IMAGE_NAME
 
 * After we have built the image, we have our application's deployable image ready to ship.
 
 ```
 docker run -p 3000:3000 image_name/image_id     //to run in attach mode. 
 docker run -p -d 3000:3000 image_name/image_id  //to run in detach mode
 docker inspect <container-id>                   // inspect info about container
 docker logs <container-id>                      // logs for container
 docker stop <container-id>                      // stop a running container

 ```
 More beginner commands at https://towardsdatascience.com/15-docker-commands-you-should-know-970ea5203421
 
 * We can check our live applcation running on docker at [url] (http://localhost:3000)
 
 ![image](https://user-images.githubusercontent.com/23367724/73444833-702b1280-437f-11ea-939c-5e526115fe8c.png)
 
 
 ## Modifications 
  Its not a good practice to use dev-code for production purposes. Many environment variables can get shipped along to the production raising security and configuration issues.
  
  * Git is a centralized vcs which is used to maintain the codebase. Code is pushed to master branch after ignoring (environment variables, modules etc..), checking language standards etc... A mirror of master branch respository should be use to run as our application.
  * Lets make changes
  
  ```
  # RUN commands inside BASE IMAGE
  RUN mkdir -p /var/www 
  RUN apk add --no-cache git
  RUN apk add --no-cache openssh

  #CLONE git repo inside BASE IMAGE
  RUN git clone https://github.com/Alakazam03/demo-app-nodejs.git /myapp/

  #COPY cloned repo inside BASE IMAGE to another directory at BASE IMAGE
  RUN cp -R /myapp/* /var/www

  RUN echo "Tryin to build demo application"
  # COPY . /var/www 
  WORKDIR /var/www
  RUN npm install

  ENTRYPOINT ["npm","start"]
  ```
  
  We have our application running inside a docker container. If ran in detached mode
  
  Build a new docker image using modifed Dockerfile
  ```
  docker build -t newDesiredName .  //builds an image with name desiredName
  docker image ls                //lists out all images available
  ```
  
  ![image](https://user-images.githubusercontent.com/23367724/73444572-d5323880-437e-11ea-8d28-e6a30c3f70a1.png)
  
  Run new docker image using imageId. (or newDesiredName)
  ![image](https://user-images.githubusercontent.com/23367724/73444625-f7c45180-437e-11ea-8e95-69c1209f9ff0.png)

  ```
  docker ps
  ```
  
## Pushing a Docker image to Docker repository
The Docker image you built still resides on your local machine. This means you can’t run it on any other machine outside your own—not even in production! To make the Docker image available for use elsewhere, you need to push it to a Docker registry.

A Docker registry is where Docker images live. One of the popular Docker registries is Docker Hub. You’ll need an account to push Docker images to Docker Hub, and you can create one here.

With your Docker Hub credentials ready, you need only to log in with your username and password.

```
docker login
```

Now we need to tag our image in a format dockerHubUserName/desiredName to be able to push it to docker hub.
```
docker tag desiredName dockerHubUserName/desiredName:version1
docker push dockerHubUserName/desiredName:version1

```
Now we have our application image that can be run without any external dependency. (Try, pulling your image in some other machine and run it.)
