## ACCESS CONTROL FILES
> most of access control files are stored under /etc directory. this directory can be read by any user bydefault, only root user can write it
1. /etc/passwd :- this files contains basic info about users in system(username, UID, GID, home directory, default shell)
    > grep -i ^bob /etc/passwd
    > output :- USERNAME:PASSWORD:UID:GIDL:GECOS:HOMEDIR:SHELL
2. /etc/shadow :- passwd are stored in this file
    > grep -i ^bob /etc/shadow
    > output:- USERNAME:PASSWORD:LASTCHANGE:MINAGE:MAXAGE:WARN:INACTIVE:EXPDATE
3. /etc/group :- stores info of all user groups on system, such as GID or members, groupnames
    > grep -i ^bob /etc/group
    > output :-
    > NAME:PASSWORD:GID:MEMBERS

###
> traceroute <ip>
    this will show us number of devices betwwen the source
> netstat
    can be used to print info of routing table, network connections, and several other network tactics

###
14. How do you check system resource usage in Linux?
— Answer: System resource usage can be checked using commands such as `top`, `htop`, `free`, and `df`. These commands provide information about CPU usage, memory usage, and disk space usage respectively.
20. How to find the status of the process?
Ps ux command user for find status of process.
 
21. How to check memory status?
Free command is useful for checking memory status.
 
22. How to debug a shell script?
To debug a shell script we execute the script with the “-x” or “-nv”  option.
 
24. What is the difference between $! and $$?
$! Shows process id of the process that recently went into background
$$  gives the process id of the currently executing process

# DOCKDER

- HOW MUCH OF RESOURCES ARE DEDICATED TO THE HOST AND CONTAINERS AND HOW DOES DOCKER MANAGE AND SHARE RESOURCES BETWEEN THE CONTAINERS?
            - by default, there is no restriction as to how much of a resource a container uses and hence a container may - end up utilizing all of the resources on underlying host.
            - There is a way to restrict amount of CPU or memory a container can use.
            - Docker uses "cgroups" or control groups to restrict the amount of hardware resources allocated to each container
            - this can be done by providing the "--cpus" option to docker run command.
 
            > docker run --cpus=.5 ubuntu
 
            - providing value of .5 ensures that container doesnot take up more than 50% of CPU of host at any given time.
 
            > docker run --memory=100m ubuntu
 
            - Setting value of 100m to "--memory" option limits the amount of memroy a container can use to 100 megabytes.


> docker run -v /data/mysql:/var/lib/mysql mysql
            it will create a container and mount the folder to the container
 
    ### NOTE
     - Using "-v" option is old way. "--mount" option is the preferred way as it is more verbose so we have to specify each paramteter in a key value format
 
     > docker run \
        --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql
 
 
 

 
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

> in CMD instruction, command line params passed gets replaced entirely, whereas in case of ENTRYPOINT, command line params will be appended.

> Let's remove all the dangling images we have locally. Use docker image prune -a to remove them. How many images do we have now?

#           ####################################################

ERRORS
 

JENKINS

	1. 128:- NO credentials

	2. 401, 403 :- wrong credentials

	3. 137:- OOM

	4. Docker/maven not found :- tools which we are trying to use is not available(installed in machine, but not defined in pipeline) or not installed.

 

GIT

	1. 128:- NO credentials

	2. 401, 403 :- wrong credentials

	3. not enough space available

	4. push file err:- size of file very large to push(fix: increase post buffer size)

	5. merge conflicts

	NOTE:- instead of using user and passwd, use user and tokens

 

SONARQ

	1. -DSonar.ProjectKey (herre K shud be capital) or projectName (N should be capitla)

	2. token, url should be connect

	in java project:- DSonar.java.binaries :- 

	3. not reachable err:- check wheteher sonar app is running or not

	4. 500 :- restart and check it is running or not

	5. memory issue:- wont funciton well in case of errors


kubectl run nginx --image nginx
> kubectl get pods

 
 
> echo $SHELL

    to see default shell
> chsh

    to see type of shell

> runlevel

        runlevel 3:- bios mode :- multiuser.target

        runlevel 5:- graphical mode :- graphical.target

        operates your system in other mode ex nongraphical mode
> systemctl get-default

        to get default runlevel
> sudo systemctl set-default multi-user.target


1. > locate city.txt 

    file name as argument, it will return all path matching to the pattern. it will not locate recently created file becoz db mightnot be updated.

    to update the db, run command as root user:
> updatedb

    then run locate command again

 

2. use find command
> find /home/Chirag -name city.txt

        use find along with directory in which you want to search 

# to check default editor
> update-alternatives --display editor

 
> traceroute <ip>

    this will show us number of devices betwwen the source
> netstat 

    can be used to print info of routing table, network connections, and several other network tactics

DEFAULT configuration of sudo is defined under /etc/sudoers file. Users which are present in this file are allowed to use sudo command.

 
> grep -i ^root /etc/passwd

    eliminate the need for login to root user directly

    no one can login to shell as using root user using passwd directly

 
 

## ACCESS CONTROL FILES
> most of access control files are stored under /etc directory. this directory can be read by any user bydefault, only root user can write it

1. /etc/passwd :- this files contains basic info about users in system(username, UID, GID, home directory, default shell)
> grep -i ^bob /etc/passwd
> output :- USERNAME:PASSWORD:UID:GIDL:GECOS:HOMEDIR:SHELL

2. /etc/shadow :- passwd are stored in this file
> grep -i ^bob /etc/shadow
> output:- USERNAME:PASSWORD:LASTCHANGE:MINAGE:MAXAGE:WARN:INACTIVE:EXPDATE

3. /etc/group :- stores info of all user groups on system, such as GID or members, groupnames
> grep -i ^bob /etc/group
> output :-
> NAME:PASSWORD:GID:MEMBERS


# MANAGING USERS

1. > useradd Chirag

        to create new local user in the system(run as sudo)
> grep -i Chirag /etc/passwd

        Chirag user is generated withsystem generated UID and GID.
> grep -i Chirag /etc/shadow

2. > passwd Chirag

        to set password for Chirag(run as sudo)

3. > whoami

        who is the user
> passwd

        new user can change password by running password command.

4. > useradd -u 1009 -g 1009 

        create user with custom uid and gid

5. > userdel Chirag

        to delete a user 

6. > groupapp -g 1011 developer

        to add new group into our account with -g for custom groupiid

7. > groupdel developer

        to delete a group

8. > sudo grep -i bob /etc/sudoers

        to check bob permission

9. > sudo useradd -u 1010 -g 1010 -s /bin/bash john

 
> DEFAULT configuration of sudo is defined under /etc/sudoers file. Users which are present in this file are allowed to use sudo command.
> traceroute <ip>
    this will show us number of devices betwwen the source
> netstat
    can be used to print info of routing table, network connections, and several other network tactics


2. What is sticky bit ?
	By setting sticky bit the directory owner allows other users and groups to add files to the directory but prevent users from deleting each others files in that directory.
	
	at the directory level, it restricts file deletion. Only the owner (and root) of a file can remove the file within that directory. A common example of this is the /tmp directory:
6. What is load average ? Does load average 2 is ok ? 
	Load is the measure of the amount of computational work a system performs. The three values is the load average over a time interval. The intervals are, the last 1 minute, 5 minutes, and 15 minutes.
	
	For a multi-core system like a quad processor it is ok but for a single core system it means 200% utilized which is overload.
8. Purpose of /etc folder 
	System wide config files are present in etc
	E.g. /etc/passwd  /etc/hosts /etc/ssh/sshd_config
9. How to terminate process
	using top, ps, pidof, or pgrep commands. Once the process you wish to terminate is located, you can use the killall, pkill, kill, xkill, or top commands to end it. 
	
	kill [signal] PID
	kill -9 1212
11. What is INODE 
	An inode is a data structure that keeps track of all the files and directories within a Linux or UNIX-based filesystem
12. How to run command in background 
	Using & at the end of the command
	For e.g. --> tar -czf home.tar.gz . &
19. How to make user sudo?
	sudo usermod -aG sudo [name-of-user]

76. What is the difference between ext2 and ext3 file systems?
  • The ext3 file system is an enhanced version of the ext2 file system.
  • The most important difference between ext2 and ext3 is that ext3 supports journaling.
  • After an unexpected power failure or system crash (also called an unclean system shutdown), each ext2 file system must be checked for consistency by the e2fsck program. This is a time-consuming process and during this time, any data on the volumes is unreachable.
  • The journaling provided by the ext3 file system means that this sort of a file system check is no longer necessary after an unclean system shutdown. The only time a consistency check occurs while using ext3 is in certain rare hardware failure cases, such as hard drive failures. The time to recover an ext3 file system after an unclean system shutdown does not depend on the size of the file system or on the number of files. Rather, it depends on the size of the journal used to maintain consistency. The default journal size takes almost a second to recover, depending on the speed of the hardware.

10. How to reduce or shrink the size of the LVM partition?
Below are the logical steps to reduce the size of the LVM partition:
	• Unmount the file system using the unmount command
	• Use the resize2fs command as follows:
	1	resize2fs /dev/mapper/myvg-mylv 10G
	• Then, use the lvreduce command as follows:
	1	lvreduce -L 10G /dev/mapper/myvg-mylv
This way, we can reduce the size of the LVM partition and fix the size of the file system to 10 GB.
 
76. What is the difference between ext2 and ext3 file systems?
	• The ext3 file system is an enhanced version of the ext2 file system.
	• The most important difference between ext2 and ext3 is that ext3 supports journaling.
	• After an unexpected power failure or system crash (also called an unclean system shutdown), each ext2 file system must be checked for consistency by the e2fsck program. This is a time-consuming process and during this time, any data on the volumes is unreachable.
	• The journaling provided by the ext3 file system means that this sort of a file system check is no longer necessary after an unclean system shutdown. The only time a consistency check occurs while using ext3 is in certain rare hardware failure cases, such as hard drive failures. The time to recover an ext3 file system after an unclean system shutdown does not depend on the size of the file system or on the number of files. Rather, it depends on the size of the journal used to maintain consistency. The default journal size takes almost a second to recover, depending on the speed of the hardware.
 
17. DifferentiatebetweenCOPYandADDcommandsthatare used in a Dockerfile?
Both the commands have similar functionality, but COPY is more preferred because of its higher transparency level than that of ADD .
COPY provides just the basic support of copying local files into the container whereas ADD provides additional features like remote URL and tar extraction support.

12. Whatcommandcanyouruntoexportadockerimageasan archive?
This can be done using the docker save command and the syntax is: docker save -o <exported_name>.tar <container-name>
13. Whatcommandcanberuntoimportapre-exportedDocker image into another Docker host?
This can be done using the docker load command and the syntax is docker load -i <export_image_name>.tar
This can be done using the docker save command and the syntax is: docker save -o <exported_name>.tar <container-name>

14. DOCKER -- exit code 137, means we kill the container

6. Write the difference between Soft and Hard links?
Hard Links: It is a special kind of file that points to the same underlying inode as another file. It can be referred to as an additional name for an existing file on Linux OS. Total number of hard links for a file can be displayed using the “ls -l” command. Such links cannot be used across file systems. Hard links can be created using the following command: 
$ ln [original filename] [link name] 
Soft Links: It is also termed a symbolic Link. Soft links are kinds of files that usually point to another file. It does not include any amount of data in the target file and simply points to another entry anywhere in the file system. Such links can be used across file systems. Soft links can be created using the following command: 
$ ln -s [original filename] [link name] 


## ##############################################################

 
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
 
 
 
## ##############################################################

368
# echo "##vso[task.setvariable variable=AWS_DEFAULT_REGION]${{parameters.AWS_REGION}}"
            # echo "##vso[task.setvariable variable=AWS_ROLE_ARN]${{parameters.AWS_ROLE_ARN}}"
            # echo "##vso[task.setvariable variable=ACCOUNT_ID]${{parameters.ACCOUNT_ID}}"
# export ACCOUNT_ID=${{parameters.ACCOUNT_ID}}
            # export AWS_DEFAULT_REGION=${{parameters.AWS_REGION}}
            # export AWS_ROLE_ARN=${{parameters.AWS_ROLE_ARN}}
            # export AWS_AUTH_PATH=$(Build.SourcesDirectory)/scripts/aws-auth.sh

terraform supports state locking functionality in 
 
S3, consul, azurerm
 
provider must be initialized and it must be declared within the configuration
 
By default, fmt scans the current directory for configuration files. If the dir argument is provided then it will scan that given directory instead
 
there can be multiple manual changes, which can not be reflected at the state file
 
terraform state show aws_eip.ip to show some details of particular resource
 
 
terraform refresh me terraform configuration file ki need nahi hoti actively.
 
The registry extracts information about the module from the module's source. The module name, provider, documentation, inputs/outputs, and dependencies are all parsed and available via the UI or API, as well as the same information for any submodules or examples in the module's source repository.
 
Terraform Cloud and Terraform Enterprise manage and share sensitive values, and encrypt all variable values before storing them.
 
 
