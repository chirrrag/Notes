• What is the name and the UID of the administrator user?
• How do you list all files, including hidden ones, in a directory?
• What is the Linux command to remove a directory and its contents?
• What do the following commands do, and how would you use them?
• tee
• awk
• What is localhost and why would ping localhost fail?
• What is the similarity between “ping” & “traceroute” ? How is traceroute able to find the hops.
• What command or commands can be used to show all open ports and/or socket connections on a machine?
• What is a dynamically linked file?
• A careless sysadmin executes the following command: chmod 444 /bin/chmod. How would you fix this?
• You’ve lost the root password. What would you do?
• I’ve rebooted a remote server, but after 10 minutes, I’m still not able to ssh into it. What could be wrong?

1. What is $0 in Linux terminal?
The $0 is one of the special variables you get in bash and is used to print the filename of the script that is currently being executed. The $0 variable can be used in two ways in Linux: Use $0 to find the logged-in shell. Use $0 to print the name of the script that is being executed.

2. What is the $1 command in Linux?
In a bash script or function, $1 denotes the initial argument passed, $2 denotes the second argument passed, and so forth. This script takes a name as a command-line argument and prints a personalized greeting. echo "Hello, $1!"


11. What is Swap Space?
Swap Space is the additional spaced used by Linux that temporarily holds concurrently running programs when the RAM does not have enough space to hold the programs. When you run a program, it resides on the RAM so that the processor can fetch data quickly. Suppose you are running more programs than the RAM can hold, then these running programs are stored in the Swap Space. The processor will now look for data in the RAM and the Swap Space. 
Swap Space is used as an extension of RAM by Linux.

13. What command would you use to check how much memory is being used by Linux?
You can use any of the following commands:
	• free -m
	• vmstat
	• top
	• htop

15. Explain file permission in Linux.
There are 3 kinds of permission in Linux:
	1. Read: Allows a user to open and read the file
	2. Write: Allows a user to open and modify the file
	3. Execute: Allows a user to run the file.
You can change the permission of a file or a directory using the chmodcommand. There are two modes of using the chmod command:
	1. Symbolic mode
	2. Absolute mode

Symbolic mode
The general syntax to change permission using Symbolic mode is as follows:
$ chmod <target>(+/-/=)<permission> <filename>
where <permissions> can be r: read; w: write; x: execute.
<target> can be u : user; g: group; o: other; a: all
'+' is used for adding permission
'-' is used for removing permission
'=' is used for setting the permission
For example, if you want to set the permission such that the user can read, write, and execute it and members of your group can read and execute it, and others may only read it.
Then the command for this will be:
$ chmod u=rwx,g=rx,o=r filename
Absolute mode
The general syntax to change permission using Absolute mode is as follows:
$ chmod <permission> filename
The Absolute mode follows octal representation. The leftmost digit is for the user, the middle digit is for the user group and the rightmost digit is for all.
Below is the table that explains the meaning of the digits that can be used and their effect.
0	No permission	– – –
1	Execute permission	– – x
2	Write permission	– w –
3	Execute and write permission: 1 (execute) + 2 (write) = 3	– wx
4	Read permission	r – –
5	Read and execute permission: 4 (read) + 1 (execute) = 5	r – x
6	Read and write permission: 4 (read) + 2 (write) = 6	rw –
7	All permissions: 4 (read) + 2 (write) + 1 (execute) = 7	rwx
For example, if you want to set the permission such that the user can read, write, and execute it and members of your group can read and execute it, and others may only read it.
Then the command for this will be:
$ chmod 754 filename


16. What are inode and process id?
inode is the unique name given by the operating system to each file. Similarly, process id is the unique id given to each process.

18. Which are the Linux Directory Commands?
There are 5 main Directory Commands in Linux:
pwd: Displays the path of the present working directory.
Syntax: $ pwd
ls: Lists all the files and directories in the present working directory.
Syntax: $ ls
cd: Used to change the present working directory.
Syntax: $ cd <path to new directory>
mkdir: Creates a new directory
Syntax: $ mkdir <name (and path if required) of new directory>
rmdir: Deletes a directory
Syntax: $ rmdir <name (and path if required) of directory>


23. Explain grep command.
Grep stands for Global Regular Expression Print. The grep command is used to search for a text in a file by pattern matching based on regular expression.

Syntax: grep [options] pattern [files]
Example:
$ grep -c "linux" interview.txt
This command will print the count of the word “linux” in the “interview.txt” file.


25. Explain the ‘ls’ command in Linux
The ls command is used to list the files in a specified directory. The general syntax is:
$ ls <options> <directory>
For example, if you want to list all the files in the Example directory, then the command will be as follows:
$ ls Example/
There are different options that can be used with the ls command. These options give additional information about the file/ folder. For example:
-l	 lists long format (shows the permissions of the file)
-a	 lists all files including hidden files
-i	 lists files with their inode number
-s	 lists files with their size
-S	 lists files with their size and sorts the list by file size
-t	 sorts the listed files by time and date

3. What is a Zombie Process?
A Zombie Process is a terminated process that still has an entry in the process table. It occurs when a process finishes execution, but its termination status is not yet retrieved by its parent process. Zombie processes consume minimal resources and are automatically cleaned up by the operating system once the parent process reaps them.


4. Why /etc/resolv.conf and /etc/hosts files are used?
The `/etc/resolv.conf` and `/etc/hosts` files are used in Unix-like operating systems, including Linux, to handle network-related configurations and name resolution.
5. `/etc/resolv.conf`:
   – The `/etc/resolv.conf` file is used to configure the Domain Name System (DNS) resolver on the system. DNS is a system that translates human-readable domain names (e.g., www.example.com) into IP addresses (e.g., 192.168.1.1) that computers can understand.
   – The `resolv.conf` file contains information about DNS name servers that the system should use to resolve domain names. It specifies the IP addresses of one or more DNS servers to be queried for name resolution.
 – When a user or application on the system tries to access a website or connect to a remote server using a domain name, the system consults the `resolv.conf` file to find the DNS servers to use for name resolution.
	1. `/etc/hosts`:
   – The `/etc/hosts` file is a simple text file that maps IP addresses to hostnames. It serves as a local DNS lookup table for the system, allowing users to define hostname-to-IP address mappings without relying on external DNS servers.
   – Entries in the `hosts` file are typically used to override or supplement the DNS resolution provided by external DNS servers.
   – When a user or application on the system tries to access a domain name, the system first checks the `hosts` file for a corresponding entry. If a match is found, the system uses the IP address specified in the `hosts` file, bypassing the need to query external DNS servers.
Both files play critical roles in name resolution and network configuration. The `/etc/resolv.conf` file is primarily used for configuring the system’s DNS resolver settings, while the `/etc/hosts` file is used for local hostname-to-IP address mappings, providing a way to customize name resolution behavior on the local system.


1. How to copy a file in Linux?
You can use the cp command to copy a file in Linux. The general syntax is:
$ cp <source> <destination>
Suppose you want to copy a file named questions.txt from the directory /new/linux to /linux/interview, then the command will be:
$ cp questions.txt /new/linux /linux/interview


4. How to write the output of a command to a file?
You can use the redirection operator (>) to do this.
Syntax: $ (command) > (filename)
5. How to see the list of mounted devices on Linux?
By running the following command:
$ mount -l
6. How to find where a file is stored in Linux?
You can use the locate command to find the path to the file.
Suppose you want to find the locations of a file name sample.txt, then your command would be:
$ locate sample.txt
7. How to find the difference in two configuration files?
You can use the diff command for this: 
$ diff abc.conf xyz.conf


10. How to reduce or shrink the size of the LVM partition?
Below are the logical steps to reduce the size of the LVM partition:
	• Unmount the file system using the unmount command
	• Use the resize2fs command as follows:
	1	resize2fs /dev/mapper/myvg-mylv 10G
	• Then, use the lvreduce command as follows:
	1	lvreduce -L 10G /dev/mapper/myvg-mylv
This way, we can reduce the size of the LVM partition and fix the size of the file system to 10 GB.


29. Why is Linux regarded as a more secure operating system than other operating systems?
Linux has become more popular in the technology industry in terms of security. There are several reasons why Linux is more secure than other operating systems.
	• On Linux, only a few people have access to the system. As a result, the virus cannot infect the entire system but it may affect only a few files.
	• Before opening the files, Linux users must first complete the tasks, so that they can protect their systems against flaws.
	• The Linux operating system includes a variety of working environments, including Linux Mint, Debian, Arch, and others, all of which include virus protection.
	• It keeps a log history so that it may quickly see the specifics of the system files afterward.
	• Iptables is a Linux feature that examines the system’s security circle.
	• As Linux users are comparatively fewer in number as compared to other operating systems, security will be enhanced.


31. How can you enhance the security of the password file in Linux?
It is in the test file named ‘/etc/passwd’ that Linux usually keeps its user account details, including the one-way encrypted passwords. However, this file can be accessed with the help of different tools, which might throw security issues.
To minimize this risk, we will make use of the shadow password format that saves the account details in a regular file /etc/passwd as in the traditional method but with the password stored as a single ‘x’ character, i.e., it is not the original password that is actually stored in this file. Meanwhile, a second file /etc/shadow will have the encrypted password, along with the other relevant information, such as the account/password expiration date, etc. Most importantly, the latter file is readable only by the root account, and thus it minimizes the security risk.
To enable shadow password use the command: pwconv


32. What are the three standard streams in Linux?
In Linux, standard streams are channel communication of input and output between a program and its environment. In the Linux system, input and output are spread among three standard streams which are:
	1. Standard Input (stdin)
	2. Standard Output (stdout)
	3. Standard Error (stderr)



37. Why should you avoid Telnet to administer a Linux system remotely?
Telnet uses the most insecure method for communication. It sends data across the network in plain text format, and anybody can easily find out the password using the network tool.

It includes the passing of the login credentials in plain text, i.e., anyone running a sniffer on the network can find the information he/she needs to take control of the device in a few seconds by eavesdropping on a Telnet login session.

46. What is logical volume management (LVM), and what advantages does it offer?
Logical volume management (LVM) in Linux provides an abstract layer above physical disks or partitions. This gives administrators the ability to dynamically allocate storage space from a pool of storage resources. Key advantages of LVM include easier resizing of logical volumes, simplified storage provisioning, efficient disk snapshots for backups, and flexible data migration as storage needs change. Overall, LVM introduces welcome storage flexibility for Linux systems.


54. What are the different types of modes in VI editor?
The VI editor (Visual Editor) is a basic text editor that appears in most Linux distributions. The following are the main varieties of modes usable in the VI editor:
Command Mode/Regular Mode: The default mode for vi editors is Command Mode/Regular Mode. It is typically used to view and write instructions that perform special or unique vi tasks. 
Insertion Mode/Edit Mode: You may use this Insertion mode to edit text or insert text into a file. You can also delete the text. 
Ex Mode/Replacement Mode: Ex mode is commonly used for file saving and command execution. We can overwrite the text in this mode.


76. What is the difference between ext2 and ext3 file systems?
	• The ext3 file system is an enhanced version of the ext2 file system.
	• The most important difference between ext2 and ext3 is that ext3 supports journaling.
	• After an unexpected power failure or system crash (also called an unclean system shutdown), each ext2 file system must be checked for consistency by the e2fsck program. This is a time-consuming process and during this time, any data on the volumes is unreachable.
	• The journaling provided by the ext3 file system means that this sort of a file system check is no longer necessary after an unclean system shutdown. The only time a consistency check occurs while using ext3 is in certain rare hardware failure cases, such as hard drive failures. The time to recover an ext3 file system after an unclean system shutdown does not depend on the size of the file system or on the number of files. Rather, it depends on the size of the journal used to maintain consistency. The default journal size takes almost a second to recover, depending on the speed of the hardware.

-----------

1. Explain command: chmod 711, explain 1711 (and the sticky bit role)
	711 means --    421   001    001
	                        owner group other
	So 711 gives full permissions to owner and execute permissions to group and others.


	Using the numerical method, we need to pass a fourth, preceding digit in our chmod command. The digit used is calculated similarly to the standard permission digits:
		• Start at 0
		• SUID = 4
		• SGID = 2
		• Sticky = 1


		[tcarrigan@server ~]$ chmod X### file | directory
		Where X is the special permissions digit.

So, 1711 gives full permissions to owner and execute permissions to group and others and  sets a sticky bit.

	2. What is sticky bit ?
	By setting sticky bit the directory owner allows other users and groups to add files to the directory but prevent users from deleting each others files in that directory.
	
	at the directory level, it restricts file deletion. Only the owner (and root) of a file can remove the file within that directory. A common example of this is the /tmp directory:
	
	[tcarrigan@server article_submissions]$ ls -ld /tmp/
drwxrwxrwt. 15 root root 4096 Sep 22 15:28 /tmp/
	
	
	3. Which commands can be used for viewing file content?
	Cat, more, less
	Head and tail to show part of text files
	
	Examples
	
	cat script.sh
	more script.sh
	less script.sh
	
	By default, the head command displays the first 10 lines of a file.
	head script.sh
	head -5 script.sh
	
	The tail command displays the last 10 lines by default.
	tail script.sh
	tail -5 script.sh
	
	4. How to view running processes ? 
	ps -aux or ps -e
	
	-a  to select all processes except both session leaders and processes not associated with a terminal.
	-u Specifies a username, listing processes associated with that user.
	-x includes processes without a TTY, showing background processes not tied to a specific terminal session.
	-e to select all processes
	
	5. What does the grep command do ?
	used for searching and manipulating text patterns within files.
	Its name is derived from the ed (editor) command g/re/p (globally search for a regular expression and print matching lines),
	
	Example : grep -i "chirag"  /etc/passwd
	
	6. What is load average ? Does load average 2 is ok ? 
	Load is the measure of the amount of computational work a system performs. The three values is the load average over a time interval. The intervals are, the last 1 minute, 5 minutes, and 15 minutes.
	
	For a multi-core system like a quad processor it is ok but for a single core system it means 200% utilized which is overload.
	
	7. How to copy files from local host to remote?
	Using scp or we can also use ftp server
	
	Local host to remote:
	Example :  scp /home/myfile.docx root@example.com:/opt/odoo/
	
	scp source/filename [username]@[host]: destination 
	
	------------------------------------------------------------------------
	Remote to local host
	scp [username]@[host]:source/filename  [destination]
	
	Example : scp root@example.com:/opt/odoo/myfile.docx  /home/
	
	8. Purpose of /etc folder 
	System wide config files are present in etc
	E.g. /etc/passwd  /etc/hosts /etc/ssh/sshd_config
	
	9. How to terminate process
	using top, ps, pidof, or pgrep commands. Once the process you wish to terminate is located, you can use the killall, pkill, kill, xkill, or top commands to end it. 
	
	kill [signal] PID
	kill -9 1212
	
	10. What is Swap space 
	Swap space in Linux is used when the amount of physical memory (RAM) is full. If the system needs more memory resources and the RAM is full, inactive pages in memory are moved to the swap space. While swap space can help machines with a small amount of RAM, it should not be considered a replacement for more RAM.
	
	11. What is INODE 
	An inode is a data structure that keeps track of all the files and directories within a Linux or UNIX-based filesystem
	
	12. How to run command in background 
	Using & at the end of the command
	For e.g. --> tar -czf home.tar.gz . &
	
	13. How to login under other user
	su - user2
	
	14. Is it possible ssh to your host while you are already there 
	Yes
	https://unix.stackexchange.com/questions/487076/how-ssh-can-connect-with-itself
	
	15. Which default port used for SSH
	22
	
	16. Can we change it to any other?
	Yes
	
	17. How to do this? 
	Log on to the server as an administrator.
	Open the SSH configuration file sshd_config with the text editor vi: vi /etc/ssh/sshd_config
	Search for the entry Port 22
	Replace port 22 with a port between 1024 and 65536.
	service sshd restart
	
	18. How we can connect to remote host if we dont have SSH on remote host ?
	Using Telnet
	
	19. How to make user sudo?
	sudo usermod -aG sudo [name-of-user]

	To verify
	groups user1
	
	fea5e5cda37a7fa19d1e4fc8c523d0ec603c75a
	https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#InstanceDetails:instanceId=i-0a01f878ccda3edfa
	
	
	____________________________________________________________________________________________
    |cluster> specs repo 						   | artifacts repo 						    | 
	|___________________________________________________________________________________________|
	7127728 > 897324b8e070c55562474be3667abd71946f2777 | ea82705d65ac60c2f9e03bd8299febf8e5d6ca7e
	7129148 > 7f3452d9831b9a340cf6ea11539f3278a5fb0357 | artifacts not present
	7164964 > b2e432c2325c03367c72be14c071bbd8286a49a3 | b2e432c2325c03367c72be14c071bbd8286a49a3
	7166529 > c41e5ef0c4caf0bbc681ded0bc01239ac0d76bf8 | artifacts not present

	ephemeral-fauji-2a4852e0
	ephemeral-calm-204754e6

	ephemeral-tspec-fd9b54e1

	ephemeral-lol-1ae21522
	ephemeral-lol-1ae21522

	ephemeral-lokesh-6b15058e
	ephemeral-grfn1-d0cf0bd3
	ephemeral-bolo-7669ca25

	ephemeral-calm-204754e6
	ephemeral-adv-fe8da736
	
	---------------------

	ephemeral-7127728-51e37876
	ephemeral-7129148-508d386c
	
	
	
	>
	loadbalancers, S3, IAM role(user n policies). cross account role, read only access.
	goood knowledge on terraform, data and resource block, 
	donot know avoid drifts 
	docker, but understand,
	k8s i working, 
	linux OS. 
	theroticial part for help.
	troubleshooting services. 
	there is a gap, 2 months. 



A company is deploying a new application that will consist of an application layer and an online transaction processing (OLTP) relational database. The application must be available at all times. However, the application will have unpredictable traffic patterns. The company wants to pay the minimum for compute costs during these idle periods.

Which solution will meet these requirements MOST cost effectively?
	