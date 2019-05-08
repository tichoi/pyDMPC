import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import xlrd
import scipy
from scipy.integrate import simps
import pickle
import os
import sys

sys.path.insert(0, os.path.join('C:\\', 'Program Files (x86)', 'Dymola 2018', 'Modelica',
                                'Library', 'python_interface', 'dymola.egg'))

#Simulation of field model
#Import dymola package
from dymola.dymola_interface import DymolaInterface

# Start the interface
dymola = DymolaInterface()

# Location of your libraries
path_lib1 = r'C:\mst\pyDMPC\pyDMPC\ModelicaModels\ModelicaModels'
path_lib2 = r'C:\mst\modelica-buildings\Buildings'
path_lib3 = r'C:\mst\AixLib\Aixlib'
path_lib = [path_lib1, path_lib2, path_lib3]

# Location where to store the results
path_res = r'C:\mst\dymola\Geo_long'

# Name of the main working directory
import time
timestr = time.strftime("%Y%m%d_%H%M%S")
name_wkdir = r'pyDMPC_' + 'wkdir' + timestr

# Open AixLib
dymola.openModel(path=os.path.join(path_lib3, 'package.mo'))

# Translate any model you'd like to simulate
dymola.translateModel('ModelicaModels.SubsystemModels.DetailedModels.Geo.Field')

#parameters of the field model

#Input: combiTable "variation": heatflow of the houses need, m_flow
Q0_heat = np.array([500, 600, 300, 100, 50, 10, 0, 5, 80, 250, 300, 450])
Q0_cold = np.array([25, 25, 110, 200, 400, 600, 650, 600, 450, 300, 150, 50])
days = np.array([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]) 
dQ = np.array(Q0_heat/days - Q0_cold/days)

Q_set = [dQ[0]] *days[0] + [dQ[1]] *days[1] + [dQ[2]] *days[2] + [dQ[3]] *days[3] + \
        [dQ[4]] *days[4] + [dQ[5]] *days[5] + [dQ[6]] *days[6] + [dQ[7]] *days[7] + \
        [dQ[8]] *days[8] + [dQ[9]] *days[9] + [dQ[10]] *days[10] + [dQ[11]] *days[11]

m_flow = [0.00025]*365          #in m³/s

variation = [[Q_set], [m_flow]]

# Simulate the model
output = dymola.simulateExtendedModel(
    problem='',
    startTime=0.0,
    stopTime=94608000,
    outputInterval=3600,
    method="Dassl",
    tolerance=0.0001,
    resultFile=os.path.join(dir_result, 'demo_results'),
    finalNames=[''],
)

dymola.close()

#field temperature regarding the longterm set temperature = trajectory
T0 = 285                               #ungestörte Erdreichtemperatur 
T_set = T0*np.ones(3*365*24)           #Vorlauftemperatur ins Feld (Soll)
pickle_out = open("T_set.pickle","wb")
pickle.dump(T_set, pickle_out)
