# I Tawt I Taw A C2 Tat! | Advent of Cyber 2023 | Day 17

## TL;DR of Day 17

We will learning about the network analysis with network flow format file. It is stripped down veriosn of the PCAP(full network capture) file. We will be using various tools to make out analysis easier.

## walkthrough

Start the machine and access it using the split view. Open the terminal and go to Desktop directory. You will see there is one file called suspicious-flows.silk. Let's set it to the variable as we will be using it quite frequently using `export FILENAME=suspicious-flows.silk`

### Q1: Which version of SiLK is installed on the VM?

We can easily check this using `silk-config -v` command.

### Q2: What is the size of the flows in the count records?
We can use rwfileinfo to get the metadata statistics for the file using command `rwfileinfo $FILENAME`


### Q3: What is the start time (sTime) of the sixth record in the file?
We can check the records in the file using the rwcut command. We need to check the sixth record so we will limit the output to 6 rows.

```bash
rwcut $FILENAME --num-recs=6
```

### Q4: What is the destination port of the sixth UDP record?

We need to filter the data using rwfilter command and we need only records with UDP protocol which can be done using --proto=17(17 is binary for UDP, it is assigned by IANA) switch. Full command would be as follow:

```bash
rwfilter $FILENAME --proto=17 --pass=stdout | rwcut --fields=protocol,sIP,sPort,dIP,dPort --num-recs=6
```

### Q5: What is the record value (%) of the dport 53?

We can get the statistics of the records using the rwstats command. We can filter the fields using --fields switch as shown below:

```bash
rwstats $FILENAME --fields=dPort --values=records --count=10
```
check the entry for port 53 and %Records for that.

### Q6: What is the number of bytes transmitted by the top talker on the network?

We need to get the IP address that transmitted the most bytes on the network. We can use rwstats to check the %Bytes using the following command:

```bash
rwstats $FILENAME --fields=sIP --values=bytes --count=10 --top
```

### Q7: What is the sTime value of the first DNS record going to port 53?

We can use the rwfilter again and check the first entry using the rwcut as per following command:

```bash
rwfilter $FILENAME --aport=53 --pass=stdout | rwcut --fields=stime | head -1
```

### Q8: What is the IP address of the host that the C2 potentially controls? (In defanged format: 123[.]456[.]789[.]0 )

Use the following command to check which IPs are using the port 53 the most:

```bash
rwfilter $FILENAME --aport=53 --pass=stdout | rwstats --fields=sIP,dIP --values=records,bytes,packets --count=10
```
You will see that two IPs are consuming all the traffic on the port 53. If we check those records using following command:

```bash
rwfilter $FILENAME --saddress=IP-HERE --dport=53 --pass=stdout | rwcut --fields=sIP,dIP,stime | head -10
```
for both IPs then we will see that only one IP is sending the packets which is kind of suspiciously similiar to how the C2 works.

### Q9: Which IP address is suspected to be the flood attacker? (In defanged format: 123[.]456[.]789[.]0 )

We can check the port 80 traffic using the following command:

```bash
rwfilter $FILENAME --aport=80 --pass=stdout | rwstats --fields=sIP,dIP,dPort --count=10
```

You will see that only one IP is flooding the network on port 80 with over 48% records.

### Q10: What is the sent SYN packet's number of records?

If we check the records for the IP from the last question, we will find that all the records are only having `s` flag and missing `a` flag which means all the records sent by that IP are the number of records we are looking for.


That should be it for the day. Today we learned something similar to log analysis from previous day but for network data and with different perspective. I will see you tommorow with some different topics and learnings.
