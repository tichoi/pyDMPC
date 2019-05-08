# -*- coding: utf-8 -*-
"""
Created on Wed May  8 21:42:29 2019

@author: mba
"""

import random
import pickle

command = [[] for l in range(4)]        # The manipulated variable in the model
T_cur = []          # The current inflow temperature
command_test = [[] for l in range(4)]        # The manipulated variable in the model
T_cur_test = [] 
names = ["valveHRS","valvePreHeater","valveCooler","valveHeater"]

T = [2.0]
T_test = [10.0]

for k in range(49):
    T.append(random.uniform(2.0, 45.0))
    T_test.append(random.uniform(10.0, 40.0))

T.append(45.0)
T_test.append(40.0)

for k in range(50):
    for t in range(100):
        for l in range(4):
            if t%120 == 0:
                command[l].append(random.uniform(0.0,100.0))
                command_test[l].append(random.uniform(0.0,100.0))
            else:
                command[l].append(command[l][-1])
                command_test[l].append(command[l][-1])
                
        T_cur.append(T[k]+(T[k+1]-T[k])/100*t)
        T_cur_test.append(T_test[k]+(T_test[k+1]-T_test[k])/100*t)
        
filehandler = open(r"C:\TEMP\Dymola\T_cur.obj","wb")
pickle.dump(T_cur,filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\T_cur_test.obj","wb")
pickle.dump(T_cur_test,filehandler)
filehandler.close()
                
filehandler = open(r"C:\TEMP\Dymola\command_HRC.obj","wb")
pickle.dump(command[0],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_preheater.obj","wb")
pickle.dump(command[1],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_cooler.obj","wb")
pickle.dump(command[2],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_heater.obj","wb")
pickle.dump(command[3],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_test_HRC.obj","wb")
pickle.dump(command_test[0],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_test_preheater.obj","wb")
pickle.dump(command_test[1],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_test_cooler.obj","wb")
pickle.dump(command_test[2],filehandler)
filehandler.close()

filehandler = open(r"C:\TEMP\Dymola\command_test_heater.obj","wb")
pickle.dump(command_test[3],filehandler)
filehandler.close()

file = open(r"C:\TEMP\Dymola\command_HRC.obj","rb")
command[0] = pickle.load(file)

print(command[0])