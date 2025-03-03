import time
import paramiko

servers = [
    "hosts": "",
    "ip": "",
    "username": "",
    "keyName": ""
]

def ssh(servers):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(
        host=servers["ip"], username=servers["username"], key_filename=servers["keyName"])
    return ssh

def fetch(ssh):
    stdin, stdout, stderr = ssh.exec_command("df -h")
    diskUsage = stdout.channel

    stdin, stdout, stderr = ssh.exec_command("free -m")
    memUsage = stdout.channel

    return diskUsage, memUsage


    
