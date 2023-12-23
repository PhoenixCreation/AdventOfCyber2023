# Jingle Your SSRF Bells: A Merry Command & Control Hackventure | Advent of Cyber 2023 | Day 22

## TL;DR of Day 22

SSRF(Server Side Reqest Forgery) is culnerability that allows attackers to access the unauthorized resources such as important files and resticted servers.

## walkthrough

Start the machine and wait for some time. Then visit the IP address in the browser. You will see the login page for the command and control server.

> Note: Never try to attack a command and control server. Always report this to authorities and let them handle this.

Now since we don't have credentials, we can check the API version. Click on the `Accessing through API` in the bottom. Is says we can use IP/getClientData.php?url= to get the needed file. But the url parameter seems to vulnerable to the SSRF attack. So let's check it. Visit the `IP/getClientData.php?url=file:////var/www/html/index.php` to see if we can read the filesystem. And indeed we can. We get the source code for the index.php which shows that credentials are included in the config.php file.

### Q1: Is SSRF the process in which the attacker tricks the server into loading only external resources (yea/nay)?

We can also access the internal resources.

### Q2: What is the C2 version?

Let's read the config file using the `IP/getClientData.php?url=file:////var/www/html/config.php` command. We have the username and password now. Loging to the C2 dashboard with this credentials and check the footer(bottom right) of the website to get the C2 server's version.

### Q3: What is the username for accessing the C2 panel?

We already have the username from the previous step.

### Q4: What is the flag value after accessing the C2 panel?

Flag value can be seen on the header bar.

### Q5: What is the flag value after stopping the data exfiltration from the McSkidy computer?

Check the bottom panel of the website which lists all the connections. Remove the first connection and you will see the flag in the popup alert.


That should be all for today. It is great to understand that simple miconfiguration can lead to so much of data loss. Until then stay safe and happy hacking.