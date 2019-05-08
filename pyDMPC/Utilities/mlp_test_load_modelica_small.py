from sklearn.neural_network import MLPClassifier, MLPRegressor
from sklearn.preprocessing import StandardScaler
import numpy as np
import matplotlib.pyplot as plt
from pyfmi import load_fmu
import random
from joblib import dump, load
import pickle

def main():

    # Synchronisation rate for the FMU
    sync_rate = 60

    # Load the black box model and the corresponidng scaler
    MLPModel = load(r"C:\TEMP\Dymola\Pre_heater.joblib")
    scaler = load(r"C:\TEMP\Dymola\Pre_heater_scaler.joblib")

    T_prev = []
    T_met_prev_1 = []
    T_met_prev_2 = []
    T_met_prev_3 = []
    T_met_prev_4 = []
    y_test = []
    y_train_2 = []
    y_train_3 = []
    y_train_4 = []
    y_train_5 = []
    
    file = open(r"C:\TEMP\Dymola\command_test_preheater.obj","rb")
    command = pickle.load(file)
    
    file = open(r"C:\TEMP\Dymola\T_cur_test.obj","rb")
    T_cur = pickle.load(file)
    

    model = load_fmu(r"C:\TEMP\Dymola\ModelicaModels_SubsystemModels_DetailedModels_HeaterML.fmu")

    model.set('valveOpening',0)
    model.initialize()
    model.do_step(0, sync_rate)

    time_step = sync_rate
    c = 0
    
    
    for k in range(50):
        for t in range(100):

            if c >= 0:
                T_prev.append(T_cur[c-1])
            else:
                T_prev.append(T_cur[c])

            model.set("valveOpening",command[c])
            model.set("inflowTemp",T_cur[c])

            model.do_step(time_step, sync_rate)
    
            val = model.get("supplyTemp")
            y_test.append(float(val))
    
            val = model.get("hexele1masT")
            y_train_2.append(float(val))
            val = model.get("hexele2masT")
            y_train_3.append(float(val))
            val = model.get("hexele3masT")
            y_train_4.append(float(val))
            val = model.get("hexele4masT")
            y_train_5.append(float(val))
    
            if t == 0 or t%60 == 0:
                T_met_prev_1.append(y_train_2[-1])
                T_met_prev_2.append(y_train_3[-1])
                T_met_prev_3.append(y_train_4[-1])
                T_met_prev_4.append(y_train_5[-1])
            else:
                T_met_prev_1.append(T_met_prev_1[-1])
                T_met_prev_2.append(T_met_prev_1[-1])
                T_met_prev_3.append(T_met_prev_1[-1])
                T_met_prev_4.append(T_met_prev_1[-1])
    
    
            time_step += sync_rate
            c += 1

    x_test = np.stack((command,T_cur,T_prev,T_met_prev_1,T_met_prev_2,T_met_prev_3,T_met_prev_4),axis=1)

    scaled_instances = scaler.transform(x_test)
    y_pred = MLPModel.predict(scaled_instances)

    fig, ax = plt.subplots()
    #legend = ax.legend(loc='upper center', shadow=True, fontsize='x-large')
    ax.plot(y_test, label="Modelica FMU")
    ax.plot(y_pred, "--", label="MLP")
    #plt.xlim(30,250)
    ax.legend()
    plt.xlabel("Time in minutes",fontsize=16)
    plt.ylabel("Temperature in °C",fontsize=16)
    plt.savefig(r"C:\TEMP\preheater.svg",format='svg')
    plt.show()

    rmse = 0
    for i,val in enumerate(y_test):
        if i > 5:
            rmse += (y_pred[i]-val)**2
        
    rmse = (rmse/len(y_test))**0.5
    
    print(rmse)

if __name__=="__main__": main()
