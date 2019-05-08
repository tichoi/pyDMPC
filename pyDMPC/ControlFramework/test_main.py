"""
This is a test module for new implementations.
"""

import System
import Subsystem
import Init
import time
import numpy as np
import scipy.io as sio
from pathos.multiprocessing import ProcessingPool as Pool
import Objective_Function
from pyfmi import load_fmu
import os
import sys
import configparser
import matplotlib.pyplot as plt
import shutil

def main():
    """Create a system and multiple subsystems"""
    AHU = System.System()
    subsystems = AHU.GenerateSubSys()

    """Prepare the working Directory"""
    os.chdir(Init.path_res)
    os.mkdir(str(Init.name_wkdir))
    os.chdir(str(Init.name_wkdir))

    """Create one directory for each of the subsystems and one for the inputs"""
    for s in subsystems:
        os.mkdir(s._name)

    os.mkdir("Inputs")

    """
    #Load the FMU model, set the experiment and initialize the inputs
    global dymola
    dymola = None
    # Work-around for the environment variable
    sys.path.insert(0, os.path.join(str(Init.path_dymola)))

    # Import Dymola Package
    from dymola.dymola_interface import DymolaInterface

    # Start the interface
    dymola = DymolaInterface()

    #Simulation
    # Open dymola library

    for lib in Init.path_lib:
        check1 = dymola.openModel(os.path.join(lib,'package.mo'))
        print('Opening successful ' + str(check1))

    dymola.cd(Init.path_res + '\\' + Init.name_wkdir)

    """
    
    # Translate the model to FMU
    if Init.create_FMU:
        dymola.ExecuteCommand('translateModelFMU("'+Init.path_fmu+'", true, "'+ Init.name_fmu+'", "1", "cs", false, 0)')
    else:
        shutil.copyfile(Init.path_res + "\\" + Init.name_fmu + ".fmu", Init.path_res+'\\'+Init.name_wkdir +'\\'+Init.name_fmu+'.fmu')
    
    model = load_fmu(Init.path_res+'\\'+Init.name_wkdir +'\\'+Init.name_fmu+'.fmu')

    model.set('humidifierWSP1',0)
    model.set('valveHRS',0)
    model.set('valvePreHeater',0)
    model.set('valveHeater',0)
    model.set('valveCooler',0)
    model.initialize()
    model.do_step(0, Init.sync_rate)

    """Variables storing (time) steps"""
    time_step = Init.sync_rate
    time_storage = 0
    start = time.time()
    counter = 0

    """Variables storing commands"""
    storage_commands = np.zeros([5,1])
    supplyTemps = []

    """There are currently three different options:
    1. NC-OPT algorithm
    2. NC-OPT algorithm using parallel computing
    3. BExMoC algorithm
    """

    """The algorithms work with a discrete *time_step*. In each step, the current measurements are taken using the :func:`GetMeasurements' method. """
    while time_step <= Init.sync_rate*Init.stop_time:

        # Variable for the final commands of all subsystems
        command_all = []

        if Init.algorithm == 'NC_DMPC':

            if time_step-time_storage >= Init.optimization_interval or time_step == Init.sync_rate:

                """ Consider the subsystems in multiple iterations, either in parallel or in sequential order """
                for k in range(4):
                    command_all = []
                    if Init.parallelization:
                        def f(s):
                            commands = s.CalcDVvalues(time_step, time_storage,k,model)
                            return commands

                        p = Pool(4)
                        commands = p.map(f, [subsystems[0], subsystems[1], subsystems[2], subsystems[3], subsystems[4]])
                        command_all = commands

                    else:
                        for s in subsystems:
                            commands = s.CalcDVvalues(time_step, time_storage,k,model)
                            print(k, s._name, commands)
                            command_all.append(commands)

        elif Init.algorithm == 'BExMoC':

            #Consider each subsystem sequentially
            for s in subsystems:
                print(s._name)

                """The main calculations are carried out by invoking the :func:'CalcDVvalues' method. The BExMoC algorithm exchanges tables between the subsystems in a .mat format"""
                commands = (s.CalcDVvalues(time_step, time_storage,0, model))
                print(commands)
                #for l,val in enumerate(commands):
                    #model.set(s._names_DVs[l], val)
                model.set("valveHRS", commands[0])
                model.set("valvePreHeater", commands[1])
                model.set("valveCooler", 0.0)
                model.set("valveHeater", commands[2])

            model.do_step(time_step, Init.sync_rate)
            print('Proceding')

        time_step += Init.sync_rate


    Objective_Function.CloseDymola()

if __name__=="__main__": main()
