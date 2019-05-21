within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Building "Simplified building model"
  extends HeatExchangerCommunicationBaseClass(IntakeAirSource(nPorts=1, m_flow=
          16));
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    nPorts=3,
    p_start=100000,
    m_flow_nominal=16,
    V=2)                         annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-6,42})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-52,-58})));
  Modelica.Blocks.Math.Gain maxHeatFlowRate(k=0.02) "Convert from percent"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-84,-110})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-62,-114},{-42,-94}})));
  Modelica.Blocks.Sources.Constant const(k=-10000)
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
equation
  connect(prescribedHeatFlow.port, vol1.heatPort) annotation (Line(points={{-40,
          -58},{-26,-58},{-26,42},{-16,42}}, color={191,0,0}));
  connect(decisionVariables.y[1], maxHeatFlowRate.u) annotation (Line(points={{-99,
          -110},{-91.2,-110}},                         color={0,0,127}));
  connect(IntakeAirSource.ports[1], vol1.ports[1]) annotation (Line(points={{-100,12},
          {-74,12},{-74,32},{-8.66667,32}},          color={0,127,255}));
  connect(vol1.ports[2], massFlow.port_a) annotation (Line(points={{-6,32},{56,
          32},{56,12},{116,12}}, color={0,127,255}));
  connect(vol1.ports[3], supplyTemperature.port) annotation (Line(points={{
          -3.33333,32},{104,32},{104,38}}, color={0,127,255}));
  connect(maxHeatFlowRate.y, product1.u2)
    annotation (Line(points={{-77.4,-110},{-64,-110}}, color={0,0,127}));
  connect(product1.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-41,
          -104},{-36,-104},{-36,-80},{-84,-80},{-84,-58},{-64,-58}}, color={0,0,
          127}));
  connect(const.y, product1.u1) annotation (Line(points={{-99,-70},{-92,-70},{
          -92,-98},{-64,-98}}, color={0,0,127}));
end Building;
