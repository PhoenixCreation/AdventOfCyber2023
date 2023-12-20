# CrypTOYminers Sing Volala-lala-latility | Advent of Cyber 2023 | Day 19

## TL;DR of Day 19

We will be learning how to do the memory forencis using volatility tool. It is great tool to create and analyze the memory dump. Memory is first thing you need to analyze in order to understand the incident.

## walkthrough

Start the machine and after 2-3 machine use `ubuntu:volatility` as the credentials to ssh into the machine. Change directory to Desktop/Evidence. You will see the linux.mem file inside the directory which is our memory dump to be analyzed.

First thing we need to do is to have the memory profile for our analysis. Volatility has profiles inbuilt for the wondows but linux requires you to create one manually. But this has been done for us and profile file is already there in the current directory. Copy that to the ~/.local/lib/python2.7/site-packages/volatility/plugins/overlays/linux/ to load the profile using the command `cp Ubuntu_5.4.0-163-generic_profile.zip ~/.local/lib/python2.7/site-packages/volatility/plugins/overlays/linux/`. Now if you run the `vol --info | grep Ubuntu`, you should see the profile for Ubuntu being present. We will use this profile to load and analyze the memory dump.

Now we can use `-h` switch to check the available plugins as per below:
```bash
vol.py -f linux.mem --profile="LinuxUbuntu_5_4_0-163-generic_profilex64" -h
```

We will be using `vol.py -f linux.mem --profile="LinuxUbuntu_5_4_0-163-generic_profilex64"` for all of our command, so we can alias this using following command to ease the process:

```bash
alias vol="vol.py -f linux.mem --profile="LinuxUbuntu_5_4_0-163-generic_profilex64""
```

### Q1: What is the exposed password that we find from the bash history output?

We need to check the history of the bash shell. We can check which plugin can be used for the bash history using the following command:

```bash
vol -h | grep "bash history"
```
You will see that we can use `linux_bash` command for this. Let's use that as per the following:

```bash
vol linux_bash
```

You can see that the mysql server was started using the plain text password. Which is the answer to our question.

### Q2: What is the PID of the miner process that we find?

We can use the `linux_pslist` plugin command to list the processes that were running:

```bash
vol linux_pslist
```

Check the last two processes, both look suspicious and the process ID from the miner process found there is the answer to our question.


### Q3: What is the MD5 hash of the miner process?

Let's extract the miner process out in the file using the `linux_procdump` plugin command. We can create empty directory for exporting our files and it is required by the volatility to provide directory in order to avoid the errors. Let's create one directory with `mkdir extracted`.


We can then export the miner process using the following command:

```bash
vol.py -f linux.mem --profile="LinuxUbuntu_5_4_0-163-generic_profilex64" linux_procdump -D extracted -p PID
```
Don't forget to replace the last PID with the actual value of the process ID of the minor process.

Now we should have filename from the output of the previous command and then create md5 hash using the md5sum like `md5sum FILENAME`.


### Q4: What is the MD5 hash of the mysqlserver process?

Repeat the same process for the mysqlserver process from previous question.

### Q5: Use the command strings extracted/miner.<PID from question 2>.0x400000 | grep http://. What is the suspicious URL? (Fully defang the URL using CyberChef)

Use the above command as instructed and you will have the URL present in the output. Don't forgot to seprate it out from the unwanted words. And finally defang the URL using the [CyberChef](https://gchq.github.io/CyberChef/#recipe=Defang_URL(true,true,true,'Valid%20domains%20and%20full%20URLs'))

### Q6: After reading the elfie file, what location is the mysqlserver process dropped in on the file system?

Now we can check the persistance creation for any service. We will first check the cronjobs for this. Let's list all the cronjob files in the memory dump. We will use `linux_enumerate_files` plugin to extract all the files and grep them with cron keyword to get the all cron files as per the following command:

```bash
vol linux_enumerate_files | grep cron
```

Now we will see that there is one cronjob with the filename elfie(/var/spool/cron/crontabs/elfie). We can extract this file using the `linux_find_file` plugin command. It will need the file address from the previous command. Whole command would be something like below:

```bash
vol linux_find_file -i 0xffff9ce9b78280e8 -O extracted/elfie 
```

Now check the file content and you will see the path where the mysqlserver was dropped.



That should be all for today. Memory forensics is the very interseting subject in the digital forensics. It is great to have understanding of such good tool. I will see you tomorrow with something new and exciting information. Until then Happy Hacking.