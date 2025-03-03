> Docker is used for containerizing the application.
> Run each service with its own dependencies in separate containers.

## WHAT ARE CONTAINERS?
> Containers are completely isolated environments, as in they can have their own processes or services, their own network interfaces, their own mounts, just like virtual machines except they all share the same OS kernel.
Diff types of containers are LXC, LXD, LXCFS, etc
> Docker utilizes LXC containers.
> Setting up these container env  are hard, as they are very low level and thats where docker offers a high level tool with several powerful functionalities, making it really easy for end user like us. 
> we wont be able to run Windows based container on Docker host with linux on it, for that we require docker on windows host
> unlike hypervisors, docker is not meant to virtualize and run different operating system and kernel on same hardware.
> Main purpose of docker is to package and containerize application, and to ship them and run time anywhere, anytime, as many times as you want.

> container run with libraries and dependencies.

### containers vs virtual machines
    > OS on hardware, Docker installed on OS, and containere running on top of Docker. In case of virtual machines, we have the hypervisors installed on top of hardware, and than virtual machine on top of hypervisros like Esx.Each VM has its on OS inside it, and then dependencies and than the application. VM containes higher disk space as they are heavy and the utilization is also more, 
    in case of containers, they are light weight images, and requires less h/w utilization.
    Docker has less isolation, as more resource are shared between the container likekernel, whereas VMs has complete isolation from each other.

# IMAGE
an image ia a packet or template(like a VM template). It is used tocreate one or more containers. Image is like an executable file to run containers. We can create our own image and push it to docker hub repo making it available for public
# Containers
> Containers are running instances of images that are isolated and have their own environments and set of processes


> docker ps -aq
    will list container id of all the containers(exited, runnning, all)
> docker rm $(docker ps -aq)
    remove all docker containers at once
> docker images -q
    will list id of all images
> docker rmi $(docker iamges -q)
    will remove all images at once
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

   Syntax :- docker run -p <Host Port>:<Container Port> <image name>
   > docker run -p 80:5000 <image name>
> docker run mysql
    the data file are stored in location /var/lib/mysql inside the docker container.


Syntax:- docker run -v <volume inside/attached to docker host>:<container data storage> <image name>

Syntax:- docker run -v <directory inside docker host>:<directory inside docker container> <image name>

> docker run -v /opt/datadir:/var/lib/mysql mysql
> docker inspect <container name or container ID>
    it returns all the details of a container in json format, such as the state, mount, configuration data, network settings, etc

## see log of container we ran in background
> docker logs <container name or container ID >

### ############################################## 
### ############################################## 
### ############################################## 
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
###

> docker build Dockerfile -t chirragsapra/my-custom-app
> docker push chirragsapra-my-custom-app

   ENTRYPOINT:- it allows us to specify a command that will run when the image is run as a container.
When a container is created using the image built with this Dockerfile, what is the command used to RUN the application inside it :- look for ENTRYPOINT

How to specify different command to start a container?
- append a command to docker run, that way it overrides the default command specified within the image
> docker run ubuntu sleep 30



  > docker run -d --name=<containername> --link <name of container you want to link>:<name of host that voting app is looking for> voting-app



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


     > docker run \
        --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql

> docker run -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql
>docker run -v /opt/data:/var/lib/mysql -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql








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