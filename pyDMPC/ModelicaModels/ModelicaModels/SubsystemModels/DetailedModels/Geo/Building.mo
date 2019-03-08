within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Building "Simplified building model"
  extends HeatExchangerCommunicationBaseClass(IntakeAirSource(nPorts=1));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        MediumWater,
    m_flow_nominal=100,
    V=200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    p_start=100000,
    nPorts=3)                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-6,42})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-52,-58})));
  Modelica.Blocks.Math.Gain maxHeatFlowRate(k=10)   "Convert from percent"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-80,-58})));
equation
  connect(prescribedHeatFlow.port, vol1.heatPort) annotation (Line(points={{-40,
          -58},{-26,-58},{-26,42},{-16,42}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, maxHeatFlowRate.y)
    annotation (Line(points={{-64,-58},{-73.4,-58}}, color={0,0,127}));
  connect(decisionVariables.y[1], maxHeatFlowRate.u) annotation (Line(points={{
          -99,-110},{-92,-110},{-92,-58},{-87.2,-58}}, color={0,0,127}));
  connect(IntakeAirSource.ports[1], vol1.ports[1]) annotation (Line(points={{
          -100,12},{-74,12},{-74,32},{-8.66667,32}}, color={0,127,255}));
  connect(supplyTemperature.port, vol1.ports[2]) annotation (Line(points={{104,
          38},{104,12},{28,12},{28,32},{-6,32}}, color={0,127,255}));
  connect(vol1.ports[3], massFlow.port_a) annotation (Line(points={{-3.33333,32},
          {28,32},{28,12},{116,12}}, color={0,127,255}));
end Building;
