within ModelicaModels.ControlledSystems;
model SimpleModelGeo "extends Modelica.Icons.Example;extends ModelicaModels.BaseClasses.Geo.ControlledSystemBaseClass(
                                                               volumeFlow(
        tableOnFile=false, table=[0,0.31,0.29]));"
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.Sources.FixedBoundary bou(          redeclare package Medium =
        Water,
    p=100000,
    T=285.15,
    nPorts=1)                                      annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={64,-50})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium =
        Water,
    m_flow_nominal=100,
    m_flow_small=50,
    V=900000,
    nPorts=3,
    p_start=150000,
    T_start=283.15)                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,-6})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Water,
    m_flow_nominal=100,
    V=200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    p_start=100000,
    nPorts=4)                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={54,-6})));
  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Water,
    m_flow_nominal=100,
    diameter=0.5,
    m_flow_start=0,
    zeta=0.3)
    annotation (Placement(transformation(extent={{-22,-8},{-2,12}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={54,20})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-88,-86})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=0.5)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-88,-42})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Water,
    m_flow_small=1,
    m_flow_start=50,
    inputType=AixLib.Fluid.Types.InputType.Constant,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{8,-44},{-12,-24}})));
  Modelica.Blocks.Sources.Pulse Q_flow_need_heat(
    width=50,
    period=86400,
    amplitude=2200)
    annotation (Placement(transformation(extent={{-96,88},{-88,96}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    width=50,
    period=86400,
    startTime=43200,
    amplitude=2200)
    annotation (Placement(transformation(extent={{-96,72},{-88,80}})));
  Modelica.Blocks.Math.Product Q_flow_need_cold
    annotation (Placement(transformation(extent={{-62,66},{-54,74}})));
  Modelica.Blocks.Sources.Constant const(k=-1)
    annotation (Placement(transformation(extent={{-96,56},{-88,64}})));
  Modelica.Blocks.Math.Sum Q_flow_need(nin=2)
    annotation (Placement(transformation(extent={{-36,60},{-28,68}})));
  Modelica.Blocks.Interfaces.RealOutput buildingNeed annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-24,100})));
  Modelica.Blocks.Interfaces.RealOutput fieldTemperature annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-58,-100})));
  Modelica.Blocks.Interfaces.RealOutput buildingTemperature annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={84,-100})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-50,8},{-38,-4}})));
  Modelica.Blocks.Interfaces.RealOutput fieldMassflow_out annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-44,-100})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{36,-28},{24,-40}})));
  Modelica.Blocks.Interfaces.RealOutput buildingMassflow_out annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={30,-100})));
  AixLib.Fluid.Sensors.Temperature senTem(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-68,-88},{-58,-80}})));
  AixLib.Fluid.Sensors.Temperature senTem1(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{70,-26},{80,-16}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-12,62},{-2,72}})));
  Modelica.Blocks.Interfaces.RealInput valveQflow "scaling the buildings need"
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-14,100})));
  AixLib.Fluid.Sensors.Temperature senTem2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-20,-88},{-10,-80}})));
  AixLib.Fluid.Sensors.Temperature senTem3(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{2,24},{12,34}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{22,-4},{34,8}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo3(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-26,-28},{-38,-40}})));
  Modelica.Blocks.Interfaces.RealOutput fieldTemperature_in annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-10,-100})));
  Modelica.Blocks.Interfaces.RealOutput buildingTemperature_in annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={12,100}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={0,16})));
  Modelica.Blocks.Interfaces.RealOutput fieldMassflow_in annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-32,-100})));
  Modelica.Blocks.Interfaces.RealOutput buildingMassflow_in annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={28,100})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-23,43})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-68,42},{-58,52}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
equation
  connect(pulse1.y, Q_flow_need_cold.u1) annotation (Line(points={{-87.6,76},{
          -66,76},{-66,72.4},{-62.8,72.4}}, color={0,0,127}));
  connect(const.y, Q_flow_need_cold.u2) annotation (Line(points={{-87.6,60},{
          -76,60},{-76,66},{-62.8,66},{-62.8,67.6}}, color={0,0,127}));
  connect(thermalResistor.port_b, vol.heatPort) annotation (Line(points={{-88,-36},
          {-88,-24},{-78,-24},{-78,-16}},  color={191,0,0}));
  connect(Q_flow_need_heat.y, Q_flow_need.u[1]) annotation (Line(points={{-87.6,
          92},{-46,92},{-46,63.6},{-36.8,63.6}},
                                           color={0,0,127}));
  connect(prescribedHeatFlow.port, vol1.heatPort)
    annotation (Line(points={{54,14},{54,4}},  color={191,0,0}));
  connect(senMasFlo.m_flow, fieldMassflow_out) annotation (Line(points={{-44,
          -4.6},{-44,-100}},               color={0,0,127}));
  connect(senMasFlo1.m_flow, buildingMassflow_out) annotation (Line(points={{30,
          -40.6},{30,-100}},                 color={0,0,127}));
  connect(senMasFlo.port_b, hydraulicResistance.port_a) annotation (Line(points={{-38,2},
          {-22,2}},                             color={0,127,255}));
  connect(fan.port_a, senMasFlo1.port_b)
    annotation (Line(points={{8,-34},{24,-34}}, color={0,127,255}));
  connect(senTem.T, fieldTemperature) annotation (Line(points={{-59.5,-84},{-58,
          -84},{-58,-100}},                     color={0,0,127}));
  connect(senTem1.T, buildingTemperature) annotation (Line(points={{78.5,-21},{
          84,-21},{84,-100}},   color={0,0,127}));
  connect(product.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-1.5,67},
          {16,67},{16,52},{54,52},{54,26}}, color={0,0,127}));
  connect(Q_flow_need.y, product.u2)
    annotation (Line(points={{-27.6,64},{-13,64}},
                                               color={0,0,127}));
  connect(buildingNeed, Q_flow_need.y) annotation (Line(points={{-24,100},{-24,
          64},{-27.6,64}},       color={0,0,127}));
  connect(hydraulicResistance.port_b, senMasFlo2.port_a)
    annotation (Line(points={{-2,2},{22,2}},   color={0,127,255}));
  connect(senMasFlo2.port_b, vol1.ports[1])
    annotation (Line(points={{34,2},{44,2},{44,-3}},   color={0,127,255}));
  connect(senMasFlo1.port_a, vol1.ports[2]) annotation (Line(points={{36,-34},{
          44,-34},{44,-5}},               color={0,127,255}));
  connect(bou.ports[1], vol1.ports[3]) annotation (Line(points={{64,-40},{64,
          -34},{44,-34},{44,-7}},                          color={0,127,255}));
  connect(senTem1.port, vol1.ports[4]) annotation (Line(points={{75,-26},{66,
          -26},{66,-18},{44,-18},{44,-9}},
                                  color={0,127,255}));
  connect(senMasFlo3.port_a, fan.port_b)
    annotation (Line(points={{-26,-34},{-12,-34}}, color={0,127,255}));
  connect(vol.ports[1], senMasFlo3.port_b) annotation (Line(points={{-68,
          -8.66667},{-68,-34},{-38,-34}},color={0,127,255}));
  connect(senTem2.port, fan.port_b) annotation (Line(points={{-15,-88},{-20,-88},
          {-20,-34},{-12,-34}}, color={0,127,255}));
  connect(senTem2.T, fieldTemperature_in) annotation (Line(points={{-11.5,-84},
          {-10,-84},{-10,-100}}, color={0,0,127}));
  connect(senTem3.T, buildingTemperature_in)
    annotation (Line(points={{10.5,29},{12,29},{12,100}}, color={0,0,127}));
  connect(senMasFlo3.m_flow, fieldMassflow_in)
    annotation (Line(points={{-32,-40.6},{-32,-100}}, color={0,0,127}));
  connect(senMasFlo2.m_flow, buildingMassflow_in)
    annotation (Line(points={{28,8.6},{28,100}},  color={0,0,127}));
  connect(senTem3.port, senMasFlo2.port_a)
    annotation (Line(points={{7,24},{7,2},{22,2}},   color={0,127,255}));
  connect(vol.ports[2], senTem.port) annotation (Line(points={{-68,-6},{-68,-88},
          {-63,-88}},          color={0,127,255}));
  connect(Q_flow_need_cold.y, Q_flow_need.u[2]) annotation (Line(points={{-53.6,
          70},{-48,70},{-48,56},{-36.8,56},{-36.8,64.4}}, color={0,0,127}));
  connect(valveQflow, product.u1) annotation (Line(points={{-14,100},{-14,86},{
          -14,70},{-13,70}}, color={0,0,127}));
  connect(greaterEqual.u1, product.u2)
    annotation (Line(points={{-23,49},{-23,64},{-13,64}}, color={0,0,127}));
  connect(const1.y, greaterEqual.u2) annotation (Line(points={{-57.5,47},{
          -42.75,47},{-42.75,49},{-27,49}}, color={0,0,127}));
  connect(senMasFlo.port_a, vol.ports[3]) annotation (Line(points={{-50,2},{-68,
          2},{-68,-3.33333}}, color={0,127,255}));
  connect(fixedTemperature.port, thermalResistor.port_a)
    annotation (Line(points={{-88,-80},{-88,-48}}, color={191,0,0}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end SimpleModelGeo;
