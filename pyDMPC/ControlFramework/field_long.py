import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import xlrd
import scipy
from scipy.integrate import simps
import pickle

#field temperature regarding the longterm set temperature = trajectory
T_set = 285*np.ones(3*365*24)           #Vorlauftemperatur ins Feld (Soll)
pickle_out = open("T_set.pickle","wb")
pickle.dump(T_set, pickle_out)
