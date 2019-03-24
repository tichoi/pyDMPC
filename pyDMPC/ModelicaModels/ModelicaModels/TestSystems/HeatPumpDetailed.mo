within ModelicaModels.TestSystems;
model HeatPumpDetailed
  "Example for the detailed heat pump model in order to compare to simple one."

 extends Modelica.Icons.Example;
  replaceable package Medium_sin = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package Medium_sou = AixLib.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  .AixLib.Fluid.HeatPumps.HeatPumpDetailed heatPump(
    P_eleOutput=true,
    capCalcType=2,
    CorrFlowCo=false,
    CorrFlowEv=false,
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    PT1_cycle=true,
    mFlow_conNominal=1,
    mFlow_evaNominal=1,
    T_evaIn(transferHeat=true, TAmb=291.15),
    T_evaOut(transferHeat=true, TAmb=291.15),
    T_conIn(transferHeat=true, TAmb=273.15),
    T_conOut(transferHeat=true, TAmb=273.15),
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    timeConstantCycle=50)
    "Detailed heat pump mainly based on manufacturing data"
    annotation (Placement(transformation(extent={{-16,14},{14,-6}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceSideMassFlowSource(
    use_T_in=true,
    m_flow=1,
    redeclare package Medium = Medium_sou,
    nPorts=1,
    T=275.15) "Ideal mass flow source at the inlet of the source side"
    annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));

  AixLib.Fluid.Sources.FixedBoundary sourceSideFixedBoundary(redeclare package
      Medium = Medium_sou, nPorts=1)
    "Fixed boundary at the outlet of the source side" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-80,36})));
  Modelica.Blocks.Sources.Constant TsuSource(k=273.15 + 10)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,-84},{-74,-64}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTAct(
    final transferHeat=true,
    final m_flow_nominal=heatPump.mFlow_conNominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_sin,
    final T_start=303.15,
    final TAmb=291.15) "Temperature at sink  inlet" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={54,-64})));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 30,
    uHigh=273.15 + 40)
    annotation (Placement(transformation(extent={{40,50},{20,70}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumSou(
    redeclare final package Medium = Medium_sin,
    redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,

    final allowFlowReversal=true,
    final addPowerToMedium=false,
    m_flow_nominal=1) "Fan or pump at source side of HP" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,12})));
  AixLib.Fluid.MixingVolumes.MixingVolume Room(
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=heatPump.mFlow_conNominal,
    redeclare package Medium = Medium_sin,
    final allowFlowReversal=true,
    final V=0.5) "Volume of Condenser" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={86,-20})));

  Modelica.Blocks.Sources.Constant mFlowSink(k=1) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,30})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={4,60},
        rotation=180)));
  AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(redeclare package
      Medium = Medium_sin, nPorts=1)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-64})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=-8000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,10})));
equation

  connect(TsuSource.y, sourceSideMassFlowSource.T_in) annotation (Line(
      points={{-73,-74},{-68,-74},{-68,-66},{-56,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Room.ports[1],pumSou. port_a) annotation (Line(points={{76,-18},{76,4},
          {60,4},{60,12}}, color={0,127,255}));
  connect(senTAct.T,hys. u) annotation (Line(points={{54,-53},{58,-53},{58,-8},
          {68,-8},{68,48},{74,48},{74,60},{42,60}}, color={0,0,127}));
  connect(hys.y,not2. u) annotation (Line(points={{19,60},{8.8,60}},
                color={255,0,255}));
  connect(senTAct.port_b,sinkSideFixedBoundary. ports[1]) annotation (Line(
        points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
  connect(senTAct.port_b,Room. ports[2]) annotation (Line(points={{64,-64},{66,
          -64},{66,-22},{76,-22}}, color={0,127,255}));
  connect(not2.y, heatPump.onOff_in) annotation (Line(points={{-0.4,60},{-18,60},
          {-18,-12},{-6,-12},{-6,-5}}, color={255,0,255}));
  connect(pumSou.port_b, heatPump.port_conIn) annotation (Line(points={{40,12},
          {26,12},{26,11},{12,11}}, color={0,127,255}));
  connect(heatPump.port_conOut, senTAct.port_a) annotation (Line(points={{12,-3},
          {28,-3},{28,-64},{44,-64}}, color={0,127,255}));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_evaIn) annotation (
      Line(points={{-34,-70},{-24,-70},{-24,-3},{-14,-3}}, color={0,127,255}));
  connect(heatPump.port_evaOut, sourceSideFixedBoundary.ports[1]) annotation (
      Line(points={{-14,11},{-43,11},{-43,36},{-70,36}}, color={0,127,255}));
  connect(mFlowSink.y, pumSou.m_flow_in)
    annotation (Line(points={{79,30},{50,30},{50,24}}, color={0,0,127}));
  connect(fixedHeatFlow.port, Room.heatPort) annotation (Line(points={{78,10},{
          72,10},{72,-2},{86,-2},{86,-10}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=86400, Interval=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the HeatPumpDetailed model. The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or polynomial functions.</p>
</html>",
      revisions="<html>
 <ul>
  <li>
  May 19, 2017, by Mirko Engelpracht:<br/>
  Added missing documentation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/391\">issue 391</a>).
  </li>
  <li>
  October 17, 2016, by Philipp Mehrfeld:<br/>
  Implemented especially for comparison to simple heat pump model.
  </li>
 </ul>
</html>
"));
end HeatPumpDetailed;
