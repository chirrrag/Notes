# list of docker commands

-  docker run nginx 
    docker run command is used to run a container from an image, Running "docker run nginx" command will run an instance of nginx application on docker host if the image already exists. But, if image doesnot exist, it will go out to docker hub and pull that image down(only done for the first time, as for subsequent execution, the same image will be reused.) and then run its instance

- docker ps
    this command will list all runnning containers and basic info about them:- containerID, name of image we used to run the container, current status,  name of container
- docker ps -a  
    this command will list all the containers whether they are running or not.(will lisst all running as well as previously stopped containers or exited containers).

- docker stop <container-id or container-name>
    to stop a running container

- docker rm <container-id or container-name>
    to remove a stopped or running container permanently from listing in "docker ps -a" and to save space.

- docker images 
    to see list of images and their sizes.

- docker rmi <image-name>
    to remove an image from docker host
    to remove an image, we must ensure that no containers are running off of that image before attempting to remove image. We must stop and delete all dependent containers to be able to delete an image.

- docker pull <image-name>
    used to pull image from docker hub to our host, this only pulls the image, not runs its container

- docker run ubuntu
    it runs an instance of ubuntu image and exists immediately. we will not see that container running as this container will be exited, we will see that container in exited state. as containers are meant to run a specific task or a process. Once the task is completed, container exits. A container lives as long as the process inside it is alive, if that service insside the container stopped or crashed, then the container exists
- docker run ubuntu sleep 5
    we can instruct docker to run a process with docker run command, example a sleep command of duration 5 seconds , when container starts it runs to sleep command and goes into sleep for 5 seconds post which the sleep command exists and the container stops. 

# we can also execute a command in our container
- docker run ubuntu sleep 100
- docker exec <container-name> cat /etc/hosts
    docker will print the content of /etc/hosts file which is inside our running ubuntu container as it will sleep after 100 seconds    

# attach and detach mode
- docker run <some-image>
    when we run this command, it runs in foreground, i.e. in attach mode, meaning we will be attached to the console and standard out of the container and we will see the output of the container on the screen, we wont be able to do anything on the console(terminal) other than view the output until this docker container stops. thats why we can run our container in the detach mode.

- docker run -d <some-iamge=>
    this will run our container in background, i.e. in detach mode, and we will be back to our prompt immediately(i.e container will continue to run in the backend and we can use our terminal). run "docker ps" command to see runnning container

    ### to attach back to running container
    > docker attach <container-id>

- docker run -it <image name>
    we will login into the container after container is been running, -it option stands for interactive terminal


---
# demo docker commands
> docker run centos
    this centos image should be official in docker hub repo, and should be supported by docker. In case you want  your customzied image to run, use "docker run <userid>/<iamgename>"
    Container will run and exit immediately
    to keep the container running
> docker run -it centos bash

> docker ps
    will list running containers
> docker ps -a 
    will list running as well as exited contaeinrs, and will list all the container which you ran in past. We need to remove the container from our drive on our own as containers are living in local drive

> docker run centos sleep 20
    will run container and will sleep for 20 seconds, after 20 seconds it will stop the container.
> docker run -d centos sleep 20
    it will run in detach mode i.e. in background

> docker stop <container-id or name-of-contaienr>
    to stop or kill a container
    EXIT CODE 137, means we killed the container

> docker rm <container-id or name-of-container>
    to remove the container from our local drive

> docker ps -aq
    will list container id of all the containers(exited, runnning, all)
> docker rm $(docker ps -aq)
    remove all docker containers at once


> docker images
    list the images we currently have
> docker rmi <repo/iamge name OR image id>
    removes the images from docker host

> docker images -q
    will list id of all images
> docker rmi $(docker iamges -q)
    will remove all images at once

<NOTE> we can not delete the image whose container is currently running, so its mandatory that to remove and delete the container first whose image we want to delete.
If a container is dependent on particular image, than we can not delete the image till that container has been removed from our host(stopped and removed)

if we dont want to run docker container immediatly, we just want to pull the image, for that we can use docker pull command
> docker pull <image name from hub>
> docker pull ubuntu

RUNNING A COMMAND ON PARTICULAER CONTAINER, use "docker attach <container id>" command
> docker run -d ubuntu sleep 100
> docker ps

but if you want like just to run a command, without login into container , use "docker exec <container-id>" command
> docker exec <container-id> cat /etc/*release*

# exec command execute a commmand on a running container 

> docker version
    to check version of docketr
> docker images | wc -l

# name the container you run by using --name option 
> docker run -d --name webapp nginx:1.14-alpine



######              ### 
######              ### 
######              ### 
######              ### 
######              ### 
######              ### 

# DOCKER RUN | TAGS(versions)
> docker run redis
    this command will run latest version of redis image as container

> docker run redis:4.0
    4.0 is the version of redis image and is called tag of an image in docker
    used to run particular version of some image as container, if we dont specify any tag, docker will assume latest tag as default tag

INPUTS in docker run(stdin)
    by default, docker container doesnt listen to standard input, even though we are attached to a console, its not able to read any standard input from us.It doesnt have a terminal to read input, it runs in a non interactive mode, if you like to provide your input, you must map the standard input of your host to docker container using the "-i" option parameter

    example:- ./app.sh takes name as input and prints our name, and we dockerrize that application, so we will give input as "-i" option parameter

    > docker run -i <image-name>

    -i param is for interactive parameter, and when we will input our name, it will print our expected output, but the input prompt will be missing, to attach the input prompt "-t" we will use this option parameter, becoz application prompt on the terminal, and we have not attached to the containers terminal.
    -t stands for sudo terminal

    so with combination of -it we are attached to terminal in an interactive mode
    > docker run -it <image name>

   ## PORT MAPPING
   Every docker container gets IP assigned by default, this IP is internal IP and is only accessible within the docker host. so we cant access that application from container IP from web browser. To access that applicaton, we will do port map so that we can map the ip of container to IP of docker host with some port. This is called port mapping.
   Map port of docker container, to a free port on docker host
   
   Syntax :- docker run -p <Host Port>:<Container Port> <image name>

   > docker run -p 80:5000 <image name>
   
   now we can access our web app with <docker host ip>:<dockerhost port>. This way we can run multiple isntance of our application and map them to different ports or run instance of different appliations on different port.
   you can not map to more than one port on docker host.
   > docker run -p 8000:5000 <image name>

   ## HOW DATA IS PERSISTED IN DOCKER CONTAINER(VOLUME)
   > docker run mysql
        the data file are stored in location /var/lib/mysql inside the docker container.
        Docker container has its own isolated file system, any changes happen to any file within the container. 
        > docker stop mysql
        > docker rm mysql
        so on deletion of container, that dumped data into mysql container is lost

        So we persist this data, to persist that data we map the directory outside the container on the docker host to a directory inside the container

        Syntax:- docker run -v <volume inside/attached to docker host>:<container data storage> <image name>

        Syntax:- docker run -v <directory inside docker host>:<directory inside docker container> <image name>

        > docker run -v /opt/datadir:/var/lib/mysql mysql

        this way when docker container runs, this will mount the external directory to a folder inside the docker container, this way all the data will be stored in external volume at "/opt/datadir" directory, and thus that directoy will remain even if you delete the docker container

   ## inspect container

   > docker ps 
        command is enought to get basic details about container like their name and Ids, to see extra details about containers
   > docker inspect <container name or container ID>
        it returns all the details of a container in json format, such as the state, mount, configuration data, network settings, etc

    ## see log of container we ran in background
   > docker logs <container name or container ID >


## DEMO DOCKER RUN

> docker run ubuntu cat /etc/*release*
---
> docker run ubuntu:17.10
AND
> docker run ubuntu
    here ubuntu and ubuntu:17.10 are both different images

> docker run ubuntu sleep 15
    will run the container, and sleep command will be executed for 15 seconds, after 15 seconds, we can exit from the container to terminal

> docker stop <ccontainerID>
    to stop a running container

> docker run -d ubuntu sleep 1500
    to run a container in detach mode or in background
    to get attach back to that background running container use "docker attach command"
> docker attach <container id>
    this will bring docker process container, running in foreground. we are stuck at terminal cant do anything, so ewither we have to stop this container in duplicate terminal and run "docker stop" command.


> docker run timer

> docker run jenkins/jenkins
> docker ps :- to see docker process
    to find out internal ip of jenkins, use docker inspect
> docker inspect <container id>
    under network section, we can see the internal IP, we can access it via internal ip inside the docker host....

    to inspect it on web browser externally, we have to do port mapping.
    WE cant do the port mapping while container is running, so we have to stop the container. 

> docker run -p 8080:8080 jenkins/jenkins

now aftaer working some tasks in jenkins if we stop the container, all the data of that container is gone, thats why mapping volume is also good in terms of docker.
> mkdir my_jenkins_data
> docker run -p 8080:8080 -v <my host directory for backup>:<where jenkins store data> -u <someuser> <image name jenkins>
> docker run -p 8080:8080 -v /root/my_jenkins_data:/var/jenkins_home -u root jenkins/jenkins

    -u flag here is for user which has permission, as it willthrow permission denied error.
    > "-u root" will be for super user
    configure the jenkins
    now stop the container, and launch the one more container with above command where volumes are mentioned, i.e.
> docker run -p 8080:8080 -v /root/my_jenkins_data:/var/jenkins_home -u root jenkins/jenkins
    so instead of configuring jenkins from scratch, jenkins will be configured as where we last left it off


---
# DOCKER IMAGES
HOW to create your own image?
- STEPS:-
    1. OS -Ubuntu
    2. Update apt repo
    3. Install dependencies using apt
    4. Install python dependencies using pip
    5. copy source code to /opt folder
    6. Run the webserver using "flask" command

We will create the docker file using these instructions, to create a image. To create an image, dockerFile is necessary.Create DockerFile named Dockerfile and write down the instrucitons for setting up your applications, such as installing dependencies, where to copy the source code from and to, and whats the entrypoint of application is.. 
Once all this done, build your image using the docker build command and specify the docker file as input as well as tag name for the image , this will create image locally on our system. To make it available on public docker hub registry, run the "docker push" command and specify name of image you just created

> docker build Dockerfile -t chirragsapra/my-custom-app
> docker push chirragsapra-my-custom-app
   --- 
   #### DOCKERFILE
   FROM Ubuntu

   RUN apt-get update
   RUN apt-get install -y python

   RUN pip install flask
   RUN pip install flask-mysql

   COPY . /opt/source-code

   ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
   ---

   Dockerfile is a text file written in a specific format, that docker can understand . Its in an instruction and argument format. In dockerfile everything written on left(FROM, RUN, CMD, ENTRYPOINT) is written in caps is called instruction.
   Each of these instructs docker to perform a specific action while creating the image. Everything in right is argument to those isntrucitons(apt-get update, pip install flask) 

   FROM :- defines what the base OS/image should be for this container. Start from base OS or image. every docker image should be based off of another image, either an OS or another image that was created before based on that OS. We can find al offical release of that images on docker hub.
   RUN:- run instructions instructs docker to run a particular command on those base images. like here we are doing apt-get update and installing python and its dependencies on the base image.

   COPY:- copy instruction copies the local file from the local system onto docker image: COPY <src(local)> <destn(base image)>

   ENTRYPOINT:- it allows us to specify a command that will run when the image is run as a container.

   # layered architecture
   when docker builds the images, it build these in a layered architecture. Each line of instruction creates a new layer in the docker image with just changes from the previous. example in our above docker file:-
   Layer 1. :- base ubuntu OS
   Layer 2:- changes in apt packeges
   Layer 3:- changes in pip packages
   Layer 4:- source cide
   Layer 5:- update entrypoint with "flask" command

   > each layer is an image itself, thats why dockerfile creates an multi layer architecture. Each layer is of different sizes.
   > When we run the docker build command, we can see various step involved and result of each task. All the layers built are cached so the layered architecture helps us restart the docker build from that particular step in case it fails, so, if we have to add new steps in the build process we wont have to start all over again, we can create new image from  that build only.
   > as all the layers are cached by docker, so in case any step fails in docker file while doing "docker build", and we fix that step, so in that case the "docker build" again will resume from that step by picking the previous layered image. docker will reuse previous layer from cache and continue to build the remining layer. 
   > Same happens when we  add additional steps in dockerfile. this way rebuilding our image is faster and we dont have to wait for a docker to rebuild the entire image each time. we can containerize everything


## demo docker file | building own docker image
- first test it in ubuntucontainer, than build docker file
    > docker run -it ubuntu bash
      - now inside containaer run those commands
        1. > apt-get update
        2. > apt-get install -y python3
        3. > apt-get install -y python3-pip
        4. > pip install flask
        5. > vi /opt/app.py :- copy the source code here
        6. > cd /opt/
        7. > FLASK_APP=app.py flask run --host=0.0.0.0
        8. as we havent done any port mapping on ubuntu, when we launched ubuntu container so falsk application will be running on <containerIP>:5000 as flask container port is 5000
        <containerIP>:5000/How-are-you

        this is working fine, so we can dockerize this flask application, by pasting same commands in docker file now.
        Now, exit out of the container and create dockerfile
        ---
        Dockerfile

        FROM ubuntu 
        RUN apt-get update
        RUN apt-get install -y python python-pip

        RUN pip install flask

        EXPOSE 8080
        WORKDIR /opt
        COPY app.py /opt/app.py
        ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0
    
    EXPOSE exposes the port to run applicaition
    workdir par laake khda krdega container bante hi
    > docker build .
    > docker build . -t my-simple-webapp :- since the image is already created, it will just give name to that image with the help of tag
    > docker images
    > docker run my-simple-web-app :- as my image is craeetd with this name, we can also map it on port of docker host 

    ## PUSH THAT IMAGE TO DOCKER HUB
    > Pushing image to docker hub, we need one thing, there should be a tag to the image before pushing it to docker hub, 
    
    > docker push my-simple-webapp
        the image will not be pushed becoz  by-default, it pushes the image to docker.io/library as not everybody has permission to push images to that account. so we need to specify the account to push docker image to the docker hub.
        We need to tag that image to our account name for that
    > docker build . -t chirragsapra/my-simple-webapp
        chirragsapra is the account name
    > docker images 
    > docker push chirragsapra/my-simple-webapp
        request can be denied here also, if we are not logged in
        for that use "docker login" command
        > docker login
            and type user name and password and run push command again to push image to docker hub

            ---  ssh setup, docker swarm(multiple docker containers on ubuntu image and enable ssh connectivity between them)
            container par ssh krna hai, with our private keyy. (without using docker exec)
            10 containers, 10 agents hone chye
            docker swarm ko scale up and scale down kr skte h
            Automating the agent setup inside docker file, us image ko use krke container create krege, container up hote hi jenkins ya azure devops p dikhne chye.
            
            Distroless docker containers:- exec 
                shell ka env docker par nahi hai, 
                distroless are utilised in terms of secure images. 


            hub.docker.com :- go distrolles docker images

            1. multistage docker file(particular sequence in docker file).
            2. docker file create krke commands dalte hai


ps commands is in proc folder
bashrc
bash profile


When a container is created using the image built with this Dockerfile, what is the command used to RUN the application inside it :- look for ENTRYPOINT


## Environment variable
suppose we have simple web app in python, which is used to create a webapp that is used to display backgroundcolor. There will be a line that sets the background color, suppose:-
color = "red"         :- inside app.py
However if we decide to change color in future, we have to change the application code and create new docker image out of it, which is a hectic task. So it  is best practice to move such info out of the app code basically to environment variable , so color will be:-
color = os.environ.get('APP_COLOR')

> export APP_COLOR=blue; python app.py

> docker run -e APP_COLOR=blue <image name>
    APP_COLOR here is the environment variable

    we can check the environment variable of the container using "docker inspect command"
    > docker inspect <containerID>
        ENV:[] :- environment variable will be listed here

# to know environment variable defined in container blue-app
> docker run -p 38282:8080 --name blue-app -e APP_COLOR=blue -d kodekloud/simple-webapp
> docker exec -it blue-app env
> docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db mysq


# CMD ENTRYPOINTS and ARguments
Containers are not meant to host OS, they are meant to do some specific task such as host an instance of webserver or to carry out any computational task. Once the task is completed, the container exits.
A container lives only as long as a process lives inside it is alive. If the service/process inside the container stops, the container exits.
Who defines what process is run within the container?
> CMD inside Dockerfile , is called command, that defines the program that will run within the container
> CMD ["nginx"]
    when container starts, it will run the nginx command
> CMD ["mysqld"]
    for mysql image, it is mysqld command
    If container can not find that particular command, it exits
> CMD ["bash"]
    container will run, and it will exit as bash is not a process like webserver or dbserver, it is a shell that listen to input from a terminal, if it can not finds the terminal, it will exit.. 
    When we ran the ubuntu container, docker created a container from ubuntu image and launched the bash program. By default, docker doesnt attach a terminal to a container when it is running, so the bash program doesnot find the terminal and it exits, so container exits as well.
     container will not be able to look out for bash terminal

How to specify different command to start a container?
- append a command to docker run, that way it overrides the default command specified within the image
> docker run ubuntu sleep 30
    container will start, it will run sleep program and waits for 30 seconds and kill the container
    how to make that change permanent?
- Always run the sleep command, when a container starts?
> create an image from ubuntu base image and add "CMD sleep 5" into its docker file
    - we can do this via 2 ways
    1. CMD command param1               :-          CMD sleep 5
    2. CMD ["command", "param1"]        :-          CMD ["sleep","5"]       :- json array format
    in json array format, first element should be the executable, in this case, the sleep program didnt specify the command and parameters together , command and param should be separated in list in json array format
    > docker build . -t ubuntu:sleeper
    > docker run ubuntu:sleeper

    now we will get the same result, it always sleeps for 5 seconds and exits

 What if we want to change time of sleep from that ubuntu sleeper image?
 - docker run ubuntu:sleeper sleep 10           :- not a good approach
    this is not a good approach, becoz sleep command should be invoked automatically.
    thats where ENTRYPOINT instructions come into play
    ENTRYPOINT instruction is like the CMD instructions 

    FROM UBUNTU
    ENTRYPOINT ["sleep"]

    whatever we write while runnning container in command, that command will be appeneded to ENTRYPOINT instruction
    > docker run ubuntu:sleeper 10
        this will sleep the container for 10 seconds before killing it
    in CMD instruction, command line params passed gets replaced entirely, whereas in case of ENTRYPOINT, command line params will be appended.
    > docker run ubuntu:sleeper
    this will throw err, as command line param will be missing, so we can specify default value also for that. in that case we will use both CMD and ENTRYPOINT instruction

    FROM ubuntu
    ENTRYPOINT ["sleep"]
    CMD ["sleep","5"]

    if we dont specify the command line param like:
    > docker run ubuntu:sleeper
        if we didnt specify the param,(both CMD and entrypoint can also run, take a look on internet)it will run CMD instruction as sleep 5, ifwe added the command line param, it will be sleep of thta much duration. means if we dont specify the commad line param, than ENTRYPOINT instruciton will be replaced by CMD instruction, if we did specify, it will override the command instruciton.
        NOTE: for append and override to happen, always specify the instruction in json format

        WHAT IF WE REALLY WANT TO MODIFY SLEEP TIME DURING RUNTIME, 
        > specify the entrypoint option during running container
        > ovderride it by using entrypoint option
        > docker run --entrypoint sleep2.0 ubuntu-sleeper 10
            so command at startup will be :- sleep2.0 10


---
### #########################################
### #########################################
### #########################################
### #########################################
### #########################################
### #########################################
# DOCKER COMPOSE
- Docker compose doesnt get installed by default, we have to install it separately!!!
If we needed to setup a complex application running multiple services, better way to do is to use Docker compose.With docker compose we can create a configuration file with yaml format("docker-compose.yaml") and put together different services and the options specific to those, to running them in this file. Then we can run "docker-compose up" command to bring up the entire application stack.
> docker-compose up  

> docker-compose.yml
    services: 
      web: 
        image: "mmumshad/simple-webapp"
      database:
        image: "mongodb"
      messaging:
        image: "redis:alpine"
      orchestration:
        image: "ansible"

    This is easier to implement, run, and maintain as all changes are always stored in docker-compose configuration file. However, this is all only applicable to running container on a single docker-host.

same thing which we do via "docker run" command can be done via "docker-compose"
- so, lets do it first with docker run 
    NAMING THE CONTAINER IS IMPORTANT, becoz we can link 2 containers to each other.
    1. > docker run -d --name=redis redis
    2. > docker run -d --name=db postgres:9.4
    3. > docker run -d --name=vote -p 5000:80 voting-app
    4. > docker run -d --name=result -p 5001:80 result-app
    5. > docker run -d --name=worker worker

    The problem with above approach is that, we have created all the containers, but we havent actually linked them together.. As in, we havent told the voting web-application to use this particular redis instance. We havent told worker and result-app to use this particular postgresSQL database.
    We solve thie problem with the help of "--links"
    > links is a command line option which can be used to link 2 containers together. Example:- voting app web service is depenedent on redis service.
    > to make voting-app aware of redis service we add a link option while running the voting app container to link it to the redis container.
    > docker run -d --name=vote --link redis:redis voting-app
    > docker run -d --name=<containername> --link <name of container you want to link>:<name of host that voting app is looking for> voting-app
    in above line, voting-app is current contaienr.

    --link option is doing:-link option creates an entry to /etc/hosts file of the voting app container adding an entry with the host name redis with internal IP of redis container. 
    Similary, we add link of the result app to communicate with database by adding link option in result app i.e:-

    > docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
    > docker run -d --name=result -p 5001:80 --link db:db result-app

    Worker application requires access to both postgres and redis database, so we add 2 links to worker applications, one link to link the redis and other link postgres db.
    Links are deprecated, and support will be removed in future.
    >  docker run -d --name=worker --link db:db --link redis:redis worker

    Once docker run commands are tested and ready, it is easy to generate docker-compose file from it

    docker-compose.yml

    redis:
      image: redis
    db:
      image: postgres:9.4
    vote:
      image: voting-app
      ports:
        - 5001:80
      links:
        - redis
    result:
      image: result-app
      ports:
        - 5001:80
      links:
        - db
    worker:
      image: worker
      links:
        - db
        - redis

create those containers with help of
> docker-compose up

# DOCKER COMPOSE BUILD
We assume that all images are already built, but there could be some images which are not built yet, some images may not be uploaded on docker hub(our own application images). Its not necessary that those images are built and available in docker hub repository.
If we would like to instruct Docker Compose to run a Docker Build instead of trying to pull an image, we can replace the image line with a build line and specify the location of a directory which contains application code and docker file with instruction to build the Docker image, 
If we would like to instruct Docker compose to run a docker build instead of trying to pull an image, we can replace the image line with a build line and specify the location of directory which contains the application code and a docker file with instructions to build the docker image.
This time when we run "docker-compose up" command, it will first build the image, gives a temporary name for it and then use that image to run containers using the option we specified before
---

    docker-compose.yml

    redis:
      image: redis
    db:
      image: postgres:9.4
    vote:
      build: ./vote
      ports:
        - 5001:80
      links:
        - redis
    result:
      build: ./result
      ports:
        - 5001:80
      links:
        - db
    worker:
      build: ./worker
      links:
        - db
        - redis
---
> docker-compose up
    this will first build the images from these code, and then give temporary name to those images, than we can use that imagez to run the container on top of it.

# DOCKER COMPOSE VERSION

#### > docker-compose version 1
- example:-
    docker-compose.yml

    redis:
      image: redis
    db:
      image: postgres:9.4
    vote:
      build: ./vote
      ports:
        - 5001:80
      links:
        - redis
    result:
      build: ./result
      ports:
        - 5001:80
      links:
        - db
    worker:
      build: ./worker
      links:
        - db
        - redis

Limitations with Version V1:- If we wanted to deploy containers on different networks, other than the default bridge network , there is no way of specifying that in this portion of file.
    - Also, if we have some dependency or startup order of some kind like our db container must come up first, and only then voting application should be   started, we cant specify that in version 1` of docker compose file

#### Support for these came in version 2
Version 2 and up format of file also changed, we specify our stack information encapsulated under "services" section created at root of the file, and then move all the services underneath that. "docker-compose up" command will be used to bring that up, also we have to specify the version in our compose file in the root section
EXAMPLE:-
    docker-compose.yml
        docker-compose.yml
    version: 2
    services:
        redis:
            image: redis                                    
        db:
            image: postgres:9.4
        vote:
            build: ./vote
            ports:
                - 5001:80
            depends_on:
                - redis
        result:
            build: ./result
            ports:
                - 5001:80
        worker:
            build: ./worker

- NO use of Links: In version 1 of docker-compose , it attaches all the containers to default bridge network and then uses links to enable communication b/w the containers. With Docker-compose Version 2, docker-compose automatically creates a dedicated bridge network for this application and then attaches all the containers to that new network. All containers are then able to communicate with each other using each other's services name. So we dont have to make use of links in version 2 of docker-compose.
- Depends on featuer:- version 2 alaso intruced a depends_on feature, if you wish to specify a startup order, example voting app is dependent on redis service. So ensure that redis container is started first and then only voting web application must be started. 

#### version 3 docker compose
> latest as of today
> version 3 is similar to version 2 with additional support for Docker swarm
(docker stacks)
> we have concept of creating multiple networks in version 3, earlier versions we used to create a default bridge networks, but with version-3 we can create multiple network like front-end network for front-end application and backend for backend applications.

EXAMPLE:-
    docker-compose.yml
        docker-compose.yml
    version: 3
    services:
        redis:
            image: redis    
            networks:
                - back-end                                
        db:
            image: postgres:9.4
            networks:
                - back-end
        vote:
            build: ./vote
            ports:
                - 5001:80
            depends_on:
                - redis
            networks:
                - front-end
                - back-end
        result:
            build: ./result
            ports:
                - 5001:80
        worker:
            build: ./worker
            networks:
                - front-end
                - back-end
    
    networks:
        front-end:
        back-end:

- in version 3 of docker-compose, when we deploy the application, it will automatically create a network for these containers and connect all containers to that networkk or all services that we have specified in this file to that particular network, and that network also takes cares of DNS resolutions. All containers within those applications will be able to connect with each other. So we no longer needs the link section that we have manually specified

> docker-compose up
project name of the docker-compose will be the directory name where we run docker-compose
- network created will be <directoryname>_default
- services it will create will be <directoryname>_<imagename>
- we can also give a custom name, using command line property

---
## ########################################################
## ########################################################
## ########################################################
## ########################################################
## ########################################################
> docker run --name redis -d redis:alpine
> docker run --name=redis -d redis:alpine
- these both command are same


### DOCKER ENGINE

- Docker engine is simply the host, with docker installed on it.
- When we install docker on a linux host, we are installing 3 different components:-
    1. Docker Deamon
    2. REST API
    3. Docker CLI

    These 3 things are composed of docker engine.

    1. Docker Daemon:-
        - Docker deamon is a background process that manages docker objects such as images, containers, volumes and networks. 
    2. REST API Server:-
        - Docker REST API server is the API interface that programs can used to talk to the daemon and provide instructions. We can create our own tools using REST API.
    3. Docker CLI:-
        - Docker CLI is the command line interface that we have been using till now to perform actions such as running a container, stopping containers, destroying images, etc
        - Docker CLI uses REST API to interact with docker deamon. 
        - Docker CLI need not necessarliy be on the same host. It can be on another system like a laptop and still work with a remote Docker Engine, by simply using -H option on the CLI and specify the remote docker engine address and the port:-
            > docker -H=remote-docker-engine:2375
        - example, run a container based on nginx on a remote docker host run the command:-
            > docker -H=<10.123.2.1>:2375 run nginx 

### How applications are containerized in Docker?

> Dokcer uses namspaces to isoolate the workspace. ProcessIds, interprocess communication, network, mounts and unix timesharing systems are created in their own namespace theirby providing isolations between containers.

- NAMESPACE ISOLATION TECHNIQUE
    - PROCESS ID NAMESPACES
        Whenever a linux system bootsup, it starts with 1 process with process id of 1
        PID: 1
        This is the root process and kicksup all the other processes in the system. By the time system boootups completly we have handfull of process running. This can be seen by running the ps command to list all the running processes.
        Process ids are unique and 2 processes can not have same process ID. Now if we are creating a container which is like the childsystem within the current system, child system needs to think it is the independednt system on its own and it has own set of processes originating from a root process with process id of 1. But we know, there is no isolation between the hardware and underlying host. So process runnning inside the container are process running on the underlying host, so 2 processes can not have same process id, this is where namespace came into play.
        - With process id namespaces, each process can have mulitple processs id associated with it, example whena process start within a container its just actually another set of processes on a base linux system and it getsthe next available process id, and they also get process id startting with PID:1 in the container namespace which is only visible inside the container. So the container thinks that it has its own root process tree and so it is an independent system
        - RELATE TO ACTUAL SYSTEM | HOW DO WE SEE THIS ON HOST?
            if we are running nginx server as a container, we know that nginx server runs an nginx service. If we were to list all the service inside the docker container, we see that nginx service is running with a process id of 1. This is the process id of  service inside of container namespace. If we list the service on docker host, we will see same service but with different process id.
            This proves that all processes are running on the same host but separated into their own containers using namespace.
            So we can say that, underlying docker host as well as containers shares the same system resources such as CPU and memory

        - HOW MUCH OF RESOURCES ARE DEDICATED TO THE HOST AND CONTAINERS AND HOW DOES DOCKER MANAGE AND SHARE RESOURCES BETWEEN THE CONTAINERS?
            - by default, there is no restriction as to how much of a resource a container uses and hence a container may - end up utilizing all of the resources on underlying host.
            - There is a way to restrict amount of CPU or memory a container can use.
            - Docker uses "cgroups" or control groups to restrict the amount of hardware resources allocated to each container
            - this can be done by providing the "--cpus" option to docker run command.

            > docker run --cpus=.5 ubuntu

            - providing value of .5 ensures that container doesnot take up more than 50% of CPU of host at any given time.

            > docker run --memory=100m ubuntu

            - Setting value of 100m to "--memory" option limits the amount of memroy a container can use to 100 megabytes.

#### DOCKER STORAGE

- WHERE and HOW DOCKER STORES DATA IN A LOCAL FILE SYSTEM?
- How it manages file systems of the container?

- How docker stores data in local file system
    - When we install docker on system, it creates the folder structure at "/var/lib/docker". We have multiple folders under it
    - /var/lib/docker
        - /aufs
        - /containers
        - /image
        - /volumes
    - this is here docker stores all its data by default, data here file related to images, containers running on docker host. All files related to containers are stored under containers folder, files related to images are stored under images folder. Volumes created by docker containers are stored under volumes folder.

- When docker builds images, it builds these in layered architecture. Each line of instruction in Dockerfile creates a new layer in the Docker image with just the changes from previous layer.
    example:- 1 layer followed by other
- Since each layer is followed by other, it is reflected in size as well

- Advantages of Layered Architecture
    Dockerfile

    FROM ubuntu
    RUN apt-get update && apt-get -y install python
    RUN pip install flask flask-mysql

    > docker build Dockerfile1 -t chirragsapra/my-custom-app
    > docker build Dockerfile2 -t chirragsapra/my-custom-app-2
    Suppose we have 2 applications, and above these 3 layers are same in both of the dockerfile's application, but other layers are same. When I run the docker build command, to build a new image for this application, since the first 3 layers of all the applications are same, Docker is not going to build the first 3 layers twice as for one of the application docker has already build the first 3 layers.
    - instead of building the first 3 layers again, it reuses the same 3 layers it built for first application from the cache and only creates the last 2 layers with the new sources and new entrypoint. This way, docker build images faster and efficiently saves disk space. 
    - this is also applicable, if we were to update the application code. Whenever we update the applicaiton code Docker simply reuses all the previous layers from the cache and quickly rebuilts the application image by updating the latest source code, thus saving a lot of time, during rebuilds and updates.


    LAYER6:     CONTAINER LAYER | read and write layer


    LAYER5: Update entrypoint with "flask" command.             |
    LAYER4: Source code.                                        |
    LAYER3: Changes in pip package                              |           IMAGE LAYER(read only)
    LAYER2: Changes in apt package                              |
    LAYER1: Base Ubuntu Layer                                   |

    - All of these layers are created when we run docker build command to form the final docker image. So this is docker image layer
    > docker build Dockerfile -t chirragsapra/my-custom-app

    - Once the build is complete, we cannot modify contents of these layes and so they are read-only , so we can only modify them by initiaing a new build 

    > docker run chirragsapra/my-custom-app
    
    - When we run a container based off this image, docker creates a container based off of these layers and create a new writtable layer on top of image layer. The writtable layer is used to store data created by container, such as log files written by applications, any temporray file generated by container or just any file modified by user on that container. the life of this layer is only long as the container is alive, when container is destroyed, this layer and all of the changes stored in it are also destroyed. 
    Same image layer is shared by all containers created using this image

    ## COPY ON WRITE MECHANISM
    - If we create a new file in a container created from this image, it will be stored in temporary Container layer which is read and write layer,
    - since we bake our code(app.py) in image, that code is part of image layer
    - so, does it mean that we can not modify this source code file(app.py) inside the container? its not true
    - We can still modify this file , but before I save the modified file, Docker automatically creates the copy of the file in read-write layer and I will be then modifying the different version of the file in the read-write layer. All future modifications will be done on the copy of the file in read-write layer. This is called copy-on-write mechanism


    ### VOLUME MOUNTING 
    > Volume mount, mounts the volumes directory.
    - All the data that was stored in container layer gets deleted in case the container is destroyed. Change we made in app.py and temp file will also be deletd. 
    - HOW TO PRESIST THAT DATA?
         - We can add a PRESISTENT VOLUME to the container, first create volume using docker volume command

         > docker volume create data_volume
            IT creates a folder "data_volume" under "/var/lib/docker/volumes" directory

            TO MOUNT THIS VOLUME TO DOCKER CONTAINER RUN:

        > docker run -v data_volume:/var/lib/mysql mysql
            we are mounting this volume inside the docker'container read-write(image layer) using "-v" option
            Even is the container is destroyed, data is still active

            WHAT IF WE DIDNT RUN "docker volume create" command, before  DOCKER RUN command

        > docker run -v data_volume2:/var/lib/mysql mysql
            data_volume2 directory is not yet created, Docker will automatically create a volume named data_volume2 and mount it to the container

            see those volumes 
             > ls /var/lib/docker/volumes

    ### BIND MOUNTING
    > Bind mount, mounts the directory from any location on the docker host
    - We can also store the data that is at another location or at some external storage on docker host,

        > docker run -v /data/mysql:/var/lib/mysql mysql
            it will create a container and mount the folder to the container

    ### NOTE 
     - Using "-v" option is old way. "--mount" option is the preferred way as it is more verbose so we have to specify each paramteter in a key value format

     > docker run \
        --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql

        type can be bind or 
        source:- source location on my host
        target:- location on my container

    # docker uses storage driver to enable layered architecture
    Some of common storage drivers are:- AUFS, ZFS, BTRFS, device mapper, overlay, overlay2.
    Selection of storage driver is based on OS.
    for ubuntu default storage driver is AUFS


> docker run -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql
>docker run -v /opt/data:/var/lib/mysql -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql


# DOCKER NETWORKING

When we install docker, it creates 3 network automatically
1. bridge
2. none
3. host
If we want to specify another network, we have to specofy the container while running it using "--network" option

> docker run Ubuntu --network=none
> docker run Ubuntu --network=host

1. Bridge:- a default network a container gets attached to. Bridge is internal private network created by docker on the dockerhost. All containers attached to it bydefault gets an internal IPusually in the range "172.17 series".
 Containers can access to each other using those internal IPs. To access any of these containers from outside, map the ports of these containers to port of docker host. 
 Another way to access the container externally is to associate the container to the <host network>



2. host network:-
    Host network takes out any network isolation b/w docker host and docker container, meaning if you were to run webserver on port 5000 in web container, it is automatically accessible on the same port externally without requiring port mapping, as the web container uses the hosts network. This would also mean that unlike before we will not be able to run multiple web containers on same host on same port, as port are now common to all containers in the host network

3. NONE NETWORK:-
    With none network containers are not attached to any network and doesnot have any access to external network or other containers; they run in an isolated network


By default docker only creates one internal bridge network, we can create our own internal network using the command :-
> docker network create \
  --driver bridge \
  --subnet 182.18.0.0/16 custom-isolated network

> docker network ls

  Use case of this command:- If multiple containers are using bridge network,  there will be bridge network for different containers

> docker inspect <contianer id>
    we can see Networks section there
>docker network inspect bridge

All container can talk to each other using name of container becoz if we use container IP, container IP will be changed at time of restart:-
    > mysql.connect( webapp )
Docker has builtin DNS server, that helps the container to resolve each other using the container-name. Builtin DNS always runs at address <127.0.0.11>


Docker uses network namespaces that creates separate namespace for each container. It then uses virtual ethernet pairs to connect containers together




> docker run --name alpine-2 --network=none alpine

> docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network
> docker network inspect wp-mysql-network

> docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db --network wp-mysql-network mysql:5.6

---
Deploy a web application named webapp using the kodekloud/simple-webapp-mysql image. Expose the port to 38080 on the host.

The application makes use of two environment variable:
1: DB_Host with the value mysql-db.
2: DB_Password with the value db_pass123.
Make sure to attach it to the newly created network called wp-mysql-network.


Also make sure to link the MySQL and the webapp container.
> docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp --link mysql-db:mysql-db -d kodekloud/simple-webapp-mysql


## docker registry
> Central repository of all docker images.

> docker run nginx
    this imagesd is pulled from docker regisrty and naming convention is:- nginx/nginx
    image:- docker.io/nginx/nginx

    registry is where all the images are stored
    Docker hub, Cloud registry, Internal private regisrty

> docker login private-registry.io/apps/internalapps

we also have image for docker private registry naming registry
> docker run -d -p 5000:5000 --name registry registry:2
we can push iamges to this registry as:
    > docker image tag my-image localhost:5000/my-image
    > docker push localhost:5000/my-image

    this image is in docker host only, so we also can pull the image from the local host if we are on same host 
    > docker pull localhost:5000/my-image
    OR ip or domainname of my docker host if i am accessing from another host in my environment
    > docker pull 192.168.56.100:5000/my-image

---
DockerHub is a hosted registry solution by Docker Inc.

Besides public and private repositories, it also provides:
automated builds,
integration with source control solutions like Github and Bitbucket etc.
---et practice deploying a registry server on our own.
Run a registry server with name equals to my-registry using registry:2 image with host port set to 5000, and restart policy set to always.

Note: Registry server is exposed on port 5000 in the image.


Here we are hosting our own registry using the open source Docker Registry.
> docker run -d -p 5000:5000 --restart=always --name my-registry registry:2
---
Now its time to push some images to our registry server. Let's push two images for now .i.e. nginx:latest and httpd:latest.


Note: Don't forget to pull them first.

To check the list of images pushed , use curl -X GET localhost:5000/v2/_catalog
:- Run: docker pull nginx:latest then docker image tag nginx:latest localhost:5000/nginx:latest and finally push it using docker push localhost:5000/nginx:latest.
We will use the same steps for the second image docker pull httpd:latest and then docker image tag httpd:latest localhost:5000/httpd:latest and finally push it using docker push localhost:5000/httpd:latest
---
Let's remove all the dangling images we have locally. Use docker image prune -a to remove them. How many images do we have now?

Note: Make sure we don't have any running containers except our registry-sever.

To get list of images use: docker image ls
---
Now we can pull images from our registry-server as well. Use docker pull [server-addr/image-name] to pull the images that we pushed earlier.

In our case we can use: docker pull localhost:5000/nginx
---
Let's clean up after ourselves.
Stop and remove the my-registry container

Use: docker stop my-registry and then docker rm my-registry
--- 