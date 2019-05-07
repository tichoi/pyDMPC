within ModelicaModels.SubsystemModels.DetailedModels;
model ModelGeo
  extends Modelica.Icons.Example;
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.Sources.FixedBoundary bou(          redeclare package Medium =
        Water,
    p=100000,
    T=285.15,
    nPorts=1)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,-30})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-26,-52},{-6,-32}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=4,
    offset=20,
    freqHz=1/86400)
    annotation (Placement(transformation(extent={{66,-78},{86,-58}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Water,
    m_flow_nominal=100,
    V=200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    p_start=100000,
    nPorts=3)                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={82,14})));
  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Water,
    zeta=0.1,
    m_flow_nominal=100,
    diameter=0.5,
    m_flow_start=0)
    annotation (Placement(transformation(extent={{-22,14},{-2,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{62,70},{82,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,-84})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Water,
    m_flow_small=1,
    m_flow_start=50,
    inputType=AixLib.Fluid.Types.InputType.Constant,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{-2,-26},{-22,-6}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=2200,
    width=50,
    period=31536000)
    annotation (Placement(transformation(extent={{8,80},{20,92}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    amplitude=2200,
    width=50,
    period=31536000,
    startTime=15768000)
    annotation (Placement(transformation(extent={{-20,60},{-8,72}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{8,50},{20,62}})));
  Modelica.Blocks.Sources.Constant const(k=-1)
    annotation (Placement(transformation(extent={{-20,40},{-8,52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{46,46},{66,66}})));
  AixLib.Fluid.HeatExchangers.Geothermal.GeothermalField.CoaxialPipeField
    coaxialPipeField annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={-66,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(
                                                                          T=283.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-46,-84})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(
                                                                          T=283.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-36})));
  AixLib.Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed
    annotation (Placement(transformation(extent={{16,-6},{46,14}})));
equation
  connect(prescribedHeatFlow.port, vol1.heatPort) annotation (Line(points={{82,80},
          {82,24}},                 color={191,0,0}));
  connect(pulse1.y, product.u1) annotation (Line(points={{-7.4,66},{-2,66},{-2,59.6},
          {6.8,59.6}}, color={0,0,127}));
  connect(const.y, product.u2) annotation (Line(points={{-7.4,46},{-4,46},{-4,48},
          {6.8,48},{6.8,52.4}}, color={0,0,127}));
  connect(pulse.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{20.6,86},
          {42,86},{42,80},{62,80}}, color={0,0,127}));
  connect(product.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{20.6,56},{46,56}}, color={0,0,127}));
  connect(prescribedHeatFlow1.port, vol1.heatPort) annotation (Line(points={{66,
          56},{74,56},{74,28},{82,28},{82,24}}, color={191,0,0}));
  connect(fan.port_b, coaxialPipeField.fieldFluidIn) annotation (Line(points={{
          -22,-16},{-52,-16},{-52,-7}}, color={0,127,255}));
  connect(coaxialPipeField.fieldFluidOut, hydraulicResistance.port_a)
    annotation (Line(points={{-52,7},{-48,7},{-48,24},{-22,24}}, color={0,127,
          255}));
  connect(temperature.port, coaxialPipeField.fieldFluidOut) annotation (Line(
        points={{-16,-52},{-40,-52},{-40,7},{-52,7}}, color={0,127,255}));
  connect(fixedTemperature2.port, coaxialPipeField.geothermalGradient)
    annotation (Line(points={{-82,-26},{-82,0},{-69.5,0},{-69.5,0.175}}, color=
          {191,0,0}));
  connect(coaxialPipeField.groundTemperature, fixedTemperature1.port)
    annotation (Line(points={{-52,0},{-46,0},{-46,-74}}, color={191,0,0}));
  connect(coaxialPipeField.fixedBoundaryTemperature, fixedTemperature.port)
    annotation (Line(points={{-63.2,-14},{-64,-14},{-64,-66},{-76,-66},{-76,-74}},
        color={191,0,0}));
  connect(fan.port_a, heatPumpDetailed.port_evaOut) annotation (Line(points={{
          -2,-16},{8,-16},{8,-12},{18,-12},{18,-3}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, heatPumpDetailed.port_evaIn) annotation (
      Line(points={{-2,24},{16,24},{16,11},{18,11}}, color={0,127,255}));
  connect(heatPumpDetailed.port_conOut, vol1.ports[1]) annotation (Line(points={{44,11},
          {56,11},{56,16.6667},{72,16.6667}},          color={0,127,255}));
  connect(heatPumpDetailed.port_conIn, vol1.ports[2]) annotation (Line(points={
          {44,-3},{56,-3},{56,2},{72,2},{72,14}}, color={0,127,255}));
  connect(bou.ports[1], vol1.ports[3]) annotation (Line(points={{84,-40},{72,
          -40},{72,11.3333}}, color={0,127,255}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModelGeo;
