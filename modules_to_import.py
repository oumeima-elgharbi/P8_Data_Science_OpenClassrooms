# import warnings
# from time import time, strftime, gmtime

# import os
# from os import listdir
# from os.path import isfile, join

# import unittest
# import pytest
# import virtualenv

import sys

import pandas as pd
from PIL import Image
import numpy as np
import io
import os

import tensorflow as tf
from tensorflow.keras.applications.mobilenet_v2 import MobileNetV2, preprocess_input
from tensorflow.keras.preprocessing.image import img_to_array
from tensorflow.keras import Model
from pyspark.sql.functions import col, pandas_udf, PandasUDFType, element_at, split
from pyspark.sql import SparkSession

print("User Current Version:-", sys.version)
print("Tensorflow Version : {}".format(tf.__version__))
# print("PySpark Version : {}".format(pyspark__version__))

# TODO check version of Tf
