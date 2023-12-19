# A Gift That Keeps on Giving | Advent of Cyber 2023 | Day 18

## TL;DR of Day 18
Process forensics, not the actual topic but that's what we will learn today. How to find the malicious processes from the linux environment and handle them.

## walkthrough
Start the machine and access it using the split view. Remember that this machine takes time to be connected if you are not subscribed to the tryhackme. So be patient and start using the machine once it is connected.

### Q1: What is the name of the service that respawns the process after killing it?

Before knowing that service is actually doing this, let's try and look the way we can find such processes.

`top` is one the tools for linux that provides real-time visualization for current processes. If you run the top command on the machine then you will see that there is one process which is using the 100% CPU. Now we know why our machine was slow to connect. Let's note the process id and try to kill it using sudo previllages.

`sudo kill PROCESS_ID` should do the job. Run the command and check that if the process is gone or not? If you keep the one terminal open with top command running and kill the process from other terminal then you will see that it was killed for very short amount of time and then it respawned itself somehow.

Now how a process can restart on its own? No it can't. In linux, any killed process can't restart itself without some help. By some help, I mean something like cronjobs. Now when we run the top command it shows that process is running as root. So let's check the cronjobs for root user using `cronjobs -l` command. Nothing here too. What kind of help could allow process to restart itself? Another one is services.

Now let's check the all enabled services using the command `systemctl list-unit-files | grep enabled`. Check each and every service, You will find one service that is not supposed to be there. Check the status of that service using the command `systemctl status SERVICE_NAME`. You will see that it is the one spawning the processes.

### Q2: What is the path from where the process and service were running?
You will see the path of executable in the status info itself.


### Q3: The malware prints a taunting message. When is the message shown? Choose from the options below.

We haven't encountered any messages sent from the malware so far.


That was a quick day. But rather important one. It was very important to know and understand the linux process.
I will see you tommowrow with the new topic. Until then keep learning.