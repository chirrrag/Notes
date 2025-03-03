### written by Chirag Sapra ###



> echo "hello"
    echo cmd is used to print line of text of string
> echo -n Hello
    will print echo in without trailing line afterwards.
> uptime
    gives info about how long the system has been running for since the last reboot.

> type echo
> type mv
    to determine if a command is internal or external, use the "type" command.

> pwd
    print working directory
> ls
    list contents
> mkdir Asia
    make directory
> mkdir Europe Africa America
    make multiple directories
> ls
> cd Asia
    change directory
> mkdir China India
> mkdir India/Mumbai
    to create directory Mumbai inside India
> mkdir -p India/Mumbai
    to create directory India and mumbai && Mumbai inside India
> cd ..
    go one step back
> cd or cd /home/miachel
    go to home


> pushd /etc
    will change to etc directory, same as cd
    > cd usr
    > cd bib
> popd
    will get back to home directory
    when we run popd, the last pushed directory comes out first,


> mv /home/miachel/city.txt /home/miachel/Africa
    move files from source to destination.
    mv <src file/directory> <destination directory>
    mv is also used for renaming file or directory
> mv Asia/India/Munbai Asia/India/Mumbai

> cp src dest
    copy file/directory from src to destination
> cp Asia/India/Mumbai/city.txt Africa/Egypt/Cairo

> rm <file/directoy name>
    remove file or directory
> rm Europe/UK/London/tottenham.txt


<! NOTE>
    To copy or delete a directory using CP or RM, we have to used "-r" option which is called recursive...
> cp -r Europe/UK Europe/UnitedKingdom
> rm -f Europe
    -r is called recursive option.

> cat city.txt
    to view content of files
> cat > city.txt
    to add content into the file city.txt, you can add any data into it, and then exit and save by CTRL + D


> touch country.txt
    will create a new file "country.txt"



# PAGERS
> we can view content of file using pagers like more or less command.
> more city.txt
    view file content in scrollable manner, and shows entire file, which is not good.
    [SPACE]:- scrolls the entire display
    [ENTER]:- scrolls display one line at a time.
    [b]:- scrolls entire display backwards
    [/]:- search texts
    [Q]:- exit

> less city.txt
    view content of file and navigate through it
    up arrow, down arrow, and [/] to search

> ls -l
    long list 
> ls -a 
    view hidden files or directories
    hidden files are precceded by "."
> ls -ltr
    long list in reverse order created.

> whatis <arguments>
    this command tell what that command does, 
    whatis date
> man <command>
    this will also tell what that command does
> date -h  OR date --help
> apropos <command keyword>
    this command will search all the man pages and will display the keyword of instances of all the commands
    > apropos modpr

> echo $SHELL
    to see default shell
> chsh
    to change the shell

> alias dt=date
> export CHRAG=SAPRA
> echo $CHRAG
> echo $LOGNAME
> echo $PATH
    to see the directories defined in path variable, we must use echo $PATH
> which kubectl 
    will give path of that command
> export PATH=$PATH:<path>
    to add any software or package into path
> echo $PS1

>PS1="UBUNTUSERVER"
> now our default prompt will be ubtuntusever


# kernel

> uname
    to display info about kernel
> uname -r OR uname -a
    print kernel version
> udemadm monitor
    listens to kernel uvents
    print device path and device name on screeen
    info of newly attached or removed device
>lspci
    list pci devices configured in system
> lsblk
    list info about block devices
> lscpu
    display components about CPU architecture
> lsmem --summary
    lsit available memroy in the system
> free -m
    same command to see info about memory
    -m in MB
    -k in KB
    -g in GB
> lshw 
    tool to extract detailed information in entire hardware configuration of the machine., it can report exact memory configuration, firmware version, mainboard configuration, CPU version and speed, cache configuration


> LINUX BOOT SEQUENCE OVERVIEW
    BIOS POST  > BOOT LOADER(GRUB2:- grand unified bootloader version 2) > KERNEL INITIALIZATION > INIT PROCESS(systemd)
    bios post:- power on self test,bios runs a post test to check hardware compnents attached to devices are functinaing properly. IF post fails, computer maynot be available, system will not go to second stage to boot process.
    Boot loader:- aftr successful post test, bios executes boot code from boot device which is located in first sector of hardisk, in linux this is located in /boot file system. boot loader provides user with boot screen often with multiple options to boot into such as ubuntu, once selection is made, boot loader loads kernel into memroy and hands over control to kernel.
    KERNEL initilaization:- after kernel is laoded into memory it decomproesses as kernel are generally in compress state to conserve space. Kernel is thenloaded into memory and starts executing. During this phase kernel carry out task, such as memory managemtn. once it is complettely operational kernel looks for an init process to run which sets up the userspace and process needed for user environment.
    than init function than calls the systemd deamon , systemd is responsible for bringing linux host to usable state, systemd is responsible for mounting file system, managingsystem services. systemd is universal standard these days

    > check init system used command:-
    > ls -l /sbin/init



> file <filename>
    will tell type of file in linux(file, directory, special files)


# FILE SYSTEMS
> /home:- home directory for all users except root user
> /root :- root user home directory is located here
> /opt:- install any 3rd party progs here
> /mnt :- mounts file system here temporarliy in system
> /tmp :- used to store temporary data
> /media:- USB drives are mounted here, all external media are moutned here
> df -hP
    prints out all the information about all mounted file systems.
> /dev:- contains special block and character systems here
> /bin :- basics programs such as cp, mv, mkdir are stored here
> /etc :- to store most of configuration files here
> /lib or /lib64 :- is place to look for shared libraries to be imported in your program.
> /usr :- location where all user land application and their data 
> /var:- to store logs under file system 


> sudo lshw


# Package
    a package is a compressed archive that contains all the files that are required by particular software to run.


# RPM PACKAGE MANAGER

### install package
> rpm -ivh telnet.rpm
    i:- install
    v:- verbose
### uninstall package
> rpm -e telnet.rpm
### upgrade package
> rpm -Uvh telnet.rpm
### to query about package
> rpm -q telnet.rpm
### to verify package
> rpm -VF <path to file>

> yum and rpm in centos
# rpm doesnot sort paakcge dependency on its own, thats why we use YUM(yellowdog updater modified)
> /etc/yum.repos.d

> yum install httpd
> yum repolist
    will show all the repos added to linux system.
> yum provides scp
    which package should be isntalled for particular command to work.
to remove a package :-
    > yum remove httpd

update single package:-
    > yum update telnet
to update all package in system:-
    > yum update



# FILES
> du -sk <filename>
    size of file in KB
> du -sh <filename>
    size of file in human readable format
    du stands for disk usage
> ls -lh <filename>
    we can also see size here

# tar 
> it means, tape archive
> tar -cf test.tar file1 file2 file 3
    > -c means to archive a file, 
    > -f means file name representing
    > file1 file2... are files which will be archived

> tar -tf test.tar
    to see content of a tarball file
> tar -xf test.tar
    use to excract conent from the tarball.
> tar -zcf test.tar file1 file2 file3
    -z option to compress tarball to reduce its size
> zcat /usr/share/man/man1/tail.1.gz | tee /home/bob/pipes
    to see content of file without unextracting
> compressing a file, use command :- gzip, bzip2, xz
> uncompressing those file :- use guizip, bunzip2, unxz respectively.



# SEARCHING FOR FILES AND DIRECTORIES
1. > locate city.txt 
    file name as argument, it will return all path matching to the pattern. it will not locate recently created file becoz db mightnot be updated.
    to update the db, run command as root user:
> updatedb
    then run locate command again

2. use find command
    > find /home/Chirag -name city.txt
        use find along with directory in which you want to search 

3. GREP
    to search within files, we can use grep command
    > grep second sample.txt
    grep command is case sensitive
    to search insensitive, use grep "-i" flag
    > grep -i second sample.txt 
    > grep -r "third line" /home/miachel
        it can be used to search the pattern within a directory recursively, when we dont know which file contains the specific pattern
    > grep -v "sample" second.txt
        -v prints the line of file which dont match the pattern.    
    > grep -w exam example.txt
        -w will match the exact word in grep command.
    > grep -vw exam example.txt
    > grep -A1 Arsenel example.txt
        this will print the line matching "Arsenel" and one line immediately below
    > grep -B1 Arsenel example.txt
        this will print the line matching "Arsenel" and one line immediatly above.
    > grep -A1 -B1 Arsenel example.txt
        we can match these two flags together like this


# IO REDIRECTION
> There are 3 data streams created when we launch a linux command.
    1. Standard input :- cat sample.txt
    2. Standard output :- output of cat
    3. Standard error :- error from cat

Standard input output, err can be redirected to text files 

> redirect stdout
    > echo $SHELL  > shell.txt (> overrides)
    > cat shell.txt 
    > echo $SHELL >> shell.txt (>> appends)

> redirect err messages
    > cat missing_file 2> error.txt ("2> " ->     redirects err messages)
    > cat  missing_file 2>> error.txt 

> command executes and not put err messages on screen, even if there is some error
    > cat missing_file 2> /dev/null

# COMMAND LINE PIPES
    pipes allow the first command to standard out to be used as the standard input for the second command. 
    > grep Hello sample.txt | less

    > echo $SHELL | tee shell.txt
    > echo "this is a shell" | tee -a shell.txt

# to check default editor
> update-alternatives --display editor

> ping <ip>
    to check the connectivity on between 2 servers
> ping db
    this will only work, when we add entry into /etc/hosts file
> cat >> /etc/hosts
    "8.8.8.8   db"
> ping <ip>
> curl <ip>
> ssh <ip>
    these 3 commands, it looks into /etc/hosts file to find out IP address of the hosts. Translating hostname to IP address is called name-resolution.
    PING is not good for dns resolution, coz maybe ping is blocked by other host.. instead use nslookup

    these /etc/hosts file is difficult to manage in case of large ips, what if the ip changed?
    so we use DNS resolution, as nameserver, 
    so we have the file:
> /etc/resolv.conf
> cat /etc/nsswitch.conf
    for updating entries to nslookuop, so that it searches hosts to first /etc/hosts file and than etc/resolv.conf file

> nslookup google.com
    to query a hostname from a DNS server
    nslookup doesnot consider entries in local /etc/hosts file
> dig google.com 
    dig is also same as nslookup, but it gives more detail


#  NETWORKING BASICS
1. Switch:
    switch can only communicate within a network, (2 computers talk to each other via switch)
    to talk to them, first get the eth0 with the helo of command.
    > ip link
    (to lsit and modify interfaces on host)
    then add each other ip address into each other
    > ip addr
        (to see the ip addresses assigned to those interfaces)
    > ip addr add 192.168.1.1/24 dev eth0
    (use to set ip addr on interface)
    then we can ping each other system
    > ping <other ip>
2. Router:
    router helps connect 2 networks together
    think of it as another server with many network ports
    > route
        to checck kernel's routing table
3. Gateway is used to connect 2 system from diff network
    > ip route add 192.168.2.0/24 via 192.168.1.1
    to connect 2 systems
    
    to connect your system with internet, add route
    > ip route add 172.1.1.1/24 via 192.168.1.1
    OR 
    > ip route add 0.0.0.0 via 192.168.1.1
    OR 
    > ip route add default via 192.168.1.1

all these changed made in netowrking basis are persitent till system restart, we should set them in /etc/network/interfaces file
 >ip route
 or > route
    these commands are use to view ip tables
> ip route add
    used to add entries in routing table

> sudo ip link set dev eth0 up  
    to make eth0 working 
> traceroute <ip>
    this will show us number of devices betwwen the source
> netstat 
    can be used to print info of routing table, network connections, and several other network tactics

# for network security we use iptables and firewalld

# SECURITY IN LINUX
> each user has a unique UID in linux
> information about a user is stored in /etc/passwd
> A linux group is a collection of users, we organize users on common attributes such as role or function.
> info about users is stored in /etc/group file
> Each group has unique identifier called GID
> a user can be assigned to multiple group, if it is not asssigned, by default GID will be the UID of the user, thats primary GID of user
> User account also store info about home directory of the user, and default shell.
Account type:-
1. user account
2. root/superuser
3. system account
4. service account
--- 
> id Chirag_Sapra
    it lists UID, GID, username and groups the user is part of
> grep -i Chirag_Sapra /etc/passwd
    to check home directory and default shell assigend to user we use
---    
> SuperUser is the account root, which has the UID 0
> Superuser has unrestriced access and control of the user incxluding other user.
---
> system account are created usually during OS installation. These are used by softwares and services which are not run as super user. 
There UID is genrally between 500 to 1000 OR <100.
> UID for system account is usually under 100 or between 500, 1000. 
> They usually donot have home directory, if they have the home directory is not created under /home
>  ecxample: - sshd and mailuser


> service account are similar as system account and are created when services are installed in linux, example nginx service makes use of service account called nginx
---
> who 
    see list of users who are currently logged in into system
> last
    displays list of all loggedin users, along with date and time when system was rebotted

### switching users
1.  > su -
        not recommended, as needs passwd of user
    better way to do is make use of sudo
    > sudo apt-get install nginx

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





# LINUX FILE PERMISSIONS
> ls command can also be used to tell file type, first letter can tell the file type in "ls -l"
> d :- directory
> - :- regular file
> c :- character device
> l : link
> s :- socket file
> p :- pipe
> b :- block device

- rest "rwx" are file permissions in linux
- OWNER GROUP OTHERS
- READ 4
- WRITE 2
- EXECUTE 1

### DIRECTORY PERMISSIONS
- READ 4
- WRITE 2
- EXECUTE 1
- "-" NO PERMISSION :- 0

> in linux, the system identifies the user trying to access the file or directory and checks permissions sequentially, If user tries to access the owner than the owner permissions are applied and rest is ignored. Similarly, if user is not owner but part of the group only the group permissions are applied, and others are ignored

### to change permissions of the file
> chmod <permissions> file_name
> chmod u+rwx test-file  OR chmod 777 file
    Provide full access to the owner
> chmod ugo+r-x test-file 
    Provide read access to owner, group and other removes execute process.
> chmod o-rwx test-file
    Remove all access for users
> chmod u+rwx,g+r-x,o-rwx test-file
    full access for owner, add read, remove execute for group and no access for others.

### change ownership and group
> chown <owner>:<group> <file>
> chown bob:developer test-file 
    Changes owner to bob and group to developer 
> chown bob app.apk 
    changed owner of the file, group unchanged

### ONLY GROUP CAN BE CHANGED
> chgrp android test-file
    changed the group for test file to group called android

## SSH
> login to remote computer via hostname or ip addr
    > ssh <user>@<hostname> OR IP ADDR
> remote server must have ssh running and port 22 enable from client end
> ssh-keygen -t rsa
    creates a key pair on client

# SCP
> stands for secure copy
 > scp allows us to copy data over ssh
 > you can copy files or directories and any other service which you have ssh access
 > as long as we can ssh to webserver we can copy the files
 > scp /hopme/bob/chirag.tar devapp01:/home/chirag

 > we shud have write file to destination, else scp will fail.
 > to copy instead of files, use "-r" option
 > scp -pr /home/bob/media devap01:/home/bob
 >ssh-copy-id bob@devapp01
    to copy key

# IP TABLES 
> network security using ip tables.
> iptables and firewalld are tools for network security in linux based and firewalls in windows based servers.
> how to implement local iptable rules and secure our servers in a linux environment.
> these rules will allow us to filter network traffic within our OS
> sudo apt install iptables
    install iptables.
> sudo iptables -L
    list default rules configured in system
we will see 3 types of rules/chains configured bydefault.
INPUT, FORWARD and OUTPUT.
> INPUT CHAIN is applicable to network traffic coming into the system.
> OUPUT CHAIN is responsible for connection initiated by this server to the other systems
> FORWARD CHAIN is typically used in network routers where the data is forwarded to other devices in the network.(not commonly used in linux servers)
> since we havent added any rules, default policy will tend to accept, means all traffic is allowed in and out of the system
> by chain, we means chain of rules as each chain have multiple rules. Each rule performs the check and accepts or drops the packet based on condition.
> example:- first rule will accept req from client one, but second rule will drop that request from client2
> under rules, we can also forward the traffic to other port. 

> iptables -A INPUT -p tcp -s 172.1.1.1 --dport 22 -j ACCEPT
    > -A :- addrule
    > -p :- protocol
    > -s :- source
    > -d :- Destination
    > --dport:- destination port
    > -j :- Action to take

> TO SEE THE NEW RULE LISTED
> iptables -L 
> lets drop the traffic:-
> iptables -A INPUT -p tcp --dport 22 -j DROP

> iptable rules work from bottom to top, rule written at top will be considered in case of multiple rule for same client as it executes from bottom to top

> to insert rule on top of chain use optin "-I"
> iptables -I OUTPUT -p tcp --dport 443 -j ACCEPT
> TO DELETE A RULE
> iptables -D OUTPUT 5 
    rule will be deleted which is written at number 5.
>sudo iptables -A OUTPUT -p TCP -d 172.16.238.11 --dport 5432 -j ACCEPT



# CRONJOB
> WE CAN SCHEDULE OUR TASK TO RUN EVERYTIME ON PARTICULAR TIME IN AUTOMATED MANNER, date/time/frequencey is set for the task
> this functionality is enabled by crond service, that runs in background.
> to schedule a job, run the command "crontab -e" with user you want to run the command. 
 > crontab -e
 > after this command, it will open crontab in vi editor.
 > add configuration of job to be scheduled at particular time everytiome
 >  * * * * * <commandtorun> 
 > dont use sudo for cron, else job will be scheduled for root user.

 > <minute hour day month weekday>
  > * means any value, 
  if on weekday we apply "*", it means every day of week it shud eun
  > */2 * * * * <commandtorun> 
    this job will run after every 2 mins
> crontab -l
    to list all the jobs for cron
# to verify our job is running fine we can check logs
> cat /var/log/syslog
> crontab -l | wc -l

> */30 * * * * /usr/local/bin/system-debugger.sh
    this job will run every 30 mins

# SYSTEMD AND SERVICES
    ## 
> to run, any script in background, we will define that script as service. for that, we will create a service unit file under "/etc/systemd/system/<file_name.service>
> tools we use:- systemctl, journalctl
> file extension will be ".service"
> command need to run in background will come inside "ExecStart=/bin/bash /usr/bin/project-mercury.sh"
> to run this service in background, use command 
    > systemctl start project-mercury.service
    > we have to use sudo this time, as service is set to run by root user by default
    TO CHECK THE STATUS OF SERVICE
    > systemctl status project-mercury.service
    > we can enable this service to run during boot, for tht we need to stop this service first 
    to stop:-
    > systemctl stop project-mercury.service
    > now to use that service, under this we shall use, 
    use the WantedBy directive, whose value should be systemd target or run level you want to enable for it.
    > [INSTALL]
    > WantedBy graphical.target
    > grapohical.target is our run levelwhich we want

    to add service account to be used instead of root, use add another directive under the service section
    > [SERVICE]
    > User=projet_mercury

    > we can now build on this, and add couple of more directories based on requirements.
    > use the restart directive which defines how and when to restart the service
    > Restart=on-failure
    > Restartsec=10
    it means, wait for 10 second when system attempts to restart it

    finally, with systemd service events are automatically logged. so this requirement is automatically taken of without adding any configuration

    > if our application depends on any service,we can define the dependency to make sure our service is ready only after postgres database is ready which can be a dependency.

    > [Unit]
    > Description=python django framework
    > Documentation=init opr link
    > After=postgresql.service

    now to restart the service, run 
    > systemctl daemon-reload
    > systemctl start project-mercury.service


# SERVICE MANAGEMENT
> 2 COMMANDS:- systemctl, journalctl
1. Systemctl
    > systemctl is the main command, used to manage services on a systemd-managed server.
    > used to manage service such as start, restart, stop, reload and enable or disable a service during system boot.
    > also used to view information about state and manage state.
    # commands
    1. > systemctl start docker
            to start a service.
    2. > systemctl stop docker
            to stop a service
    3. > systemctl restart docker
            restart the service 
    4. > systemctl reload docker
            reload the service without interrupting system functionallity
    5. > systemctl enable docker
            to enable a service and make it persistent across reboot
    6. > systemctl disable docker
            to disable a service during boot, use this commadn
    7. > systemctl status docker
            to check info about state of the service.
            states are:- active, inactive, and failed
    8. > systemctl daemon-reload 
            - run this command after making changes to a service unit file, reload the system manager configuration and make the systemd aware of these changes.
            - a running service whose unit file has been updated on disk can only be restarted after running the systemctl daemon-reload command, we can also make changes to the unit file using systemctl edit command
    9. > systemctl edit <filename.service> --full
            editing the file this way, changes get applied easily without having to run daemon-reload
    10. > systemctl list-units --all
            to list all the units, systemd has loaded or attempted to laod use the systemctl list-units command, this prints all units which are active, inactive, failed or in-transistent state
    11. > systemctl list-units 
            this will only print active services    

2. journalctl
    > this command can query the contents of systemd logging system called journal and is a convineint troubleshooting tool to figure out those issues, such as service failures.
    > journalctl is useful when troubleshooting issues with systemd units as it checks the journal or log entries from all parts of system.
    1. > journalctl
            prints all the log entries from oldest entries to the new ones
    2. > journalctl -b
            see the logs from current boot 
    3. > journalctl -u <UNIT example:- dockerd.service>
            > journalctl -u dockerd.service
            to see log entries for a specific units, such as dockerd.service run it with -u flag with name of unit as argument .



###
### ___________________________________________________________
# STORAGE IN LINUX

> block devices are type of file, that can be found under /dev directory. It usually represent piece of hardware that can store data. HDD and SSD are also block storage in linucx. It is called block storage becoz data is read,  written into it in blocks or in chunks of space.
    > ls -l /dev/ | grep "^b"
            we can do ls -l in /dev/ directory and look for file that has "b" as first character
    > lsblk
            - see list of block devices in system.
            - "sda" represents entire disk.
            - sda1, sda2 devices are of type part, these are disk partition 
            - each block device has major and minor number
            - major number is used to identifty type of block device, value 8 represents "scsi" device, which has fixed naming convention that starts with "sd".
            - 1 is for RAM, 3 for HDD or CD rom, 6 for parallel printers.

            - Minor numbers
            - minor number are used to distinguish physical or logical devices in this case, identiy the whole disk and partition created
            - entire disk can be broken down into smaller segments of usable space called partition
            - Concept of paritioning allows us to segment space and use each partition for a specific purpose, if you inspect result of "lsblk" command, sda3 partition are used for root partition("/")
            - sda2 parition is mounted at "/media/MM/Data" which is used to store backup in the system
            - sda1 is consumed as system partition mounted at /boot/EFI which is used during system boot process and contains the bootloaders to install the OS
            - it is not necessary to make parition ofdiska, we can use it without partition
            - information about partition is saved in partition table.
            - lsblk is one such command to view partition table
        > sudo fdisk -l /dev/sda 
            - this command it used to list partition table information and can also be used to create and delete parition.
        > fdisk -l 
            - to print partition table, it will print quite similar to lsblk command, and also provides additional information such as partition type used, size of disk in bytes and sectors

    ## PARTITION TYPES
    1. primary partition
    2. extended partition
    3. logical partition

    1. primary partition
        - this parition can be used to boot the operating system. earlier disk were limited to not more than 4 primary partition per disk
    2. extended partition
        - this partition can not be used on its own but can host logical parition
        - an extended parition is like a disk drive in its own right . It has a partition table that points to one or more logical partition
    
    with restriction to have maximum 4 primary parition, we can have an extended partition and care multiple logical partitions into it    

    3. logical partitions
        - they are those which are created within an extended partition

    HOW A DISK IS PARTITIONED IS DEFINED BY ITS PARTITIONING SHCEME ALSO CALLED PARTITION TABLE.
## MBR PARITIONING SCHEME 
   - stands for master boot record(more than 30 years)
   -  there can only be 4 primary partitions in mbr
   - max size per disk is 2TB
   - if we want morethan 4 partition per disk, we will be creating 4th partition as extended partition and carve out logical parition into it
## GPT PARTITIONING SCHME
   - STANDS FOR  GUID partitioning table
    - more recent partitioning scheme, that is created to addressed the problem of MBR
    - it can have unlimited number of partitions per disc(theoritically) , as RHEL only allows 128 partitions per disc.
    - additionally, disk size limitation of 2TB doesnt exist with GPT
    - GPT is best choice as compared to MBR 

    ## create partitions
    > gdisk /dev/sdb
        - gdisk command with device path as argument
        - gdisk is improved version of fdisk that works with GPT partition table
        - use "?" to print all available options 
        - type "n" to create a new partition
        -  type "l" to see all prossible values of hexcode and parition table numebring
        - once you provide necessary information, use the W command to write the parition table     
    to check the paritioning status, run lsblk or fidsk  -l command or using gdisk -l command as well
    > sudo fdisk -l /dev/sdb

# FILE SYSTEMS
- Partition alone in a disk doesnt make a disk useable in OS. Disk and partition are seen by the linux kernel as a raw disk.
- To write to a disk/partition, we must create a file system
- File system defies how data is stored in a disk.
- After creating a file system, must mount it to a directory, and than only we can read or write data to it.
- EXT2, EXT3, EXT4

- both ext2, and ext3 allow a max file size of 2TB and max vol size of 4TB. both filesystem do great job for reliably storing data. Difference between ext2 and ext3 is that in case of unclean shutdown such as one caused by poweroutage, it can take quite sometime for the system to boot backup. EXT3 FS didnot has this drawback, it implemented additional features that allowed quicker startup after ungraceful shutdown. EXT4 further improves EXT3 FS and still is one of most common general purpose filesystemused today. It can now support 16TB of max file size and upto 1 Exabyte of vol size. BOth ext4 and ext3 are backward compatible. EXT4 FS can be mounted as ext3, or ext2 FS, and similarly an ext3 FS can be mounted as ext2 FS
- EXT2 does not use a journal and hence has longer recovery boot time.

    ### create file system
    - > mkfs.ext4 /dev/sdb1
            > run this command with device path as argument, this will create a file system, once this is complete, the FS can be mounted on system using mount command
    - > mkdir /mnt/ext4;
    - > mount /dev/sdb1 /mnt/ext4
            > we can verify whether the file system is mounted either by using mount command or by using df command shown below :- 
                > 1. mount | grep /dev/sdb1
                > 2. df -hP | grep /dev/sdb1
             > The mount is not persistent in FSTAB yet. If the system is rebooted, the filesystem will not be mounted. to make the mount available after the system reboots, add an entry to /etc/fstab
             > - /etc/fstab
                > Entry here will be
            > echo "/dev/sdb1 /mnt/ext4 ext4 rw 0 0" >> /etc/fstab
                > entries here are:-
                > - file system :- /dev/fstab
                > - mountpoint :- /mnt/ext4
                > - type of filesystem:- ext4
                > - Options such as:- rw(read,write) OR ro(readonly)
                > - Dump:- 0(ignore), 1(take backup)
                > - Pass:- 0(ignore), 1 or 2(FSCK filesystem check enforced)

                Dump number here is used to indicate whether to backup the file system or not. 1 for enabling backup, and 0 for disabling
                Pass number here is prioty set for file system check tool to determine the order  in which file system should be checkedduring the boot after the crash. 0 means to ignore the file system check.
                1 is max, is set for root file system
    > sudo blkid /dev/vdc
        to check type of filesystem used.

    ### COMMONLY USED EXTERNAL STORAGE
    ### DAS, NAS and SAN    
    > DAS:- Direct attached storage
    > NAS:- Network attached storage(similar to NFS server)
    > SAN:- Storage area nework(this technology uses fiber channel for providing high speed storage)

    > DAS
        WITH DAS:- external storage is attached directly to the host system that requies space. Host operating system sees the connected desk device as teh blockdevice. There is not network and firewall between storage and hosts, means excellent performance at affordable price. 
        DAS has faster response than NAS device, as in NAS data traffic goes over network.
        DAS is directly attached, so it is dedicated to single server, so not good for enterprise env where we have multiple server and need multiple storage and is more suitable for small businesses.
        DAS:- block storage, fast and reliable, affordable, dedicated to single host, ideal for small business
    > NAS
        NAS is suitable for mid to large business, NAS is network atqached storage which means NAS storage are are generalluy located far from the hosts that will consume space from it. 
        Data traffic b/w storage and host is through network.
        NAS is a file storage device(not a block storage device).
        Storage is provded to the host in form of directory or a share that is physically present in the NAS device, but exported by NFS to the host.
        Ideal for centralized storage that needs to be accessed simultaneously by several different host. The performance of NAS and high speed ethernet connectivity b/w 2 can provide goodd performance and HA storage soln. NAS can be used as backend storage for web servers or application servers and can even run databases, not recomended for prodction workload.NAS is not recommended storage to install operating system.
        NFS/CIFS
        reasonably fast and reliable,  file based storage, shared storage, not suitable for installing OS.
    > SAN
        Storage Area Network
        SAN provides block storage used by enterprisesfor business critical applications that need to deliver high throughput and low latency.
        Storage is provided to hosts in form of LUN(logical Unit number). LUN is range of block provisioned from a pool of shared storage and presented to server as the logical disk.
        Host system will detect the storage as the raw disk, we can than create partitin and FS on top of it and mount it on system with data(as we do with other block devices).
        SAN can also be ethernet based and it mainlymakes use of FCP(fiber channel protocol). High speed data transfer protocol that makes use of fiber channel switch to establish communicatiion with the host.
        Host server makes use of HBA/ Host bus adapter which is connected to PCI slot to interface with fiber channel swoitch. Main adv of SAN over NAS is it can be used to host mission-critical application and databases due to its vastly superior performance and reliability. These include installing oracle databases or microsoft SQL DB using it for virtualixation deployment such as VMWARe, KVM
        FC  or ISCSI, block storage, (fast, secure and reliable), high availability, expensive.

    ## NFS
        NETWORK FILE SYSTEM
        NFS doesnt store data in blocks, it saves data in form of files. NFS works on server client model. Term for directory sharing in NFS is called exporting. We can mount NFS to "/mnt/software/repositories" so that path will acts as storage.
        NFS servers maintains an export configuration file at "      /etc/exports" that defines the client should be able to access the directories on the server
        the configuration here on nfs server will look like this
        > /etc/exports
        > /software/repos <ip/hostname OfClient1> <ip/hostname ofClient2> ...
        here /software/repos is mount path in client laptop
        hostname can be replaced by ip or hostname of client or "*" for loads of clients
        > there should be a network firewallbetween the NFS server and the clients as a result, specific ports may have to be opened b/w server and client for NFS solution to work.
        > once the /etc/exports has been uplodaed to server, the directory is shared by client by using "export-fs" command
    > export-fs -a
        this command, exports all the mounts defined in /etc/exportsfile.
    > export-fs -o <clientIP>:/software/repos
        this allows us to manually exports a directory, once exported we can mount it on a directory using mount command on client side.
    > mount <IP of NFS>:/software/repos  /mnt/software/repos
        > make a note of source file system used in mount command, it is the ip or hostname of nfs server followed by directory of the server that we exported separated by a cloumn. Network share should now be mounted on the clients
    

    ## LVM
    Logical Volume manager
    LVM allows us to group multiple physical volumes together, which are harddisk or partitions, from this volume groups we can carve out logical volumes.
    LVM allows us to resize volumes dnyamically as long as there is sufficient space in the volume group,
    > apt-get install lvm2
    first step to create LVM, is to identify free disk or partitions and than creates physical volume objects for them.
    A physical volume object is how LVM identifies a disk or partition. It is also called PV
    > pvcreate /dev/sdb
        to create physical volume out of a disk or partition. once this is created, we can create a volume group using VG.
    > vgcreate caleston_vg /dev/sdb
        a volume group can have one or more physical volumes
    > pvdisplay
        list details about physical volumes
    > vgdisplay
        list display about volume groups
    we can create logicl volumes from these volume groups
    > lvcreate -L 1G -n vol1 caleston_vg
        create logial volume from this command
        L option means linear volume, this option enables us to use multiple physical volume if availablein volume group to create a single logical volume 
    > lvdisplay
        to see logical volume
    > ls
        to list the volumes

    once the vol is created, we can create FS on type of it using mkfs command and mount it
    > mkfs.ext4 /dev/caleston_vg/vol1
    > mount -t ext4 /dev/caleston_vg/vol1 /mnt/vol1

    resize the file system on vol1 while it is mounted, to do this first check whether there is enoguh space in VG
    > vgs
        to list vg and their details
    > lvresize -L +1G -n /dev/caleston_vg/vol1
        increase the volume by another 1 gb, specofy path of logical volume and additional size too
        If you check the size of vol1, using df command, we will see that it is still at 1GB capacity.
    > df -hP /mnt/vol1
        this is becoz only the logical vol has been resized, but not the FS we created on it, to resize the FS. make use of resize2fs command
    > resize2fs /dev/caleston_vg/vol1
        once this command is run, the file system created inside the logical volume will be resized as wellto match the size we specified with the LV create command.
    > we donto have to stop or unmount the file system while redsizing, resizing can be done on the flywhile the FS is in use.
    > df -hP /mnt/vol
        running this command will show now vol size as 2GB, but this will show the diff path of volume ie /dev/mapper/caleston_vg.vol1 on this path it is mounted.

        NOTE:- the logical volume/ LVM are accessible at 2 places 
        1. /dev/caleston_vg/vol1
        2. /dev/mapper/caleston_vg.vol1


> lsblk
    size of vol or use pvdisplay
> sudo vgcreate caleston_vc /dev/vdb /dev/vdc
    create vol groups from these 2 physical volumes
> sudo vgremove caleston_vc
    remove vg
> sudo lvcreate -L 1G -n data caleston_vg   
    create new logicl volume

    ## create ext4 file system and mount it on .mnt.media, of name data
    sudo mkdir /mnt/media
sudo mkfs.ext4 /dev/mapper/caleston_vg-data
sudo mount /dev/mapper/caleston_vg-data /mnt/media/


### Add 500M to the logical volume called data.


Do not unmount the filesystem.
sudo lvresize -L +500M -n  /dev/mapper/caleston_vg-data

sudo resize2fs  /dev/mapper/caleston_vg-data

> shutdown now :- to shutdown the system
> shutdown -r now :- restart

# check the OS in which you are working
> cat /etc/*release*