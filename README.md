# P8_Data_Science_OpenClassrooms

Hello !

Welcome to this repository.

This README contains information about :

- I) Context
- II) Dataset
- III) Virtual environment
- IV) Local : Google Colab
- V) Cloud : AWS deployment

# ---------------------------------------------------------------------

## I) Context

This project is about deploying a Jupyter Notebook on the cloud. We have used AMS cloud solution with S3 and EMR.

First, we have prepared a notebook in **01_local_colab** using PySpark to preprocess fruits images using Transfert
Learning and a PCA.

Secondly, after having finalised the **"local notebook"**, we have saved the dataset **Test** on an S3 bucket and we run
the notebook on an EMR cluster.

## II) Dataset

The dataset contains 90380 images of 131 fruits and vegetables.

We have used the dataset **Test** from "fruits-360_dataset/fruits-360/Test" that contains 22688 images for the notebook
run on an EMR cluster.

We have used a sample of 34 images saved in **Test1** to prepare the image preprocessing notebook on Google Colab.

**Source** : https://www.kaggle.com/datasets/moltean/fruits

**Download dataset : https://s3.eu-west-1.amazonaws.com/course.oc-static.com/projects/Data_Scientist_P8/fruits.zip**

OR Download dataset from Kaggle : https://www.kaggle.com/datasets/moltean/fruits/download?datasetVersionNumber=9

## III) Virtual environment

We configurate a virtual environment to be able to use AWS CLI later even if the **local notebook** is run on Colab.

##### Requirements

- Run pipreqs to get a requirements.txt

````bash
pipreqs
````

##### 1) Install python

Download python 3.10.9 and install it : https://www.python.org/downloads/release/python-3109/ if not already on your
machine

##### 2) Installation steps

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

python -V to check which version of Python is being run locally

##### Information :

--user won't work in virtual environment

## IV) Local : Google Colab

First, we work locally : see folder **01_local_colab**.

We have chosen to work on a Google Colab notebook because instead of installing a Virtual Machine (for Windows
computers), Java and Spark, we can access Spark easily.

We create a folder **data** in Google Drive in which we upload the dataset **Test1**.
We save the notebook **P8_Notebook_Colab** in Google
Drive : https://drive.google.com/drive/u/1/folders/1BRST8a8gaGcrAE4Oqv-pumCMkyWRw03g

We install Spark and the other librairies in the notebook.

After running the notebook, the results are saved in parquet format in a folder **Results1** in the folder **data**.

## V) Cloud : AWS deployment

To deploy the notebook **P8_Notebook_AWS** from **02_cloud_aws**, we will use S3 for storage and EMR for cloud
computing.

First, we create a bucket called **oc-p8-data** in which we add a folder **data** that contains **Test1** and **Test**.

Secondly, we configure and create an EMR cluster.

After the creation of the cluster, we connect to it using an SSH tunnel and a Proxy (**FoxyProxy** on **Firefox**).

Then, we can access **Jupyter Hub** and run our notebook that we upload on Jupyter Hub.

The results from the preprocessing and PCA are saved in a folder **Results** (**Results1** for the sample dataset) in
parquet format.

**Results** is in **data** in the bucket **oc-p8-data**.

### 0) Prepare AWS Cli

In venv :

````bash
pip install awscli
````

- Create an **access key (ID and Key)**
- Use **access key (ID and Key)**, region : eu-west-1, output (None or json)

````bash
aws configure
````

### 1) S3 (Simple Storage Service)

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
aws s3 cp s3://oc-p8-data/data/Results/ .
````

##### Console : web interface for S3

https://console.aws.amazon.com/s3/buckets/oc-p8-data?prefix=data/&region=eu-west-1

### 2) EMR (Elastic Map Reduce)

#### 2.1) Before creating the cluster

- Upload these two files in S3 bucket **oc-p8-data**
- add bootstrap.sh
- add jupyter-s3-config.json for persistance (Jupyter Hub connected to S3 bucket)


1) Bootstrap
   To install the python packages when booting the cluster, create a file called **bootstrap-emr.sh** and add these
   lines :

````shell
sudo python3 -m pip install -U setuptools
sudo python3 -m pip install -U pip
sudo python3 -m pip install wheel
sudo python3 -m pip install pillow
sudo python3 -m pip install pandas==1.2.5
sudo python3 -m pip install pyarrow
sudo python3 -m pip install boto3
sudo python3 -m pip install s3fs
sudo python3 -m pip install fsspec
````

2) Configuration for persistance
   Create a file called **jupyter-s3-conf.json** and add these lines :

````json
[
  {
    "classification": "jupyter-s3-conf",
    "properties": {
      "s3.persistance.bucket": "oc-p8-data",
      "s3.persistance.enabled": "true"
    }
  }
]
````

#### 2.2) Create cluster

- Choose European region in web interface (example : eu-west-1)
- Before creating an EMR cluster, we need an EC2 SSH key (RSA .ppk key saved in folder **ssh**)

1) Create a cluster => Advanced options

- emr-6.3.0
- JupyterHub 1.2.0
- Tensorflow 2.4.1
- Spark 3.1.0

2) Configure the cluster

- name : P8_Fruits
- use key_name (Key from EC2)
- 1 master and 2 workers
- TODO : add in Group Security : SSH Anywhere iPV4 et iPV6 and port 22


3) create SSH tunnel

- Follow the steps from PuTTY on Windows (Host name / add .ppk file / create Tunnel port 5555)
- we get the EMR message from a shell

Not used here but for information :

````bash
ssh -D 5555 hadoop@ec2-34-249-244-196.eu-west-1.compute.amazonaws.com
````

4) FoxyProxy

- Add Proxy extension on Firefox : FoxyProxy
- Configure it with : (Proxy called 'EMR' / localhost / Port : 5555 / Socks5)
- Active it only on EMR console

5) Export cluster configuration
   **create-cluster.sh** + --stepset --auto-terminate options

6) Terminate the cluster when finished to avoid high bill.

#### 2.3) Clone cluster from previous one

1) Clone

- We have saved the configuration of the previous cluster in **create-cluster.sh** that we got from "Export AMS Cli"
- Either run **create-cluster.sh** in shell or click in **Clone cluster**.

2) Add SSH Tunnel => we get the EMR shell message.
   Example : ec2-54-229-218-116.eu-west-1.compute.amazonaws.com

3) Activate the Proxy (click on the extension)

#### 2.4) Maintenance

- Spark Web UI