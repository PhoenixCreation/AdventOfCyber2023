# A Christmas DOScovery: Tapes of Yule-tide Past | Advent of Cyber 2023 | Day 5

## TL;DR of Day 5
Today we will learn some basics of the MS-DOS operating system through a little task. It is basically an old operating system that was used as base to create the Windows.


Note: I am not going to go into depth for this tutorial due to some reasons.


## Walkthrough

Start the machine and open the split view to access it. Open the DOSBox-X.

# Q1: How large (in bytes) is the AC2023.BAK file? 

Now currently we are in `C:\` directory. Run the dir command to list the subdirectories and files with their information. You should see the AC2023.BAK file there and it's size in bytes.


# Q2: What is the name of the backup program?

Now move to the `C:\tools\backup` directory with the command cd as `cd C:\tools\backup`. You should be in the directory of the tool that can be used for recovery of the currepted files. You will have the readme.txt file there. You can read it with edit command such as `edit readme.txt`. You should see the name on the top of the file.

# Q3: What should the correct bytes be in the backup's file signature to restore the backup properly?

This answer can be found in the same readme.txt file's troubleshooting section. It is also mentioned in the day's description.

# Q4: What is the flag after restoring the backup successfully?

Now if we check our file `C:\AC2023.bak` then it has it's first bytes as `XX` which are not correct. We need first bytes to be `AC`(hexadecimal representation) as per the troubleshooting guide from the readme.txt. Now use the edit command like `edit C:\AC2023.bak` to edit the first two characters to AC and then run the backup program with the command `bumaster.exe C:\AC2023.bak`, it should provide you the flag if you have done everything correctly.


That is it for the day, it was short but important to understand the basic concepts. See you tommorow with some other new thing to learn.