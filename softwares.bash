#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


# ------------- Brute Force Tools --------------------------------
apt install crunch -y # Generates all the possible combinations of provided sequences for dictionaries based attack
apt install hydra -y # Carries out auotmated dictionaries based brute force attacks on different types of systems
apt install cewl -y # Generates all the possible combinations of provided sequences for provided website based on website crawling
apt install wfuzz -y # It can be used to brute-force websites to discover hidden content and username password brute forcing


# ------------- Exploitation Tools --------------------------------
apt install sqlmap -y # Enumarate provided URL for the possible sql injection vulnerabilities


# ------------- Windows Exploitation --------------------------------
apt install ruby-dev -y # Used so we can install things using gem
# gem install evil-winrm # Used to login using NTLM hash of the user   NOTE: this is flacky at the moment, use the docker version instead