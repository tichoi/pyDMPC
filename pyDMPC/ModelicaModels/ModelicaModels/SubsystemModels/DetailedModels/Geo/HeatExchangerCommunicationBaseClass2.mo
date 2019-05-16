within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model HeatExchangerCommunicationBaseClass2
  "Base class containing the communication blocks for the heat exchanger models"

  replaceable package MediumWater = AixLib.Media.Water;

  Modelica.Fluid.Sources.MassFlowSource_T IntakeAirSource(
    m_flow=0.5,
    redeclare package Medium = MediumWater,
    T=30 + 273.15,
    use_T_in=true,
    use_m_flow_in=true,
    use_X_in=false)
    annotation (Placement(transformation(extent={{-78,2},{-58,22}})));
  Modelica.Fluid.Sources.Boundary_pT IntakeAirSink(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    use_X_in=false,
    use_p_in=false,
    p(displayUnit="Pa") = 101300,
    nPorts=1)
    annotation (Placement(transformation(extent={{190,2},{170,22}})));

  Modelica.Blocks.Sources.CombiTimeTable decisionVariables(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    tableName="tab1",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    fileName="decisionVariables.mat")
    "Table with decision variables"              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-110})));
  Modelica.Blocks.Sources.CombiTimeTable MeasuredData(
    tableOnFile=true,
    tableName="InputTable",
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    fileName="CompleteInput.mat",
    columns=2:3)
    annotation (Placement(transformation(extent={{-240,186},{-206,220}})));
  Modelica.Blocks.Sources.CombiTimeTable variation(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    tableName="tab1",
    columns=2:3,
    fileName="variation.mat")       "Table with control input"
                                                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-230,140})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin3 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-132,170})));

  AixLib.Fluid.Sensors.Temperature supplyTemperature(redeclare package Medium
      = MediumWater) "Temperature of supply water"
    annotation (Placement(transformation(extent={{94,38},{114,58}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={186,48})));

  Modelica.Blocks.Math.Gain convertPercent(k=1/100) "Convert from percent"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-100,168})));
  AixLib.Fluid.Sensors.MassFlowRate massFlow(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{116,6},{128,18}})));
  Modelica.Blocks.Sources.Constant cp_water(k=4180) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-222,74})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-192,80})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-220,114})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-186,50})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-172,6},{-152,26}})));
  Modelica.Blocks.Sources.Constant Kelvin(k=-273.15) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-228,10})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,16})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-114,72},{-94,92}})));
equation

  connect(supplyTemperature.T, fromKelvin.Kelvin)
    annotation (Line(points={{111,48},{174,48},{174,48}}, color={0,0,127}));
  connect(MeasuredData.y[2], convertPercent.u) annotation (Line(points={{-204.3,
          203},{-100,203},{-100,175.2}}, color={0,0,127}));
  connect(massFlow.port_b, IntakeAirSink.ports[1])
    annotation (Line(points={{128,12},{170,12}}, color={0,127,255}));
  connect(variation.y[2], division.u1) annotation (Line(points={{-219,140},{
          -204,140},{-204,116},{-186,116},{-186,92}}, color={0,0,127}));
  connect(product.u2, cp_water.y) annotation (Line(points={{-226,126},{-236,126},
          {-236,100},{-222,100},{-222,85}}, color={0,0,127}));
  connect(product.y, division.u2) annotation (Line(points={{-220,103},{-220,100},
          {-198,100},{-198,92}},            color={0,0,127}));
  connect(division.y, add.u2) annotation (Line(points={{-192,69},{-192,62}},
                               color={0,0,127}));
  connect(MeasuredData.y[2], toKelvin3.Celsius) annotation (Line(points={{
          -204.3,203},{-132,203},{-132,182}}, color={0,0,127}));
  connect(add.y, add1.u1)
    annotation (Line(points={{-186,39},{-186,22},{-174,22}}, color={0,0,127}));
  connect(Kelvin.y, add1.u2)
    annotation (Line(points={{-217,10},{-174,10}}, color={0,0,127}));
  connect(add1.y, toKelvin1.Celsius)
    annotation (Line(points={{-151,16},{-132,16}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, IntakeAirSource.T_in)
    annotation (Line(points={{-109,16},{-80,16}}, color={0,0,127}));
  connect(variation.y[3], product1.u1) annotation (Line(points={{-219,140},{
          -182,140},{-182,100},{-116,100},{-116,88}}, color={0,0,127}));
  connect(product1.y, IntakeAirSource.m_flow_in) annotation (Line(points={{-93,
          82},{-84,82},{-84,24},{-78,24},{-78,20}}, color={0,0,127}));
  connect(product1.y, product.u1) annotation (Line(points={{-93,82},{-93,138},{
          -214,138},{-214,126}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-200},
            {200,220}})),       Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-240,-200},{200,220}})));
end HeatExchangerCommunicationBaseClass2;
