""" Neccessary specifications (user) """

"""System configuration"""
name_system = 'Geo'
amount_consumer = 1
amount_generator = 1

"""Data point IDs in the controlled system"""
measurements_IDs = ['fieldTemperature', 'buidlingTemperature','buildingNeed',
                    'fieldMassflow_out', 'buildingMassflow_out']

""" General algorithm settings """
algorithm = 'BExMoC'   #choices: 'NC_DMPC', 'BExMoC'
parallelization = False  #run calculations in parallel if possible
realtime = False         #Choose True for a real-life experiment

""" Settings for BExMoC algorithm """
# So far: For all subsystems the same settings
factors_BCs = [5, 0.03]              # order: BC1, BC2, ...
center_vals_BCs = [15, 0.001]
amount_lower_vals = [2, 0]
amount_upper_vals = [2, 1]
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
path_res = r'C:\mst\dymola'

# Name of the main working directory
import time
timestr = time.strftime("%Y%m%d_%H%M%S")
name_wkdir = r'pyDMPC_' + 'wkdir' + timestr

# Path to the Modelica libraries to be loaded
path_lib1 = r'C:\mst\pyDMPC\pyDMPC\ModelicaModels\ModelicaModels'
path_lib2 = r'C:\mst\modelica-buildings\Buildings'
path_lib3 = r'C:\mst\AixLib\Aixlib'
path_lib = [path_lib1, path_lib2, path_lib3]

create_FMU = False
# Modelica model to be used as controlled system in a FMU
path_fmu = r'ModelicaModels.ControlledSystems.SimpleModelGeo'

# Name of the FMU file to be created
name_fmu = 'pyDMPCFMU_Geo'

# Path to the *.egg file containing the Python-Dymola-Interface
path_dymola = r'C:\Program Files (x86)\Dymola 2018\Modelica\Library\python_interface\dymola.egg'

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
names_BCs_global = names_SPs = ['temperature', 'massflow']
output_vars_global = None
amount_subsystems = 2

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
T_set = []
Q_set = []

""" Subsystems """
# Ground
name.append('Geothermal_Field')
position.append(2)
type_subSyst.append('generator')
num_DecVars.append(0)
num_VarsOut.append(2)
bounds_DVs.append([0,0])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.Geo.Field')
names_DVs.append(None)
output_vars.append(["supplyTemperature.T","massFlow.m_flow"])
initial_names.append([])
IDs_initial_values.append([])
IDs_inputs.append(["fieldTemperature_in","fieldMassflow_in"])
cost_par.append("decisionVariables.y[1]")
T_set.append(285)
Q_set.append(2200)
    

# Building
name.append('Building')
position.append(1)
type_subSyst.append('consumer')
num_DecVars.append(1)
num_VarsOut.append(2)
bounds_DVs.append([0,100])
model_path.append('ModelicaModels.SubsystemModels.DetailedModels.Geo.Building')
names_DVs.append('valveQflow')
output_vars.append(["supplyTemperature.T","massFlow.m_flow"])
initial_names.append([])
IDs_initial_values.append([])
IDs_inputs.append(["buildingMassflow_in","buildingTemperature_in"])
cost_par.append("decisionVariables.y[1]")
T_set.append(295)
Q_set.append(0)
