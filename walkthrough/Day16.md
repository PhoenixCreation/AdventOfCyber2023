# Can't CAPTCHA this Machine! | Advent of Cyber 2023 | Day 16

## TL;DR of Day 16
WE will be learning about the CNN and OCR models today. CNN is the method to creating machine learning models that behaves like human neural network. OCR is the method to extract text from the image. We will use OCR to read the captcha and bypass captcha protection.

## walkthrough

Start the machine and access it using the split view.

### Q1: What key process of training a neural network is taken care of by using a CNN?

### Q2: What is the name of the process used in the CNN to extract the features?

### Q3: What is the name of the process used to reduce the features down?

### Q4: What off-the-shelf CNN did we use to train a CAPTCHA-cracking OCR model?

All questions above can be answered by reading the room description. You must read everything carefully.

### Q5: What is the password that McGreedy set on the HQ Admin portal?
Let's start the process. First we need the model and way to interact with the model. 

Open terminal in the access machine. First thing we need is the way to train the model. We already have the docker container for this. Run the following command to start the docker container.

```bash
docker run -d -v /tmp/data:/tempdir/ aocr/full
```
Now run the `docker ps` command and copy the container ID. 

Now we need to start the shell inside the docker container. Use the following command to start the bash shell inside the docker container.

```bash
docker exec -it CONTAINER_ID /bin/bash
```

Go to the /ocr/labels directory using `cd /ocr/labels`.

Now the OCR model is already trained, let's check it using the `aocr test testing.tfrecords` command.

It should take some time and show the testing logs. Now we need to extract the model outside the docker container. We need to copy the model folder to the /tempdir, use the command `cd /ocr/ && cp -r model /tempdir/`.

Now exit the docker shell using exit command. And we also need to kill the docker container using `docker kill CONTAINER_ID` command.

Now we need to run the tenserflow model service which will provide the API based interface to use the model. Run the following docker command to start the API server:

```bash
docker run -t --rm -p 8501:8501 -v /tmp/data/model/exported-model:/models/ -e MODEL_NAME=ocr tensorflow/serving
```

Make sure to keep it running as it is not running in the detached mode.

Now the python script to use this is already provided at the ~/Desktop/bruteforcer directory. Open terminal in that directory and run the following command:

```bash
python3 bruteforce.py
```
It should start bruteforcing the admin page on the hqadmin.thm:8000. You should get the username and password after couple of minutes. Password should be the answer to the question.


### Q6: What is the value of the flag that you receive when you successfully authenticate to the HQ Admin portal?

Use the credentials provided in the last question and login on the hqadmin.thm:8000 and it will provide you the flag.



That should be all for today. This is thrid day of machine learning related paths and we have gained good amount of basic knowledge of the machine learning and how it can be used in the red and blue teaming.

I will see you tommorow with the new challenge and learning.