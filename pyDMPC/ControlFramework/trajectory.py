import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import xlrd
import scipy
from scipy.integrate import simps

#Gebäudebedarf
Q_need_heat = np.array([500, 600, 300, 100, 50, 10, 0, 5, 80, 250, 300, 450])   #in kWh/Monat
Q_need_cold = np.array([25, 25, 110, 200, 400, 600, 650, 600, 450, 300, 150, 50])     #in kWh/Monat
days = np.array([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])               #Tage im Monat: Jan 31, Feb 28, ...
cp_water = 4.186              #in kJ/(kg K)
m_flow = 0.5                  #kg/s

#Wärmebedarf
#Annahme: jeder Tag in einem Monat x hat das selbe Lastprofil und hat denselben Energiebedarf (Q_flow=konst)
day_heatneed = np.array(Q_need_heat/days)                                           #Wärmebedarf eines Tages des Monats x
Q_heatflow_day = np.array(day_heatneed/24)                                              #benötigter übertragener Wärmestrom an Warmwasserkreislauf[kW]
#welche Temperaturdifferenz ist für den benötigten Wärmestrom nötig
dT_heat = np.array(Q_heatflow_day/(m_flow*cp_water))

#Kältebedarf
day_coldneed = np.array(Q_need_cold/days)                                           #Wärmebedarf eines Tages des Monats x
Q_coldflow_day = np.array(day_coldneed/24)                                              #benötigter übertragener Wärmestrom an Warmwasserkreislauf[kW]
#welche Temperaturdifferenz ist für den benötigten Kältestrom nötig
dT_cold = np.array(Q_coldflow_day/(m_flow*cp_water))

#effektiver Wärme/Kältebedarf eines Tages eines Monats
dQ_flow_day = np.array(Q_heatflow_day - Q_coldflow_day)
dT = np.array(dQ_flow_day/(m_flow*cp_water))
