within ProtectionLibrary.Examples;
model ThermalCooling "Compare switched thermal conductance with a fixed cooling path"
  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow protectedHeat(Q_flow=100)  "Heat source for the controlled-cooling branch" annotation(Placement(transformation(origin={-242,105},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor protectedBody(C=100,T(start=300,fixed=true))  "Thermal capacity in the controlled-cooling branch" annotation(Placement(transformation(origin={-119,119},extent={{-15,-15},{15,15}},rotation=0)));
  ProtectionLibrary.Thermal.CoolingConductance protectedCooling(Goff=1,Gon=10)  "Switchable conductance to the thermal boundary" annotation(Placement(transformation(origin={34,105},extent={{-18,-18},{18,18}},rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature protectedAmbient(T=300)  "Ambient temperature for the controlled branch" annotation(Placement(transformation(origin={224,105},extent={{-14,-14},{14,14}},rotation=180)));
  Modelica.Blocks.Sources.RealExpression sensor(y=protectedBody.T)  "Independent body-temperature readback" annotation(Placement(transformation(origin={-181,193},extent={{-12,-12},{12,12}},rotation=0)));
  ProtectionLibrary.Criteria.HighLimit hot(tripLevel=316,resetLevel=307)  "High-temperature criterion with hysteresis" annotation(Placement(transformation(origin={-27,192},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow referenceHeat(Q_flow=100)  "Heat source for the reference branch" annotation(Placement(transformation(origin={-242,-90},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor referenceBody(C=100,T(start=300,fixed=true))  "Thermal capacity in the reference branch" annotation(Placement(transformation(origin={-119,-76},extent={{-15,-15},{15,15}},rotation=0)));
  ProtectionLibrary.Thermal.CoolingConductance referenceCooling(Goff=1,Gon=10)  "Conductance held at its lower value" annotation(Placement(transformation(origin={34,-90},extent={{-18,-18},{18,18}},rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature referenceAmbient(T=300)  "Ambient temperature for the reference branch" annotation(Placement(transformation(origin={224,-90},extent={{-14,-14},{14,14}},rotation=180)));
  Modelica.Blocks.Sources.BooleanExpression noCooling(y=false)  "Command retaining the lower reference conductance" annotation(Placement(transformation(origin={-150,-161},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.RealExpression command(y=120)  "Separate requested heat-input signal" annotation(Placement(transformation(origin={94,-188},extent={{-12,-12},{12,12}},rotation=0)));
  ProtectionLibrary.Thermal.HeatInputLimiter limitCommand(lower=0,upper=100)  "Signal limiter independent of the two thermal networks" annotation(Placement(transformation(origin={214,-188},extent={{-15,-15},{15,15}},rotation=0)));
equation
  connect(protectedHeat.port,protectedBody.port) annotation(Line(points={{-228,105},{-119,105},{-119,99},{-119,104}},color={191,0,0}));
  connect(protectedBody.port,protectedCooling.port_a) annotation(Line(points={{-119,104},{-119,99},{-119,105},{16,105}},color={191,0,0}));
  connect(protectedCooling.port_b,protectedAmbient.port) annotation(Line(points={{52,105},{210,105}},color={191,0,0}));
  connect(sensor.y,hot.u) annotation(Line(points={{-167.8,193},{-104.4,193},{-104.4,201.8},{-41,201.8}},color={0,0,127}));
  connect(hot.request,protectedCooling.command) annotation(Line(points={{-36.8,206},{-36.8,211},{34,211},{34,123}},color={255,0,255}));
  connect(referenceHeat.port,referenceBody.port) annotation(Line(points={{-228,-90},{-119,-90},{-119,-96},{-119,-91}},color={191,0,0}));
  connect(referenceBody.port,referenceCooling.port_a) annotation(Line(points={{-119,-91},{-119,-96},{-119,-90},{16,-90}},color={191,0,0}));
  connect(referenceCooling.port_b,referenceAmbient.port) annotation(Line(points={{52,-90},{210,-90}},color={191,0,0}));
  connect(noCooling.y,referenceCooling.command) annotation(Line(points={{-136.8,-161},{34,-161},{34,-67},{34,-72}},color={255,0,255}));
  connect(command.y,limitCommand.u) annotation(Line(points={{107.2,-188},{199,-188}},color={0,0,127}));
  annotation(experiment(StartTime=0,StopTime=60,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true)),
    Documentation(info="<html><p>Apply 100 W to two thermal capacities of 100 J/K, each initially at 300 K and connected to a 300 K boundary. The protected path increases conductance from 1 to 10 W/K at 316 K, with hysteretic reset at 307 K. The reference path remains at 1 W/K.</p><p>Plot both body temperatures, <code>hot.request</code> and <code>protectedCooling.heatFlow</code>. The separate heat-input limiter maps a command of 120 W to 100 W; it is not connected to either physical heat source.</p></html>"));
end ThermalCooling;
