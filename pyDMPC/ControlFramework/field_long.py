import numpy as np
#import matplotlib.pyplot as plt
import pandas as pd
#import xlrd
#import scipy
#from scipy.integrate import simps
import pickle
import os
import sys
import scipy.io as sio
import Init
#
sys.path.insert(0, os.path.join('C:\\', 'Program Files (x86)', 'Dymola 2018', 'Modelica',
                                'Library', 'python_interface', 'dymola.egg'))

#Simulation of field model
#Import dymola package
from dymola.dymola_interface import DymolaInterface
from modelicares import SimRes
# Start the interface
dymola = DymolaInterface()

# Location of your libraries
path_lib1 = r'C:\\mst\\pyDMPC\\pyDMPC\\ModelicaModels\\ModelicaModels'
path_lib2 = r'C:\\mst\\modelica-buildings\\Buildings'
path_lib3 = r'C:\\mst\\AixLib\\Aixlib'
path_lib = [path_lib1, path_lib2, path_lib3]

# Location where to store the results
path_res = r'C:\\mst\\dymola\\Geo_long\\'

# Name of the main working directory
import time
timestr = time.strftime("%Y%m%d_%H%M%S")
name_wkdir = r'pyDMPC_' + 'wkdir' + timestr

# Open AixLib, Buildings & pyDMPC Modlica Models
dymola.openModel(path=os.path.join(path_lib3, 'package.mo'))
dymola.openModel(path=os.path.join(path_lib2, 'package.mo'))
dymola.openModel(path=os.path.join(path_lib1, 'package.mo'))

# Translate any model you'd like to simulate
dymola.translateModel('ModelicaModels.SubsystemModels.DetailedModels.Geo.Field')
#obj_fnc_val = 'objectiveFunction'

#parameters of the field model

#Input: combiTable "variation": heatflow of the houses need, m_flow
Q0_heat = np.array([5000, 6000, 3000, 1000, 500, 100, 0, 50, 800, 2500, 3000, 4500])       #in kWh
Q0_cold = np.array([250, 250, 1100, 2000, 4000, 6000, 6500, 6000, 4500, 3000, 1500, 500])   #in kWh
days = np.array([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]) 
dQ = np.array(Q0_heat/days - Q0_cold/days)      #in kWh/day
dt = 24
Q_flow = np.divide(dQ*1000,dt)              #in W

#Q_set as needed heatflow every hour a year in W
Q_set = [Q_flow[0]] *days[0] *24 + [Q_flow[1]] *days[1] *24 + [Q_flow[2]] *days[2] *24 + \
        [Q_flow[3]] *days[3] *24 + [Q_flow[4]] *days[4] *24 + [Q_flow[5]] *days[5] *24 + \
        [Q_flow[6]] *days[6] *24 + [Q_flow[7]] *days[7] *24 + [Q_flow[8]] *days[8] *24 + \
        [Q_flow[9]] *days[9] *24 + [Q_flow[10]] *days[10] *24 + [Q_flow[11]] *days[11] *24

V_flow = 0.00025         #in m³/s
rho = 1000
m_flow = [V_flow*rho]*8760      #in kg/s

starttime = 0.0
stoptime = 1*365*24*3600
time = np.arange(0, stoptime, 3600)

tab = np.array([time] + [Q_set] + [m_flow])
BC_array = tab.transpose(1,0)

sio.savemat((path_res +'\\'+ Init.fileName_BCsInputTable + '.mat'), {Init.tableName_BCsInputTable :BC_array})

pickle_out = open(path_res + "\\" + "T_out.pickle","wb")
pickle.dump(BC_array, pickle_out)

#testList = [variation.column[1],variation.column[2]]
#testValues = [BC_array[1],BC_array[2]]
testList = ['']
testValues = [None]
variable_name=['']
final_names = ['supplyTemperature.T']

# Simulate the model
output = dymola.simulateExtendedModel(
    problem = 'ModelicaModels.SubsystemModels.DetailedModels.Geo.Field_new',
    startTime = starttime,
    stopTime = stoptime,
    outputInterval = 3600,
    method = "Dassl",
    tolerance = 1,
    resultFile = path_res +'dsres',
    finalNames = final_names,
    initialNames = testList,
    initialValues = testValues
    )
dymola.close()

sim = SimRes(path_res + 'dsres' + '.mat')
sol = sim.to_pandas(variable_name)

#pickling field temperature
#T0 = 285                               #ungestörte Erdreichtemperatur 
#T_set = T0*np.ones(3*365*24)           #Vorlauftemperatur ins Feld (Soll)

#pickle_out = open(path_res + "\\" + "T_out.pickle","wb")
#pickle.dump(T_out, pickle_out)