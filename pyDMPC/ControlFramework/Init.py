""" Neccessary specifications (user) """

"""System configuration"""
name_system = 'AHU'
amount_consumer = 4
amount_generator = 1

"""Data point IDs in the controlled system"""
measurements_IDs = ['outdoorTemperatureOutput', 'outdoorHumidityOutput', 'outgoingAirOutletTemperatureCOutput',
                    'outgoingAirOutletHumidityOutput', 'roomTemperatureOutput', 'roomHumidityOutput',
                    'supplyAirTemperatureCOutput', 'supplyHumidityOutput', 'preHeaterTemperatureCOutput',
                    'coolerTemperatureCOutput', 'heaterTemperatureCOutput', 'highTemperatureCircuitOutput',
                    'coolingCircuitOutput', 'highTemperatureCircuitOutput', 'preHeaterReturnTemperatureOutput',
                    'heaterReturnTemperatureOutput', 'outgoingAirOutletTemperatureCOutput','outgoingAirOutletHumidityOutput','outgoingAirOutletHumidityOutput']

""" General algorithm settings """
algorithm = 'NC_DMPC'   #choices: 'NC_DMPC', 'BExMoC'
parallelization = False  #run calculations in parallel if possible
realtime = False         #Choose True for a real-life experiment

""" Settings for BExMoC algorithm """
# So far: For all subsystems the same settings
factors_BCs = [1.5, 0.03]              # order: BC1, BC2, ...
center_vals_BCs = [30, 0.001]
amount_lower_vals = [9, 0]
amount_upper_vals = [9, 1]
exp_BCs = [1, 1]
amount_vals_BCs = [1, 1]

""" Settings for NC-DMPC algorithm """
init_DVs = [0]
convex_factor = 0
max_num_iteration = 1000
max_relErr = 0.1
cost_gradient = 0

""" Set objective function """
obj_function = 'Monetary'   #choices: 'Exergy', 'Monetary'
set_point = [30.0, 0.005]     #set points of the controlled variables
tolerance = 0.4
cost_factor = 0.5

""" Time and Interval Settings """
sim_time_global = 10000          # -> not used yet
sync_rate = 5*60                 # Synchronisation rate in seconds
optimization_interval = 10*60    # After one interval the optimization is repeated
prediction_horizon = 3600        #Common prediction horizon in seconds

""" Directories and Modelica libraries """
# Path where the main working directory shall be created
path_res = r'C:\Temp\Dymola'

# Name of the main working directory
import time
timestr = time.strftime("%Y%m%d_%H%M%S")
name_wkdir = r'pyDMPC_' + 'wkdir' + timestr
# Path to the Modelica libraries to be loaded
path_lib1 = r'C:\Git\pyDMPC\pyDMPC\ModelicaModels\ModelicaModels'
path_lib2 = r'C:\Git\modelica-buildings\Buildings'
path_lib3 = r'C:\Git\AixLib\AixLib'
path_lib = [path_lib1, path_lib2, path_lib3]

create_FMU = False
# Modelica model to be used as controlled system in a FMU
path_fmu = r'ModelicaModels.ControlledSystems.ControlledSystemBoundaries'

# Name of the FMU file to be created
name_fmu = 'pyDMPCFMU'

# Path to the *.egg file containing the Python-Dymola-Interface
path_dymola = r'C:\Program Files\Dymola 2019\Modelica\Library\python_interface\dymola.egg'

""" Simulation settings """
# Start time of simulation in seconds
start_time = 0.0

# Stop time of simulation in seconds
stop_time = prediction_horizon

# Increments of the equidistant output time grid
incr = 10

# Tolerance for the Modelica solver
tol = 0.0001

# Initial conditions for the optimization
init_conds = [50]

""" Setting for the *.mat files to be used in Dymola """
fileName_BCsInputTable = 'variation'
tableName_BCsInputTable = 'tab1'
fileName_DVsInputTable = 'decisionVariables'
tableName_DVsInputTable = 'tab1'
fileName_Cost = 'exDestArr'
tableName_Cost = 'tab1'
fileName_Output = 'outputs'
tableName_Output = 'output'

""" Same values for all subsystems !priority if not 'None'! """
init_DecVars_global = 0
num_BCs_global = 2
num_VarsOut_global = 2
bounds_DVs_global = None
names_BCs_global = names_SPs = ['temperature', 'humidity']
output_vars_global = None
amount_subsystems = 5

name = []
position = []
type_subSyst = []
num_DecVars = []
num_VarsOut = []
sim_time = []
init_DecVars = []
num_BCs = [] # up to 4 because of modelicares.exps.doe.fullfact
bounds_DVs = []
model_path = []
names_DVs = []
names_BCs = []
output_vars = []
initial_names= [] #for simulation
IDs_initial_values= [] #for simulation
cost_par = [] #for MassFlowRate
IDs_inputs = []
cost_factor = []
model_type = []

""" Subsystems """
# Heat recovery system
name.append('Heat_recovery_system')
position.append(5)
type_subSyst.append('generator')
num_DecVars.append(1)
num_VarsOut.append(2)
bounds_DVs.append([10,100])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.HeatRecovery')
names_DVs.append('valveHRS')
output_vars.append(["supplyAirTemperature.T","supplyAirHumidity.phi"])
initial_names.append(["hex.ele[1].mas.T","hex.ele[2].mas.T","hex.ele[3].mas.T","hex.ele[4].mas.T"])
IDs_initial_values.append(["inOutletsOutgoingHexele1masT","inOutletsOutgoingHexele2masT","inOutletsOutgoingHexele3masT","inOutletsOutgoingHexele4masT"])
IDs_inputs.append(['outdoorHumidityOutput','outdoorTemperatureOutput','roomHumidityOutput','roomTemperatureOutput'])
cost_par.append(None)
cost_factor.append(0)
model_type.append("MLP")

# Pre-heater
name.append('Pre_heater')
position.append(4)
type_subSyst.append('distributor')
num_DecVars.append(1)
num_VarsOut.append(2)
bounds_DVs.append([0,100])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.PreHeater')
names_DVs.append('valvePreHeater')
output_vars.append(["supplyAirTemperature.T","supplyAirHumidity.phi"])
initial_names.append(["hex.ele[1].mas.T","hex.ele[2].mas.T","hex.ele[3].mas.T","hex.ele[4].mas.T"])
IDs_initial_values.append(["preHeaterhexele1masT","preHeaterhexele2masT","preHeaterhexele3masT","preHeaterhexele4masT"])
IDs_inputs.append(["hRCHumidityOutput","hRCTemperatureCOutput"])
cost_par.append('val.port_1.m_flow')
cost_factor.append(0.5)
model_type.append("MLP")

# Cooler
name.append('Cooler')
position.append(3)
type_subSyst.append('distributor')
num_DecVars.append(1)
num_VarsOut.append(2)
bounds_DVs.append([0,100])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.Cooler')
names_DVs.append('valveCooler')
output_vars.append(["supplyAirTemperature.T","supplyAirHumidity.phi"])
initial_names.append(["hex.ele[1].mas.T","hex.ele[2].mas.T","hex.ele[3].mas.T","hex.ele[4].mas.T"])
IDs_initial_values.append(["coolerhexele1masT","coolerhexele2masT","coolerhexele3masT","coolerhexele4masT"])
IDs_inputs.append(["preHeaterHumidityOutput","preHeaterTemperatureCOutput"])
cost_par.append('CoolerValve.port_b.m_flow')
cost_factor.append(0.5)
model_type.append("MLP")

# Heater
name.append('Heater')
position.append(2)
type_subSyst.append('distributor')
num_DecVars.append(1)
num_VarsOut.append(2)
bounds_DVs.append([0,100])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.Heater')
names_DVs.append('valveHeater')
output_vars.append(["supplyAirTemperature.T","supplyAirHumidity.phi"])
initial_names.append(["hex.ele[1].mas.T","hex.ele[2].mas.T","hex.ele[3].mas.T","hex.ele[4].mas.T"])
IDs_initial_values.append(["heaterhexele1masT","heaterhexele2masT","heaterhexele3masT","heaterhexele4masT"])
IDs_inputs.append(["coolerHumidityOutput","coolerTemperatureCOutput"])
cost_par.append('val.port_1.m_flow')
cost_factor.append(0.5)
model_type.append("MLP")

# Steam_humidifier
name.append('Steam_humidifier')
position.append(1)
type_subSyst.append('consumer')
num_DecVars.append(1)
num_VarsOut.append(2)
bounds_DVs.append([0,0])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.Humidifier')
names_DVs.append('humidifierWSP1')
output_vars.append(["supplyAirTemperature.T","supplyAirHumidity.phi"])
initial_names.append(["hex.ele[1].mas.T","hex.ele[2].mas.T","hex.ele[3].mas.T","hex.ele[4].mas.T"])
IDs_initial_values.append(["heaterhexele1masT","heaterhexele2masT","heaterhexele3masT","heaterhexele4masT"])
IDs_inputs.append(["heaterHumidityOutput","heaterTemperatureCOutput"])
cost_par.append('product3.y')
cost_factor.append(0.5)
model_type.append("MLP")
