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
# Import dymola package
from dymola.dymola_interface import DymolaInterface

# Start the interface
dymola = DymolaInterface()

# Location of your local AixLib clone
dir_aixlib = r'C:\mst\AixLib\Aixlib'

# Location where to store the results
dir_result = <path/to/where/you/want/it>

# Open AixLib
dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))

# Translate any model you'd like to simulate
dymola.translateModel('AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone')

# Simulate the model
output = dymola.simulateExtendedModel(
    problem='AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone',
    startTime=0.0,
    stopTime=3.1536e+07,
    outputInterval=3600,
    method="Dassl",
    tolerance=0.0001,
    resultFile=os.path.join(dir_result, 'demo_results'),
    finalNames=['thermalZone.TAir' ],
)

dymola.close()

#field temperature regarding the longterm set temperature = trajectory
T0 = 285                               #ungestörte Erdreichtemperatur 
T_set = T0*np.ones(3*365*24)           #Vorlauftemperatur ins Feld (Soll)
pickle_out = open("T_set.pickle","wb")
pickle.dump(T_set, pickle_out)
