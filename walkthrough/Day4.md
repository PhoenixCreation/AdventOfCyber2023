# Baby, it's CeWLd outside | Advent of Cyber 2023 | Day 4

## TL;DR of Day 4

This day is sort of continuation of last day, with today instead of blind brute forcing based on every combination, we can use content based wordlist for such tasks. Cewl(pronounced "cool") is one such tool that can crawl the provided website and create wordlists for us. We can combine it with tools like wfuzz to enumarate those combinations. Hydra can be used for this but you should know as much tools as possible as every tools has their own advantages and limitations.


## Walkthrough
Start the machine and then visit the IP in your browser directly. It should open a website for the `AntarctiCrafts`.

You can look around the website but there is nothing significant except loging page at /login.php as a Employee portal. We have no idea about the username and password here. Unlike other day we have two inputs to guess and if we go blind brute force then it will take almost forever to crack the username and password. You are welcome to try and let me know how many ages it took!

First let's set the target machine IP and environment varibale for ease of use
```bash
export IP=YOUR_MACHINE_IP
```

So what now? Let's pull up the first tool of the day, Cewl(cooooool). It basically crawls the website and linked pages to create dictionary based on the provided criteria.
Let's see two examples for our excercise.
```bash
cewl -d 0 -m 5 -w usernames.txt http://$IP/team.php --lowercase
cewl -d 2 -m 5 -w passwords.txt http://$IP --with-numbers
```
In here,
- `-d` is for depth of the linked sites and pages, we will keep it to 0 for username but we will keep it higher for our password quest.
- `-m` is for minimum characters and similarly `-x` for the maximum characters, we are not setting max limit in our example.
- `-w` is just for directing output to filename rather than printing on the console.
- `--lowercase` is self explanatory
- `--with-numbers` will include the numbers in the words
- there are others options which you can explore by running `cewl --help`

Now at this point you should have usernames.txt and passwords.txt ready. Let's bring the other tool of the day to sunlight. Welcome the wfuzz. It is short form of Web FUZZing. It can be used to enumarate the website for discovery of the hidden stuff. At the same time it can also be used to brute force username and passwords just like hydra.

We will be using the following command for our attack
```bash
wfuzz -c -z file,usernames.txt -z file,passwords.txt --hs "Please enter the correct credentials" -u http://$IP/login.php -d "username=FUZZ&password=FUZ2Z"
```

Let's explain some of stuff:
- `-c` for colorful output
- `-z` can be used to provide the input filename or other input methods, more can be found with `wfuzz --help` command.
- `--hs` is indication of unsuccessful attempt or rather more specifically to hide the attempt from printing.
- `-u` to provide the target URL.
- `-d` can be used to provide the parameters that needs to be fuzzed. Here you can use `2Z`, `3Z` if you have multiple inputs.
- `-t` is something not used in above example but is basically how many threads can be used to do the enumaration, more means faster. Default is 10. 


# Q1: What is the correct username and password combination? Format username:password

Now let it run for some time and it should give you the output based on your system configuration. It should provide you the username and password combination that can be used to login to the website. Use them and login on the site.

> Note: For answering the question format is username:password (just like the http basic auth)

# Q2: What is the flag?

Now we don't have flag immediately. So as per my habit I opened the source code and certainly it was there. Now more sane way would be to just click on the each mail and that should reveal the flag for you. Yeah the tasks are done.


## Task for you?
- Can we use hydra instead of the wfuzz? Ofcourse we can. Try on yourself and see if you get any success. For some lazy people here is the hydra command same as wfuzz for this task,

```bash
hydra -L usernames.txt -P passwords.txt -f -v $IP http-post-form "/login.php:username=^USER^&password=^PASS^:enter the correct credentials " -s 80 -t 40 -v
```


And with that one more day of learnign is done and dusted, See you guys tommorow for another new stuff.