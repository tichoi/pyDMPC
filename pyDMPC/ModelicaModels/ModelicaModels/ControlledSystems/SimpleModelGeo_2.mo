within ModelicaModels.ControlledSystems;
model SimpleModelGeo_2 "extends Modelica.Icons.Example;extends ModelicaModels.BaseClasses.Geo.ControlledSystemBaseClass(
                                                               volumeFlow(
        tableOnFile=false, table=[0,0.31,0.29]));"
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.Sources.FixedBoundary bou(          redeclare package Medium =
        Water,
    p=100000,
    T=285.15)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,-30})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Water,
    m_flow_small=1,
    m_flow_start=50,
    inputType=AixLib.Fluid.Types.InputType.Constant,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{10,-44},{-10,-24}})));
  Subsystems.Geo.GeothermalHeatPump geothermalHeatPump
    annotation (Placement(transformation(extent={{18,2},{50,22}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleModelGeo_2;
