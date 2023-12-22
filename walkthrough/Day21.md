# Yule be Poisoned: A Pipeline of Insecure Code! | Advent of Cyber 2023 | Day 21

## TL;DR of Day 21
Pipeline and Jenkins needs to be configured properly. If not then there are multiple ways to exploit the unrestricted access to the pipeline and gain the control over the deployment server.

## walkthrough

Start the machine and wait for 5 minutes. Then visit the port 3000 for gitea server and port 8080 for Jenkins server. For gittea server credentials are `guest:password123` and for Jenkins server credentials are `admin:admin`. 

Now on the gitea server, you will see two different repositories. One is gift-wrapper-pipeline and other is gift-wrapper. Now we can check the pipeline first. It is just single file. It is Jenkins config file and has shell access as per the command on line no. 13. We can change it to gain the access to the server. But if you see the top right corner, edit button is disabled for us. Which suggests that we do not have write permission for this repository.


Now look at the Jenkins config file. It has two stages. 1. clone the gift-wrapper repository. 2. Run the make command for that repository.

What if we can modify the Makefile on the gift-wrapper repository? Let's open that repository and check the Makefile. It only has one command. It is running to_pip.sh file in the current directory. Let's check the to_pip.sh file. It is just simple bash script. Let's check the edit permission. Click the pencil icon on the top right corner of the file. Yes, we can edit the file and manupulate the server. Let's check the both questions before proceeding.

### Q1: What Linux kernel version is the Jenkins node?

We can check the linux kerner version using the `uname -a` command.


### Q2: What value is found from /var/lib/jenkins/secret.key?

We can check the file content using `cat /var/lib/jenkins/secret.key` command. Now add this command to the to_pip.sh file. Commit the changes. Now we need to trigger the pipeline again from the Jenkins. Now go to jenkins dashboard. And Navigate to gift-wrapper-build -> gift-wrapper-pipeline -> main. And click the build not from left panel. It should add the build in the left bottom panel. Click on the latest build and click on the console output from the left panel. We should see the output of the both command in bottom part of the output.


That should be it for the today. We learned the another way to exploit the pipeline and Jenkins misconfiguration. Although this tasks can be done very easily by one the method we learned in the previous days task. If you remember it that that is good progress. Until then I will see you tomorrow with new topic.
