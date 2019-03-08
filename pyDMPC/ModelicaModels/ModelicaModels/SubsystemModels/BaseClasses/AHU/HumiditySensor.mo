within ModelicaModels.SubsystemModels.BaseClasses.AHU;
model HumiditySensor "Mockup of a humidity sensor"
  extends Modelica.Blocks.Math.Add;
  Modelica.Blocks.Interfaces.RealOutput phi "Connector of Real output signals"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));

equation
  phi = y;

end HumiditySensor;
