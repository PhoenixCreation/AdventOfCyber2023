# You Are on the Naughty List, McGreedy | Advent of Cyber 2023 | Day 24

## TL;DR of Day 24

We will complete our journey with some forensics analysis. We will use the most used tool for this, Autopsy.

## walkthrough

Start the machine and access it using the split view. Today's tasks are simple. But I would advice going through entire day descritption for more knowledge. I will only provide walkthrough for questions. 


On machine, start the Autopsy(should be pinned to taskbar, has the icon of dog holding magnifier glass). It takes some time to open. Once opened, it will ask to crate or load new case. We already have the case ready. Click on open in the dialog box. Our already created .aut file is in the `Documents/Tracy MacGreedy` folder. Load that. It will take some time to be loaded.


Once opened, our navigation will be mostly done from the left panel.

### Q1: One of the photos contains a flag. What is it?

Go to File Views > File Types > By Extension > Images. Now it should open the list of images in the right panel. Select the thumbnail mode from the top and check each images. You should see the flag as it is in very big letters.

### Q2: What name does Tracy use to save Detective Frost-eau’s phone number?

From left panle, Go to Data Artifacts -> contacts. It will list all the contacts. Now look at the contact names. Only one of the name contains the name detective.

### Q3: One SMS exchanged with Van Sprinkles contains a password. What is it?

From left panel, Go to Data Artifacts -> messages. It will list all the messages. You should see the password in plain text just right over there.



That should be it for the day and this year's Advent(ure). Have fun in the holidays and don't forget to keep learning after holidays.