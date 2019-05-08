from sklearn.neural_network import MLPClassifier, MLPRegressor
from sklearn.preprocessing import StandardScaler
import numpy as np
import matplotlib.pyplot as plt
from pyfmi import load_fmu
import random
from joblib import dump, load

def main():

    # Synchronisation rate for the FMU
    sync_rate = 60

    # Load the black box model and the corresponidng scaler
    MLPModel = load(r"C:\TEMP\Dymola\Steam_humidifier.joblib")
    scaler = load(r"C:\TEMP\Dymola\Steam_humidifier_scaler.joblib")


    command = []
    T_cur = []
    T_prev = []
    T_met_prev_1 = []
    T_met_prev_2 = []
    T_met_prev_3 = []
    T_met_prev_4 = []
    y_train_1 = []
    y_train_2 = []
    y_train_3 = []
    y_train_4 = []
    y_train_5 = []

    model = load_fmu(r"C:\TEMP\Dymola\ModelicaModels_SubsystemModels_DetailedModels_HumidifierML.fmu")

    model.set('valveOpening',0)
    model.initialize()
    model.do_step(0, sync_rate)

    time_step = sync_rate

    for t in range(60):

        command.append(0.0)

        T_cur.append(20)
        if t >= 1:
            T_prev.append(T_cur[-2])
        else:
            T_prev.append(T_cur[-1])

        model.set('valveOpening',command[-1])
        model.set('inflowTemp',T_cur[-1])

        model.do_step(time_step, sync_rate)

        val = model.get("supplyTemp")
        y_train_1.append(float(val))

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

    print(T_met_prev_1)

    x_test = np.stack((command,T_cur,T_prev,T_met_prev_1,T_met_prev_2,T_met_prev_3,T_met_prev_4),axis=1)

    scaled_instances = scaler.transform(x_test)
    y_test = MLPModel.predict(scaled_instances)

    print(y_test)
    fig, ax = plt.subplots()
    legend = ax.legend(loc='upper center', shadow=True, fontsize='x-large')
    ax.plot(y_train_1, label="true")
    ax.plot(y_test, "--", label="pred")

    x_test = np.stack(([5],[20],[20],[293],[293],[293],[293]),axis=1)
    scaled_instances = scaler.transform(x_test)
    y_test = MLPModel.predict( scaled_instances )
    print(y_test)

    plt.show()

if __name__=="__main__": main()
