within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Field "Simplified model of geothermal field"
  extends HeatExchangerCommunicationBaseClass(IntakeAirSource(nPorts=1));
  replaceable package Water = AixLib.Media.Water;
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
        rotation=0,
        origin={10,38})));
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
          {-10,62},{-10,38},{0,38}},       color={191,0,0}));
  connect(fixedTemperature.port, thermalResistor.port_a)
    annotation (Line(points={{-40,62},{-30,62}}, color={191,0,0}));
  connect(IntakeAirSource.ports[1], vol.ports[1]) annotation (Line(points={{-100,12},
          {-54,12},{-54,28},{7.33333,28}},     color={0,127,255}));
  connect(supplyTemperature.port, vol.ports[2]) annotation (Line(points={{104,
          38},{58,38},{58,28},{10,28}}, color={0,127,255}));
  connect(vol.ports[3], massFlow.port_a) annotation (Line(points={{12.6667,28},
          {64,28},{64,12},{116,12}}, color={0,127,255}));
end Field;
