within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Field_new "Simplified model of geothermal field"
  extends HeatExchangerCommunicationBaseClass2(
    cp_water(k=4180),
    variation(fileName="C:/mst/dymola/Geo_long/variation.mat", columns=1:3),
    MeasuredData(table=[0.0,0.0,0.0; 0.0,0.0,0.0; 0.0,0.0,0.0; 0.0,0.0,0.0; 0.0,
          0.0,0.0; 0.0,0.0,0.0; 0.0,0.0,0.0], tableOnFile=true),
    decisionVariables(table=[0.0,0.0,0.0; 0.0,0.0,0.0; 0.0,0.0,0.0; 0.0,0.0,0.0;
          0.0,0.0,0.0; 0.0,0.0,0.0], tableOnFile=true),
    add1(k2=-1),
    Kelvin(k=273.15),
    supplyTemperature(T(start=285.15, fixed=true)),
    IntakeAirSource(nPorts=1),
    massFlow(m_flow(start=12.25)));
  replaceable package Water = AixLib.Media.Water;

  AixLib.Fluid.Geothermal.Borefields.TwoUTubes borFie(redeclare package Medium
      = Water,
    borFieDat(
      filDat=AixLib.Fluid.Geothermal.Borefields.Data.Filling.Bentonite(),
      soiDat=AixLib.Fluid.Geothermal.Borefields.Data.Soil.SandStone(),
      conDat=AixLib.Fluid.Geothermal.Borefields.Data.Configuration.Example(
          borCon=AixLib.Fluid.Geothermal.Borefields.Types.BoreholeConfiguration.DoubleUTubeParallel,
          cooBor=[0,0; 0,6; 6,0; 6,6; 0,12; 12,0; 12,12; 0,18; 18,0; 18,18; 6,
          12; 6,18; 12,6; 18,6; 18,12; 12,18; 24,0; 0,24; 6,24; 12,24; 18,24;
          24,24; 24,18; 24,12; 24,6; 0,30; 6,30; 12,30; 18,30; 24,30; 30,30; 30,
          24; 30,18; 30,12; 30,6; 30,0; 0,36; 6,36; 12,36; 18,36; 24,36; 30,36;
          36,36; 36,30; 36,24; 36,18; 36,12; 36,6; 36,0])),
    show_T=false,
    TExt0_start=285.15)
               annotation (Placement(
        transformation(
        extent={{-27,-26},{27,26}},
        rotation=0,
        origin={5,12})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=borFie.borFieDat.conDat.nBor)
    annotation (Placement(transformation(extent={{-162,66},{-142,86}})));
equation
  connect(IntakeAirSource.ports[1], borFie.port_a)
    annotation (Line(points={{-58,12},{-22,12}}, color={0,127,255}));
  connect(borFie.port_b, massFlow.port_a)
    annotation (Line(points={{32,12},{116,12}}, color={0,127,255}));
  connect(supplyTemperature.T, add.u1)
    annotation (Line(points={{111,48},{111,62},{-180,62}}, color={0,0,127}));
  connect(supplyTemperature.port, borFie.port_b) annotation (Line(points={{104,
          38},{90,38},{90,20},{32,20},{32,12}}, color={0,127,255}));
  connect(realExpression.y, product1.u2)
    annotation (Line(points={{-141,76},{-116,76}}, color={0,0,127}));
end Field_new;
