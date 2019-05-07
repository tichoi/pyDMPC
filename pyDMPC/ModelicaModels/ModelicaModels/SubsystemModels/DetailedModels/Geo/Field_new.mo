within ModelicaModels.SubsystemModels.DetailedModels.Geo;
model Field_new "Simplified model of geothermal field"
  extends HeatExchangerCommunicationBaseClass(IntakeAirSource(nPorts=1));
  AixLib.Fluid.Geothermal.Borefields.TwoUTubes borFie(redeclare package Medium
      = Water) annotation (Placement(
        transformation(
        extent={{-26,-25},{26,25}},
        rotation=0,
        origin={-14,13})));
equation
  connect(IntakeAirSource.ports[1], borFie.port_a) annotation (Line(points={{
          -100,12},{-84,12},{-84,10},{-40,10},{-40,13}}, color={0,127,255}));
  connect(borFie.port_b, massFlow.port_a) annotation (Line(points={{12,13},{54,
          13},{54,6},{116,6},{116,12}}, color={0,127,255}));
  connect(supplyTemperature.port, massFlow.port_a) annotation (Line(points={{
          104,38},{100,38},{100,8},{96,8},{96,6},{116,6},{116,12}}, color={0,
          127,255}));
end Field_new;
