# P8_Data_Science_OpenClassrooms

Hello !

Welcome to this repository.

This README contains information about :

- I) Context
- II) Virtual environment
- III) Dataset and image recognition
- IV) Local : Google Colab
- V) Cloud : AWS deployment

# ---------------------------------------------------------------------

## I) Context

https://www.kaggle.com/datasets/moltean/fruits

source dataset : https://www.kaggle.com/datasets/moltean/fruits/download?datasetVersionNumber=9

## II) Virtual environment

##### Requirements

- Run pipreqs for front-end, back-end, model preparation to get a requirements.txt

````bash
pipreqs
````

##### 1) Install python

Download python 3.10.9 and install it : https://www.python.org/downloads/release/python-3109/ if not already on your
machine

##### 2) Installation steps !!!!!!

- to get a virtual env run the following
- to activate it (you get (venv) in the terminal : venv\Scripts\activate.bat ((or venv\Scripts\activate))
- to install the requirements with the right versions
- to install Jupyter

````bash
virtualenv --python C:\Users\oumei\AppData\Local\Programs\Python\Python310\python.exe venv
source venv\Scripts\activate
pip install -r requirements.txt
pip install jupyter notebook
````

it was : venv\Scripts\activate.bat but maybe missed the word "source"

##### ATTENTION : need to run to activate venv in Shell

````bash
venv/Scripts/activate
````

And configure DataSpell (if you use that IDE) to set the virtual environment.

#### 3) Verification

Check that you have (venv) in your terminal

- to get the list of packages installed in **venv**
- to get the python version
- to get the python version that is run locally

````bash
pip list
python --version
py -V
python -V
````

#### 4) Add runtime.txt (HERE ??)

runtime.txt contains the python version, run like below to check the version

````bash
cat runtime.txt
python -V
````

python -V to check which version of Python is being run locally

#### 5) Some infos

if you have packages problems with Streamlit :

````bash
$ C:\ProgramData\Anaconda3\python.exe -m pip install --upgrade --force-reinstall streamlit 
````

--user won't work in virtual environment

## III) Dataset and image recognition

**Source** : https://www.kaggle.com/datasets/moltean/fruits

**Download dataset : https://s3.eu-west-1.amazonaws.com/course.oc-static.com/projects/Data_Scientist_P8/fruits.zip**

OR Download dataset from Kaggle : https://www.kaggle.com/datasets/moltean/fruits/download?datasetVersionNumber=9

## IV) Local : Google Colab

https://drive.google.com/drive/u/1/folders/1BRST8a8gaGcrAE4Oqv-pumCMkyWRw03g

## V) Cloud : AWS deployment

### 1) Prepare AWS Cli

In venv :

````bash
pip install awscli
````

- Create an access key (ID and Key), region : eu-west-1, output (None or json)

````bash
aws configure
````

### 2) S3 (Simple Storage Service)

- Nothing yet :

````bash
aws s3 ls
````

- Create a bucket in which we will upload our data (name unique for all users)

````bash
aws s3 mb s3://oc-p8-data
````

- Check that bucket is empty

````bash
aws s3 ls s3://oc-p8-data
````

- cp : to add a file
- rm : to remove a file

**To add a folder in S3 :**

We are in our virtual env, at the root of this repository.
Our Test folder is in "02_cloud_aws" in "data"
We want to add all the **data** folder locally to the S3 bucket oc-p8-data in the folder **data**

Sync command is to synchronise a folder locally with a folder in S3.

````bash
aws s3 sync 02_cloud_aws/data/ s3://oc-p8-data/data/
````

To check that the data were correctly uploaded :

````bash
aws s3 ls s3://oc-p8-data/data/
````

##### Other commands :

- To download data from the bucket, for instance Dates folder in our root "." :

````bash
aws s3 cp s3://oc-p8-data/data/Test/Dates/ .
````

##### Console : web interface for S3

https://console.aws.amazon.com/s3/buckets/oc-p8-data?prefix=data/&region=eu-west-1

### 3) EMR (Elastic Map Reduce)

#### Create cluster

1) Create a cluster => Advanced options 
- emr-6.9.0
- JupyterHub 1.4.1
- Tensorflow 2.10.0
- Spark 3.3.0

Add this configuration :
[{"classification":"jupyter-s3-conf", "properties":{"s3.persistance.bucket":"oc-p8-data", "s3.persistance.enabled":"true"}}]

[
{
"classification": "jupyter-s3-conf",
"properties": {
"s3.persistance.bucket": "oc-p8-data",
"s3.persistance.enabled": "true"
}
}
]

1 master and 2 workers

add bootstrap, upload file in S3 and : s3://oc-p8-data/bootstrap-emr.sh

SSH Anywhere iPV4 et iPV6 et port 22

** USe Firefox and add FoxyProxy 5555 and Socks5

First Cluster : hadoop@ec2-34-241-89-35.eu-west-1.compute.amazonaws.com



2) Before creating an EMR cluster, we need an EC2 SSH key.
.pem key

3) Choose eu regions in interface

4) Then, create a cluster, and change "eu-west-1" for the logging folder s3://aws-logs-815565965465-eu-west-1/elasticmapreduce/

name : Cluster P8
emr-5.33.0 OR last version 6.9
use key name 

4) Add an "AWS step"
5) 


#### Clone cluster from previous one
create-cluster.sh + --stepset --auto-terminate options

And add SSH for ec2-54-229-218-116.eu-west-1.compute.amazonaws.com


#### Bootstrapping TODO rewrite

Dans notre application du chapitre précédent qui analyse l'Iliade et l'Odyssée nous avons utilisé une dépendance externe
sous la forme d'un package à installer avant d'exécuter notre application. 
Nous avons également dû télécharger une liste de "stopwords" 

````bash
aws emr create-cluster \
    ...
    --bootstrap-action Path=s3://oc-calculsdistribues/bootstrap-emr.sh
````

#### Configure SSH client


#### Add files in S3
- add notebook
- add bootstrap.sh


#### Maintenance 

- Spark Web UI
1) create SSH tunnel TODO rewrite 
````bash
ssh -D 5555 hadoop@ec2-34-249-244-196.eu-west-1.compute.amazonaws.com
````

2) FoxyProxy
- Add extension on Chrome or Firefox
- Configure it with : chrome-extension://gcknhkkoolaabfmlnjonogaaifnjlfnp/options.html#tabProxies
SOCKS proxy?
- localhost
- 5555

- "Use proxy localhost:5555 for all URLs"
- 
3) http://MASTERNODEURL:PORT