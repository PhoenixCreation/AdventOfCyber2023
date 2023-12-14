# To the Pots, Through the Walls | Advent of Cyber 2023 | Day 13

## TL;DR of Day 13

We will be understanding about the firewall and honeypot machanism of defense. Any type of attack will have special tactics behind it and understanding them will help us eliminate such attacks in the future.


## Walkthrough

Start the machine and wait for somet time to get it set up. After that ssh into the machine using the username `vantwinkle` and password `TwinkleStar`. We will be using this to configure the defense of the machine.

> Note: We don't need to understand the honeypot machanism for this task to be completeled. I will strongly advice on checking that part out. I will omit that part as it is not relavant to the walkthrough.

### Q1: Which security model is being used to analyse the breach and defence strategies?

You can find the answer to this quesiton in the room description.

### Q2: Which defence capability is used to actively search for signs of malicious activity?

You can find the answer to this quesiton in the room description.

### Q3: What are our main two infrastructure focuses? (Answer format: answer1 and answer2)

It is not answered directly in the room description, but you need to remove the their adjectives to get the answer. Hint: they are the topics of this day.

### Q4: Which firewall command is used to block traffic?

I will deny to answer this.

### Q5: There is a flag in one of the stories. Can you find it?

Okay, as per the last paragraph in the room description, our task is to enable the website to the public that was disabled during testing.

We don't have the basic information like which website and where it is running? If we check files in the home directory then we will see one bash script named `Van_Twinkle_rules.sh`. This script contains the firewall configuration changes. We will see that port 21, 8088 and 8090 have been changed. We can now check the open ports on the system using `sudo ss -tulnp` command. We will see that apache server is running on the port 8090. 

Now let's try to access the IP:8090 from our machine, it won't connect. So firewall is blocking the access. Let's update it.
We can run the following commands to enable the port 8090 access.
```
sudo ufw allow 8090/tcp
sudo ufw enable
```

Now we can access the website on the port 8090. You can search for the `THM{` for the flag.



That shuold be all for the day. It was defensive tactics day. Hope you learned something new today and with that I will see you tommorow with something different and something interesting.