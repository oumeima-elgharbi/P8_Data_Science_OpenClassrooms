# P8_Data_Science_OpenClassrooms

Hello !

Welcome to this repository.

This README contains information about :

- I) Context
- II) Virtual environment
- III) Dataset and image recognition
- IV) Spark
- V) AWS deployment

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
venv\Scripts\activate.bat 
pip install -r requirements.txt
pip install jupyter notebook
````

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

## IV) Spark

## V) AWS deployment