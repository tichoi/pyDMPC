import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import xlrd
import scipy
from scipy.integrate import simps

DATA_FILE = "C:/mst/Grafana/Grafana3.xlsx"

# Read Excel data of Grafana csv file
def read_excel_file(Grafana3):
    book = xlrd.open_workbook(Grafana3, encoding_override = "utf-8")
    sheet = book.sheet_by_index(0)
    time = np.asarray([sheet.cell(i, 0).value for i in range(1, sheet.nrows)])          #in s
    vol_flow = np.asarray([sheet.cell(i, 1).value for i in range(1, sheet.nrows)])      #in l/min
    T_flow = np.asarray([sheet.cell(i, 2).value for i in range(1, sheet.nrows)])        #in °C
    T_return = np.asarray([sheet.cell(i, 3).value for i in range(1, sheet.nrows)])      #in °C
    mode = np.asarray([sheet.cell(i, 4).value for i in range(1, sheet.nrows)])          #1=cooling mode; 2=heating mode
    return time, vol_flow, T_flow, T_return, mode

time, vol_flow, T_flow, T_return, mode = read_excel_file(DATA_FILE)

# Variables of the fluid in double u-pipes
cp_water = 4.186            #in kJ/(kg K)
rho_water = 1000            #in kg/m³

#calculation of heatflow in timestep
dT = np.subtract(T_return, T_flow)
Q_flow = np.asarray(cp_water*rho_water*(vol_flow/60000)*dT)     #in kW

##Plotting Q(time)
#plt.plot(time, Q, lw=2)
#plt.axis([0, 26768640, -7, 7])
#plt.show()

#calculating heating budget [kWh/year] of field
Q_flow_heating = Q_flow.clip(min=0)
Q_heating = scipy.integrate.simps(Q_flow_heating, time)/3600
print("The heating budget for one year is", Q_heating, "kWh")

#calculating cooling budget [kWh/year] of field
Q_flow_cooling = Q_flow.clip(max=0)
Q_cooling = scipy.integrate.simps(Q_flow_cooling, time)/3600
print("The cooling budget for one year is", Q_cooling, "kWh")

##Calculating field temperature
#u =         #heat transfer parameters borehole
#T_field = np.sum(T_rohr, np.divide(Q_flow, u))

