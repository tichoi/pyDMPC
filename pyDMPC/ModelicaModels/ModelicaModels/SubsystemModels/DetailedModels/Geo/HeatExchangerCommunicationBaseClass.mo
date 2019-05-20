within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model HeatExchangerCommunicationBaseClass
  "Base class containing the communication blocks for the heat exchanger models"

  replaceable package MediumWater = AixLib.Media.Water;

  Modelica.Fluid.Sources.MassFlowSource_T IntakeAirSource(
    m_flow=0.5,
    redeclare package Medium = MediumWater,
    T=30 + 273.15,
    use_T_in=true,
    use_X_in=false,
    use_m_flow_in=false)
    annotation (Placement(transformation(extent={{-120,2},{-100,22}})));
  Modelica.Fluid.Sources.Boundary_pT IntakeAirSink(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    use_X_in=false,
    use_p_in=false,
    p(displayUnit="Pa") = 101300,
    nPorts=1)
    annotation (Placement(transformation(extent={{190,2},{170,22}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-190,110})));

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

  AixLib.Fluid.Sensors.Temperature supplyTemperature(redeclare package Medium =
        MediumWater) "Temperature of supply water"
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
equation

  connect(toKelvin.Kelvin, IntakeAirSource.T_in) annotation (Line(points={{-190,99},
          {-190,16},{-122,16}},     color={0,0,127}));
  connect(variation.y[1], toKelvin.Celsius) annotation (Line(points={{-219,140},
          {-190,140},{-190,122}}, color={0,0,127}));
  connect(MeasuredData.y[1], toKelvin3.Celsius) annotation (Line(points={{-204.3,
          203},{-132,203},{-132,182}}, color={0,0,127}));
  connect(supplyTemperature.T, fromKelvin.Kelvin)
    annotation (Line(points={{111,48},{174,48},{174,48}}, color={0,0,127}));
  connect(MeasuredData.y[2], convertPercent.u) annotation (Line(points={{-204.3,
          203},{-100,203},{-100,175.2}}, color={0,0,127}));
  connect(massFlow.port_b, IntakeAirSink.ports[1])
    annotation (Line(points={{128,12},{170,12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-200},
            {200,220}})),       Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-240,-200},{200,220}})));
end HeatExchangerCommunicationBaseClass;
