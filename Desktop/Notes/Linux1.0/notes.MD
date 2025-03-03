# Linux Shell
> Linux shell is a program, that allows text based interaction between the user and the OS.

## HOME DIRECTORY
> when we login to shell, very first directory which we are taken to is a home directory.
> /home/chirag :- 
/ home is a system created directory that contains the home directory for all user in linux systems.

### WHY HPME DIRECTORY?
> Each user in the environment gets its own unique home directory with complete access to it(retrieve, delete, store), home directory helps users to store personal data in form of files and directories.
> HOME DIRECTORY command line prompt:- "~"


## ARGUMENTS
> arguments acts as input to the command, 
> echo "hello"
> here "hello" is input/argument of echo command.


## OPTIONS
> commands also has option that modify its behaviour in some predetermined way.
> option is also called switch or flag
> single letter precedded by single hyphen
> example ''' echo -n "hello" '''


# TYPES OF COMMANDS
1. Internal/Built-in commands
> internal commands are part of shell itself bundled. total of 30 such commands.
    ex:- echo, cd, pwd, set, export, mkdir

2. External Commands
> external commands are binary programs or scripts which are usually located in distinct file in  system.
    ex:- mv, date, uptime, cp, etc

# ROOT DIRECTORY
> denoted by "/"
> top most directory in linux
# ABOSULTE PATH
> absolute path is location of file where directory is starting from root directory. 
> example:- cd /home/miachel/Asia

# RELATIVE PATH
> location of file from present working directory
> ex:- cd Asia


## PUSHD/POPD COMMAND
> Alternative to cd
> this command remembers the working directory, before changing the directory specified in the command argument.
> pushd /etc 
> once this is changed, the user may change directories anytime. to return back to original directory, use the "popd" command.
> popd 
> We can push many directories to stack as we can and pop back when we required. 
> when we run popd, the last pushed directory comes out first.

# KERNEL
kernel is heart of operating system, core interfere between computer hardware and its processes. communicates between 2 resources as efficiently as possible.
memory management(how much memory is used to store, where and what), processmanagement(determines which process can use the CPU, when and how long), 
DeviceDrivers(Acts as mediator between hardware and processes )
Systemcalls and security(receive request for service from the process )

linux kernel is monolithic, it means it handles the memory management, kernel is also modular



all these changed made in netowrking basis are persitent till system restart, we should set them in /etc/network/interfaces file
 >ip route
 or > route
    these commands are use to view ip tables
> ip route add
    used to add entries in routing table

> traceroute <ip>
    this will show us number of devices betwwen the source
> netstat 
    can be used to print info of routing table, network connections, and several other network tactics

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

- OWNER GROUP OTHERS
- READ 4
- WRITE 2
- EXECUTE 1