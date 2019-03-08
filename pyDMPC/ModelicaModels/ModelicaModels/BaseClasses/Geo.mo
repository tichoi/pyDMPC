within ModelicaModels.BaseClasses;
package Geo
  model SimpleModelGeo "extends Modelica.Icons.Example;extends ModelicaModels.BaseClasses.Geo.ControlledSystemBaseClass(
                                                               volumeFlow(
        tableOnFile=false, table=[0,0.31,0.29]));"
    replaceable package Water = AixLib.Media.Water;
    AixLib.Fluid.Sources.FixedBoundary bou(          redeclare package Medium =
          Water,
      p=100000,
      T=285.15,
      nPorts=1)                                      annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={64,-30})));
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
          rotation=90,
          origin={-78,14})));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
          Water,         nPorts=4,
      m_flow_nominal=100,
      V=200,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_small=50,
      p_start=100000)              annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={54,14})));
    AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
      redeclare package Medium = Water,
      zeta=0.1,
      m_flow_nominal=100,
      diameter=0.5,
      m_flow_start=0)
      annotation (Placement(transformation(extent={{-22,12},{-2,32}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={54,38})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-84,-84})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=-0.001)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-84,-26})));
    AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
          Water,
      m_flow_small=1,
      m_flow_start=50,
      inputType=AixLib.Fluid.Types.InputType.Constant,
      m_flow_nominal=25)
      annotation (Placement(transformation(extent={{8,-24},{-12,-4}})));
    Modelica.Blocks.Sources.Pulse Q_flow_need_heat(
      amplitude=2200,
      width=50,
      period=31536000)
      annotation (Placement(transformation(extent={{-60,68},{-48,80}})));
    Modelica.Blocks.Sources.Pulse pulse1(
      amplitude=2200,
      width=50,
      period=31536000,
      startTime=15768000)
      annotation (Placement(transformation(extent={{-60,48},{-48,60}})));
    Modelica.Blocks.Math.Product Q_flow_need_cold
      annotation (Placement(transformation(extent={{-32,38},{-20,50}})));
    Modelica.Blocks.Sources.Constant const(k=-1)
      annotation (Placement(transformation(extent={{-60,28},{-48,40}})));
    Modelica.Blocks.Math.Sum Q_flow_need(nin=2)
      annotation (Placement(transformation(extent={{-8,48},{12,68}})));
    Modelica.Blocks.Interfaces.RealOutput buildingNeed annotation (Placement(
          transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={10,100})));
    Modelica.Blocks.Interfaces.RealOutput fieldTemperature annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=-90,
          origin={-26,-100})));
    Modelica.Blocks.Interfaces.RealOutput buildingTemperature annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=-90,
          origin={74,-100})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFlo
      annotation (Placement(transformation(extent={{-62,30},{-42,10}})));
    Modelica.Blocks.Interfaces.RealOutput fieldMassflow_out annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=-90,
          origin={-54,-100})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFlo1
      annotation (Placement(transformation(extent={{36,-4},{16,-24}})));
    Modelica.Blocks.Interfaces.RealOutput buildingMassflow_out annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=-90,
          origin={42,-100})));
    AixLib.Fluid.Sensors.Temperature senTem
      annotation (Placement(transformation(extent={{-46,-58},{-26,-38}})));
    AixLib.Fluid.Sensors.Temperature senTem1
      annotation (Placement(transformation(extent={{70,-6},{90,14}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{24,54},{44,74}})));
    Modelica.Blocks.Interfaces.RealInput valveQflow
      "scaling the buildings need" annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=-90,
          origin={27,99})));
  equation
    connect(hydraulicResistance.port_b, vol1.ports[1])
      annotation (Line(points={{-2,22},{44,22},{44,17}}, color={0,127,255}));
    connect(vol.ports[1], fan.port_b) annotation (Line(points={{-68,11.3333},{
            -68,-14},{-12,-14}},color={0,127,255}));
    connect(fixedTemperature.port, thermalResistor.port_a)
      annotation (Line(points={{-84,-74},{-84,-36}}, color={191,0,0}));
    connect(pulse1.y, Q_flow_need_cold.u1) annotation (Line(points={{-47.4,54},
            {-38,54},{-38,47.6},{-33.2,47.6}}, color={0,0,127}));
    connect(const.y, Q_flow_need_cold.u2) annotation (Line(points={{-47.4,34},{
            -38,34},{-38,40},{-33.2,40},{-33.2,40.4}}, color={0,0,127}));
    connect(thermalResistor.port_b, vol.heatPort) annotation (Line(points={{-84,-16},
            {-84,-4},{-78,-4},{-78,4}},      color={191,0,0}));
    connect(Q_flow_need_cold.y, Q_flow_need.u[1]) annotation (Line(points={{
            -19.4,44},{-14,44},{-14,57},{-10,57}}, color={0,0,127}));
    connect(Q_flow_need_heat.y, Q_flow_need.u[1]) annotation (Line(points={{
            -47.4,74},{-30,74},{-30,57},{-10,57}}, color={0,0,127}));
    connect(prescribedHeatFlow.port, vol1.heatPort)
      annotation (Line(points={{54,28},{54,24}}, color={191,0,0}));
    connect(senMasFlo.m_flow, fieldMassflow_out) annotation (Line(points={{-52,
            9},{-52,-80},{-54,-80},{-54,-100}}, color={0,0,127}));
    connect(senMasFlo1.m_flow, buildingMassflow_out) annotation (Line(points={{
            26,-25},{26,-84},{42,-84},{42,-100}}, color={0,0,127}));
    connect(vol.ports[2], senMasFlo.port_a) annotation (Line(points={{-68,14},{
            -66,14},{-66,20},{-62,20}}, color={0,127,255}));
    connect(senMasFlo.port_b, hydraulicResistance.port_a) annotation (Line(
          points={{-42,20},{-34,20},{-34,22},{-22,22}}, color={0,127,255}));
    connect(fan.port_a, senMasFlo1.port_b)
      annotation (Line(points={{8,-14},{16,-14}}, color={0,127,255}));
    connect(vol1.ports[2], senMasFlo1.port_a) annotation (Line(points={{44,15},
            {46,15},{46,-14},{36,-14}}, color={0,127,255}));
    connect(bou.ports[1], vol1.ports[3]) annotation (Line(points={{64,-20},{56,
            -20},{56,2},{44,2},{44,13}}, color={0,127,255}));
    connect(vol.ports[3], senTem.port) annotation (Line(points={{-68,16.6667},{
            -62,16.6667},{-62,-46},{-36,-46},{-36,-58}}, color={0,127,255}));
    connect(senTem.T, fieldTemperature) annotation (Line(points={{-29,-48},{-28,
            -48},{-28,-86},{-26,-86},{-26,-100}}, color={0,0,127}));
    connect(vol1.ports[4], senTem1.port) annotation (Line(points={{44,11},{44,
            -12},{80,-12},{80,-6}}, color={0,127,255}));
    connect(senTem1.T, buildingTemperature) annotation (Line(points={{87,4},{84,
            4},{84,-100},{74,-100}}, color={0,0,127}));
    connect(product.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{45,
            64},{50,64},{50,60},{54,60},{54,48}}, color={0,0,127}));
    connect(valveQflow, product.u1) annotation (Line(points={{27,99},{27,84},{
            22,84},{22,70}}, color={0,0,127}));
    connect(Q_flow_need.y, product.u2)
      annotation (Line(points={{13,58},{22,58}}, color={0,0,127}));
    connect(buildingNeed, Q_flow_need.y) annotation (Line(points={{10,100},{14,
            100},{14,58},{13,58}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{120,100}})),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})));
  end SimpleModelGeo;
end Geo;
