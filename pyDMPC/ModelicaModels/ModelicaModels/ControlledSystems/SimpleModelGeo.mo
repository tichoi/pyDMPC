within ModelicaModels.ControlledSystems;
model SimpleModelGeo
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
    annotation (Placement(transformation(extent={{-46,-52},{-26,-32}})));
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
        origin={-78,14})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Water,         nPorts=3,
    m_flow_nominal=100,
    V=200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    p_start=100000)              annotation (
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
    annotation (Placement(transformation(extent={{-12,14},{8,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{62,70},{82,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-84,-84})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=-0.001)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-84,-56})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Water,
    m_flow_small=1,
    m_flow_start=50,
    inputType=AixLib.Fluid.Types.InputType.Constant,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{8,-24},{-12,-4}})));
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
equation
  connect(hydraulicResistance.port_b, vol1.ports[1])
    annotation (Line(points={{8,24},{72,24},{72,16.6667}},
                                                       color={0,127,255}));
  connect(prescribedHeatFlow.port, vol1.heatPort) annotation (Line(points={{82,80},
          {82,24}},                 color={191,0,0}));
  connect(vol.ports[1], hydraulicResistance.port_a) annotation (Line(points={{-68,
          11.3333},{-68,24},{-12,24}},
                color={0,127,255}));
  connect(vol1.ports[2], fan.port_a) annotation (Line(points={{72,14},{72,-14},
          {8,-14}},                color={0,127,255}));
  connect(vol.ports[2], fan.port_b) annotation (Line(points={{-68,14},{-68,-14},
          {-12,-14}},         color={0,127,255}));
  connect(temperature.port, vol.ports[3]) annotation (Line(points={{-36,-52},{
          -68,-52},{-68,16.6667}},           color={0,127,255}));
  connect(fixedTemperature.port, thermalResistor.port_a)
    annotation (Line(points={{-84,-74},{-84,-66}}, color={191,0,0}));
  connect(vol1.ports[3], bou.ports[1]) annotation (Line(points={{72,11.3333},{
          72,-40},{84,-40}},
                          color={0,127,255}));
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
  connect(thermalResistor.port_b, vol.heatPort) annotation (Line(points={{-84,
          -46},{-84,-4},{-78,-4},{-78,4}}, color={191,0,0}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleModelGeo;
