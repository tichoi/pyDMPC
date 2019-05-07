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
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={64,-50})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Water,
    m_flow_nominal=100,
    V=200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_small=50,
    p_start=100000)              annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={64,-4})));
  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Water,
    m_flow_nominal=100,
    diameter=0.5,
    m_flow_start=0,
    zeta=0.3)
    annotation (Placement(transformation(extent={{-34,-8},{-14,12}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={64,30})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Water,
    m_flow_small=1,
    m_flow_start=50,
    inputType=AixLib.Fluid.Types.InputType.Constant,
    m_flow_nominal=25)
    annotation (Placement(transformation(extent={{6,-42},{-14,-22}})));
  Modelica.Blocks.Sources.Pulse Q_flow_need_heat(
    width=50,
    period=86400,
    amplitude=2200)
    annotation (Placement(transformation(extent={{-96,88},{-88,96}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    width=50,
    period=86400,
    startTime=43200,
    amplitude=2200)
    annotation (Placement(transformation(extent={{-96,72},{-88,80}})));
  Modelica.Blocks.Math.Product Q_flow_need_cold
    annotation (Placement(transformation(extent={{-62,66},{-54,74}})));
  Modelica.Blocks.Sources.Constant const(k=-1)
    annotation (Placement(transformation(extent={{-96,56},{-88,64}})));
  Modelica.Blocks.Math.Sum Q_flow_need(nin=2)
    annotation (Placement(transformation(extent={{-36,60},{-28,68}})));
  Modelica.Blocks.Interfaces.RealOutput buildingNeed annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-24,100})));
  Modelica.Blocks.Interfaces.RealOutput fieldTemperature annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-58,-100})));
  Modelica.Blocks.Interfaces.RealOutput buildingTemperature annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={84,-100})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-50,8},{-38,-4}})));
  Modelica.Blocks.Interfaces.RealOutput fieldMassflow_out annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-44,-100})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{26,-26},{14,-38}})));
  Modelica.Blocks.Interfaces.RealOutput buildingMassflow_out annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={30,-100})));
  AixLib.Fluid.Sensors.Temperature senTem(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-68,-88},{-58,-80}})));
  AixLib.Fluid.Sensors.Temperature senTem1(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{90,10},{100,20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-12,62},{-2,72}})));
  Modelica.Blocks.Interfaces.RealInput valveQflow "scaling the buildings need"
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-14,100})));
  AixLib.Fluid.Sensors.Temperature senTem2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-20,-88},{-10,-80}})));
  AixLib.Fluid.Sensors.Temperature senTem3(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-12,20},{-2,30}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{6,-4},{18,8}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo3(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-26,-26},{-38,-38}})));
  Modelica.Blocks.Interfaces.RealOutput fieldTemperature_in annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-10,-100})));
  Modelica.Blocks.Interfaces.RealOutput buildingTemperature_in annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={12,100})));
  Modelica.Blocks.Interfaces.RealOutput fieldMassflow_in annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-32,-100})));
  Modelica.Blocks.Interfaces.RealOutput buildingMassflow_in annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={28,100})));
  AixLib.Fluid.Geothermal.Borefields.TwoUTubes borFie(redeclare package Medium =
        Water) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,-14})));
equation
  connect(pulse1.y, Q_flow_need_cold.u1) annotation (Line(points={{-87.6,76},{
          -66,76},{-66,72.4},{-62.8,72.4}}, color={0,0,127}));
  connect(const.y, Q_flow_need_cold.u2) annotation (Line(points={{-87.6,60},{
          -76,60},{-76,66},{-62.8,66},{-62.8,67.6}}, color={0,0,127}));
  connect(Q_flow_need_heat.y, Q_flow_need.u[1]) annotation (Line(points={{-87.6,
          92},{-46,92},{-46,63.6},{-36.8,63.6}},
                                           color={0,0,127}));
  connect(prescribedHeatFlow.port, vol1.heatPort)
    annotation (Line(points={{64,24},{64,6}},  color={191,0,0}));
  connect(senMasFlo.m_flow, fieldMassflow_out) annotation (Line(points={{-44,
          -4.6},{-44,-100}},               color={0,0,127}));
  connect(senMasFlo1.m_flow, buildingMassflow_out) annotation (Line(points={{20,
          -38.6},{20,-70},{30,-70},{30,-100}},
                                             color={0,0,127}));
  connect(senMasFlo.port_b, hydraulicResistance.port_a) annotation (Line(points={{-38,2},
          {-34,2}},                             color={0,127,255}));
  connect(fan.port_a, senMasFlo1.port_b)
    annotation (Line(points={{6,-32},{14,-32}}, color={0,127,255}));
  connect(senTem.T, fieldTemperature) annotation (Line(points={{-59.5,-84},{-58,
          -84},{-58,-100}},                     color={0,0,127}));
  connect(senTem1.T, buildingTemperature) annotation (Line(points={{98.5,15},{
          84,15},{84,-100}},    color={0,0,127}));
  connect(product.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-1.5,67},
          {16,67},{16,52},{64,52},{64,36}}, color={0,0,127}));
  connect(Q_flow_need.y, product.u2)
    annotation (Line(points={{-27.6,64},{-13,64}},
                                               color={0,0,127}));
  connect(buildingNeed, Q_flow_need.y) annotation (Line(points={{-24,100},{-24,
          64},{-27.6,64}},       color={0,0,127}));
  connect(hydraulicResistance.port_b, senMasFlo2.port_a)
    annotation (Line(points={{-14,2},{6,2}},   color={0,127,255}));
  connect(senMasFlo3.port_a, fan.port_b)
    annotation (Line(points={{-26,-32},{-14,-32}}, color={0,127,255}));
  connect(senTem2.port, fan.port_b) annotation (Line(points={{-15,-88},{-20,-88},
          {-20,-32},{-14,-32}}, color={0,127,255}));
  connect(senTem2.T, fieldTemperature_in) annotation (Line(points={{-11.5,-84},
          {-10,-84},{-10,-100}}, color={0,0,127}));
  connect(senTem3.T, buildingTemperature_in)
    annotation (Line(points={{-3.5,25},{12,25},{12,100}}, color={0,0,127}));
  connect(senMasFlo3.m_flow, fieldMassflow_in)
    annotation (Line(points={{-32,-38.6},{-32,-100}}, color={0,0,127}));
  connect(senMasFlo2.m_flow, buildingMassflow_in)
    annotation (Line(points={{12,8.6},{12,54},{28,54},{28,100}},
                                                  color={0,0,127}));
  connect(senTem3.port, senMasFlo2.port_a)
    annotation (Line(points={{-7,20},{-7,2},{6,2}},  color={0,127,255}));
  connect(Q_flow_need_cold.y, Q_flow_need.u[2]) annotation (Line(points={{-53.6,
          70},{-48,70},{-48,56},{-36.8,56},{-36.8,64.4}}, color={0,0,127}));
  connect(valveQflow, product.u1) annotation (Line(points={{-14,100},{-14,86},{
          -14,70},{-13,70}}, color={0,0,127}));
  connect(senMasFlo3.port_b, borFie.port_a) annotation (Line(points={{-38,-32},
          {-82,-32},{-82,-24}},                    color={0,127,255}));
  connect(borFie.port_b, senMasFlo.port_a) annotation (Line(points={{-82,-4},{-66,
          -4},{-66,2},{-50,2}}, color={0,127,255}));
  connect(senTem.port, borFie.port_a) annotation (Line(points={{-63,-88},{-76,-88},
          {-76,-70},{-82,-70},{-82,-24}}, color={0,127,255}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end SimpleModelGeo_2;
