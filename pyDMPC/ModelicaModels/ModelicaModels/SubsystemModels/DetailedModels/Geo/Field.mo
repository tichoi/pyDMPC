within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Field "Simplified model of geothermal field"
  extends HeatExchangerCommunicationBaseClass2(
    cp_water(k=4180000),
    IntakeAirSource(nPorts=1),
    variation(
      table=[0,1,1; 1,2,2; 2,3,3],
      tableOnFile=true,
      fileName="C:/mst/dymola/Geo_long/variation.mat",
      columns=1:3),
    decisionVariables(table=[1,2,0.0; 2,3,0.0; 4,5,0.0; 6,6,0.0], tableOnFile=
          false),
    MeasuredData(
      columns=1:2,
      table=[0,12; 3600,12.1; 7200,12.15; 10800,12.1; 14400,12.15; 18000,12;
          21600,12; 25200,12; 28800,12; 32400,12; 36000,12; 39600,12; 43200,12;
          46800,12; 50400,12; 54000,12; 57600,12; 61200,12; 64800,12; 68400,12;
          72000,12; 75600,12; 79200,12; 82800,12; 86400,12; 90000,12; 93600,12;
          97200,12; 100800,12; 104400,12; 108000,12; 111600,12; 115200,12;
          118800,12; 122400,12; 126000,12; 129600,12; 133200,12; 136800,12;
          140400,12; 144000,12; 147600,12; 151200,12; 154800,12; 158400,12;
          162000,12; 165600,12; 169200,12; 172800,12],
      tableOnFile=false),
    supplyTemperature(T(start=285)));

  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium =
        Water,
    m_flow_nominal=100,
    m_flow_small=50,
    nPorts=3,
    p_start=150000,
    T_start=285.15,
    V=900)                          annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={8,38})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-46,62})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=0.5)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-24,62})));
equation
  connect(thermalResistor.port_b,vol. heatPort) annotation (Line(points={{-18,62},
          {-10,62},{-10,38},{-2,38}},      color={191,0,0}));
  connect(fixedTemperature.port, thermalResistor.port_a)
    annotation (Line(points={{-40,62},{-30,62}}, color={191,0,0}));
  connect(IntakeAirSource.ports[1], vol.ports[1]) annotation (Line(points={{-58,12},
          {-54,12},{-54,28},{5.33333,28}},     color={0,127,255}));
  connect(supplyTemperature.port, vol.ports[2]) annotation (Line(points={{104,38},
          {58,38},{58,28},{8,28}},      color={0,127,255}));
  connect(vol.ports[3], massFlow.port_a) annotation (Line(points={{10.6667,28},
          {64,28},{64,12},{116,12}}, color={0,127,255}));
  connect(fromKelvin.Kelvin, add.u1) annotation (Line(points={{174,48},{112,48},
          {112,84},{-112,84},{-112,66},{-180,66},{-180,62}}, color={0,0,127}));
end Field;
