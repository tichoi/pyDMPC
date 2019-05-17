from sklearn.neural_network import MLPClassifier, MLPRegressor
from sklearn.preprocessing import StandardScaler
import numpy as np
from pyfmi import load_fmu
import random
from joblib import dump, load
import matplotlib.pyplot as plt
import pickle 

def main():

    command = [[] for l in range(4)]        # The manipulated variable in the model
    command_test = [[] for l in range(4)]        # The manipulated variable in the model

    names = ["valveHRS","valvePreHeater","valveCooler","valveHeater"]

    file = open(r"C:\TEMP\Dymola\command_HRC.obj","rb")
    command[0] = pickle.load(file)
    
    #file = open(r"C:\TEMP\Dymola\command_preheater.obj","rb")
    command[1] = np.zeros(len(command[0]))
    
    file = open(r"C:\TEMP\Dymola\command_cooler.obj","rb")
    command[2] = pickle.load(file)
    
    file = open(r"C:\TEMP\Dymola\command_heater.obj","rb")
    command[3] = pickle.load(file)
    
    file = open(r"C:\TEMP\Dymola\command_test_HRC.obj","rb")
    command_test[0] = pickle.load(file)
    
    #file = open(r"C:\TEMP\Dymola\command_test_preheater.obj","rb")
    command_test[1] = np.zeros(len(command[0]))
    
    file = open(r"C:\TEMP\Dymola\command_test_cooler.obj","rb")
    command_test[2] = pickle.load(file)
    
    file = open(r"C:\TEMP\Dymola\command_test_heater.obj","rb")
    command_test[3] = pickle.load(file)
    
    file = open(r"C:\TEMP\Dymola\T_cur.obj","rb")
    T_cur = pickle.load(file)
    
    file = open(r"C:\TEMP\Dymola\T_cur_test.obj","rb")
    T_cur_test = pickle.load(file)
    
    print(command[0])

    """ Lists for the training data """
    y_train = []
    y_test = []


    """ Simulate the FMU to generate the training data """
    sync_rate = 60  # Synchronisation rate of the FMU

    # Load exisiting FMU
    model = load_fmu(r"C:\TEMP\Dymola\ModelicaModels_SubsystemModels_DetailedModels_ControlledSystemBoundaries.fmu")

    """ Initialize the FMU """
    model.set('Tout',30)
    model.initialize()
    model.do_step(0, sync_rate)
    
    model_test = load_fmu(r"C:\TEMP\Dymola\ModelicaModels_SubsystemModels_DetailedModels_ControlledSystemBoundaries.fmu")

    """ Initialize the FMU """
    model_test.set('Tout',30)
    model_test.initialize()
    model_test.do_step(0, sync_rate)
    time_step = sync_rate
    
    c = 0

    """ Actual training sequence """
    for k in range(100):
        for t in range(100):
            print(c)
        
            """Write random values to the controlled variables"""    
            for l in range(4):
                model.set(names[l],command[l][c])
                model_test.set(names[l],command_test[l][c])


            model.set('Tout',T_cur[c])
            model_test.set('Tout',T_cur_test[c])

            model.do_step(time_step, sync_rate)
            model_test.do_step(time_step, sync_rate)

            """ Get the values calculated in the FMU """
            val = model.get("supplyAirTemperatureCOutput")
            y_train.append(float(val))
            val = model_test.get("supplyAirTemperatureCOutput")
            y_test.append(float(val))

            time_step += sync_rate
            c += 1

    """ Stack the lists with the relevant training data """
    x_train = np.stack((command[0],command[1],command[2],command[3],T_cur),axis=1)
    x_test = np.stack((command_test[0],command_test[1],command_test[2],
                       command_test[3],T_cur_test),axis=1)

    """ Scale the training data """
    scaler = StandardScaler()
    x_train = scaler.fit_transform(x_train)
    x_test = scaler.fit_transform(x_test)
    #print(X_train)


    """ Start the regression """
    MLPModel = MLPRegressor(hidden_layer_sizes=(3 ), activation='logistic', solver='lbfgs', alpha=0.0001, batch_size ="auto",
                        learning_rate= 'constant', learning_rate_init=0.001, power_t=0.5, max_iter=2000, shuffle=True, random_state=None,
                        tol=0.0001, verbose=True, warm_start=False, momentum=0.9, nesterovs_momentum=True, early_stopping=False,
                        validation_fraction=0.1, beta_1=0.9, beta_2=0.999, epsilon=1e-08)

    MLPModel.fit(x_train, y_train)
    #y_test = MLPModel.predict(X_train)

    """ Save the model and the scaler for later use """
    dump(MLPModel, r"C:\TEMP\Dymola\totalModel.joblib")
    dump(scaler, r"C:\TEMP\Dymola\totalModel_scaler.joblib")
    
    y_pred = MLPModel.predict(x_test)
    
    fig, ax = plt.subplots()
    #legend = ax.legend(loc='upper center', shadow=True, fontsize='x-large')
    ax.plot(y_test, label="Modelica FMU")
    ax.plot(y_pred, "--", label="MLP")
    #plt.xlim(30,250)
    ax.legend()
    plt.xlabel("Time in minutes",fontsize=16)
    plt.ylabel("Temperature in °C",fontsize=16)
    plt.savefig(r"C:\TEMP\total.svg",format='svg')
    plt.show()

    rmse = 0
    for i,val in enumerate(y_test):
        if i > 5:
            rmse += (y_pred[i]-val)**2
        
    rmse = (rmse/len(y_test))**0.5
    
    print(rmse)

if __name__=="__main__": main()
