# The Little Machine That Wanted to Learn | Advent of Cyber 2023 | Day 14

## TL;DR of Day 14
We will be learning basics of the machine learning and the Artificial Intelligence today. AI has taken over the world right now and it has became one topic that one can not overlook while working with anything related to the computers. We will be learning about how to train a basic machine learning prediction model using the neural network in this challenge.


## walkthrough

Start the machine and wait for 3-5 minutes, then access the machine in the split screen. You should have one folder named `NeuralNetwork` on the desktop containing the python script and data for the training and validation. Open the script in the editor and we will start our work from there.

### Q1: What is the other term given for Artificial Intelligence or the subset of AI meant to teach computers how humans think or nature works?

This term is quite often used as synonym for the AI.

### Q2: What ML structure aims to mimic the process of natural selection and evolution?

There are three types of ML structures:

1. Genetic Algorithm: Used to mimic the decision process of the nature and evolution.
1. Particle Swarm: Creates swarms of particles and tries to keep them on target to achieve the desired goal.
1. Neural Networks: It uses networks of the nodes which mimics the human brain's neural network structure.

### Q3: What is the name of the learning style that makes use of labelled data to train an ML structure?

There are two type of learning style:

1. Supervised Learning: Nneural network generates one answer and we tell how close it is to the actual answer and it twicks itself based on that.
1. Unsupervised Learning: We provide the dataset to the machine learning to find the pattern inside the data on itself.

### Q4: What is the name of the layer between the Input and Output layers of a Neural Network?

This should be pretty simple answer.

### Q5: What is the name of the process used to provide feedback to the Neural Network on how close its prediction was?

Feed-forward or back-propagation?

### Q6: What is the value of the flag you received after achieving more than 90% accuracy on your submitted predictions?

Okay, enough of theories. Let's do some practical. Once you have opened the python file you will see the script is alerady there. But the script is only half done.

Izt should contains the code for reading the dataset and loading them into the numpy array. Then you will see some comment blocks for code that needs to be added from the day's description. It will be followed by the mechanism for the accuracy measurement. 

Now go through the day's description and start adding code blocks at the given comment line. Once you are done with all the code blocks, you can run the script with command `python3 detector.py`. It should start training the model. If you see any errors then try to debug and solve them. You will see the accuracy of the trained model once it done. Our target is to get more than 90% accuracy. If you don't get it on the first run, don't worry and try again. Due to randomness, it could take couple of tries before the accuracy to reach 90 percent mark.

> Note: If you don't get good accuracy after 5-7 times, copy the python code, restart the machine and then try again.

Now open the firefox on the split screen VM and visit `http://websiteforpredictions.thm:8000/`. (It should open as default page.) You will see that there us predictions.txt file created in the folder we generated our mode. Upload that on that website and you will receive your flag for the answer.


That was it. See you again tommorow for some more knowledge on this topic. Till then keep learning.
