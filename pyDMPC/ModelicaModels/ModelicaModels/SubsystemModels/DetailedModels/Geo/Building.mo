within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Building "Simplified building model"
  extends HeatExchangerCommunicationBaseClass(IntakeAirSource(nPorts=1));
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Water,
    m_flow_nominal=100,
    V=200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    p_start=100000,
    nPorts=2)                    annotation (
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
  AixLib.Fluid.Geothermal.Borefields.TwoUTubes borFie(redeclare package Medium =
        Water,
    borFieDat(
      filDat=AixLib.Fluid.Geothermal.Borefields.Data.Filling.Bentonite(),
      soiDat=AixLib.Fluid.Geothermal.Borefields.Data.Soil.SandStone(),
      conDat=AixLib.Fluid.Geothermal.Borefields.Data.Configuration.Example(
          borCon=AixLib.Fluid.Geothermal.Borefields.Types.BoreholeConfiguration.DoubleUTubeParallel,
          cooBor=[0,0; 0,6; 6,0; 6,6; 0,12; 12,0; 12,12; 0,18; 18,0; 18,18; 6,12;
          6,18; 12,6; 18,6; 18,12; 12,18; 24,0; 0,24; 6,24; 12,24; 18,24; 24,24;
          24,18; 24,12; 24,6; 0,30; 6,30; 12,30; 18,30; 24,30; 30,30; 30,24; 30,
          18; 30,12; 30,6; 30,0; 0,36; 6,36; 12,36; 18,36; 24,36; 30,36; 36,36;
          36,30; 36,24; 36,18; 36,12; 36,6; 36,0])),
    show_T=false,
    TExt0_start=285.15)
               annotation (Placement(
        transformation(
        extent={{-27,-26},{27,26}},
        rotation=0,
        origin={63,12})));
equation
  connect(prescribedHeatFlow.port, vol1.heatPort) annotation (Line(points={{-40,
          -58},{-26,-58},{-26,42},{-16,42}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, maxHeatFlowRate.y)
    annotation (Line(points={{-64,-58},{-73.4,-58}}, color={0,0,127}));
  connect(decisionVariables.y[1], maxHeatFlowRate.u) annotation (Line(points={{
          -99,-110},{-92,-110},{-92,-58},{-87.2,-58}}, color={0,0,127}));
  connect(IntakeAirSource.ports[1], vol1.ports[1]) annotation (Line(points={{-100,12},
          {-74,12},{-74,32},{-8,32}},                color={0,127,255}));
  connect(vol1.ports[2], borFie.port_a) annotation (Line(points={{-4,32},{14,32},
          {14,12},{36,12}}, color={0,127,255}));
  connect(borFie.port_b, supplyTemperature.port) annotation (Line(points={{90,12},
          {90,-2},{106,-2},{106,38},{104,38}}, color={0,127,255}));
  connect(supplyTemperature.port, massFlow.port_a)
    annotation (Line(points={{104,38},{104,12},{116,12}}, color={0,127,255}));
end Building;
