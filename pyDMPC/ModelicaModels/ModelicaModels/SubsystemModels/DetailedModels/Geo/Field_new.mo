within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Field_new "Simplified model of geothermal field"
  extends HeatExchangerCommunicationBaseClass(IntakeAirSource(nPorts=1));
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.Geothermal.Borefields.TwoUTubes borFie(redeclare package Medium =
        Water,
    TExt0_start=285.15,
    z0=10,
    dT_dz=0.01)
               annotation (Placement(
        transformation(
        extent={{-26,-25},{26,25}},
        rotation=0,
        origin={-16,11})));
equation
  connect(IntakeAirSource.ports[1], borFie.port_a) annotation (Line(points={{-100,12},
          {-42,12},{-42,11}},                            color={0,127,255}));
  connect(borFie.port_b, massFlow.port_a) annotation (Line(points={{10,11},{22,11},
          {22,10},{116,10},{116,12}},   color={0,127,255}));
  connect(supplyTemperature.port, massFlow.port_a) annotation (Line(points={{
          104,38},{100,38},{100,8},{96,8},{96,6},{116,6},{116,12}}, color={0,
          127,255}));
end Field_new;
