within ProtectionLibrary.Examples;
model ElectricalTripAndDump "Open supply paths and provide an inductive discharge branch"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanExpression trip(y=time>=1)  "Common opening and dump command" annotation(Placement(transformation(origin={-263,190},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage resistiveSupply(V=12)  "Voltage source for the resistive circuit" annotation(Placement(transformation(origin={-259,103},extent={{-14,-14},{14,14}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground resistiveGround  "Potential reference for the resistive circuit" annotation(Placement(transformation(origin={-259,46},extent={{-10,-10},{10,10}},rotation=0)));
  ProtectionLibrary.Electrical.Disconnect resistiveSwitch(Ron=0.001,Goff=1e-6)  "Supply disconnect for the resistive circuit" annotation(Placement(transformation(origin={-106,121},extent={{-15,-15},{15,15}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistiveLoad(R=10)  "Resistive electrical load" annotation(Placement(transformation(origin={55,121},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage inductiveSupply(V=12)  "Voltage source for the inductive circuit" annotation(Placement(transformation(origin={-259,-84},extent={{-14,-14},{14,14}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground inductiveGround  "Potential reference for the inductive circuit" annotation(Placement(transformation(origin={-259,-141},extent={{-10,-10},{10,10}},rotation=0)));
  ProtectionLibrary.Electrical.Disconnect inductiveSwitch(Ron=0.001,Goff=1e-6)  "Supply disconnect for the inductive circuit" annotation(Placement(transformation(origin={-106,-66},extent={{-15,-15},{15,15}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor inductiveLoad(R=10)  "Series resistance in the inductive circuit" annotation(Placement(transformation(origin={55,-66},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor coil(L=0.1,i(start=0,fixed=true))  "Inductor with a fixed zero initial current" annotation(Placement(transformation(origin={205,-66},extent={{-14,-14},{14,14}},rotation=0)));
  ProtectionLibrary.Electrical.DumpLoad dump(R=10)  "Switchable discharge path across the inductor" annotation(Placement(transformation(origin={203,-162},extent={{-15,-15},{15,15}},rotation=0)));
equation
  connect(resistiveSupply.n,resistiveGround.p) annotation(Line(points={{-259,89},{-259,56}},color={0,0,255}));
  connect(resistiveSupply.p,resistiveSwitch.p) annotation(Line(points={{-259,117},{-259,122},{-259,121},{-121,121}},color={0,0,255}));
  connect(resistiveSwitch.n,resistiveLoad.p) annotation(Line(points={{-91,121},{42,121}},color={0,0,255}));
  connect(trip.y,resistiveSwitch.openCommand) annotation(Line(points={{-248.7,190},{-106,190},{-106,136}},color={255,0,255}));
  connect(resistiveLoad.n,resistiveGround.p) annotation(Line(points={{68,121},{73,121},{73,61},{-259,61},{-259,56}},color={0,0,255}));
  connect(inductiveSupply.n,inductiveGround.p) annotation(Line(points={{-259,-98},{-259,-131}},color={0,0,255}));
  connect(inductiveSupply.p,inductiveSwitch.p) annotation(Line(points={{-259,-70},{-259,-65},{-259,-66},{-121,-66}},color={0,0,255}));
  connect(inductiveSwitch.n,inductiveLoad.p) annotation(Line(points={{-91,-66},{42,-66}},color={0,0,255}));
  connect(trip.y,inductiveSwitch.openCommand) annotation(Line(points={{-248.7,190},{-240,190},{-240,-45},{-106,-45},{-106,-51}},color={255,0,255}));
  connect(inductiveLoad.n,coil.p) annotation(Line(points={{68,-66},{191,-66}},color={0,0,255}));
  connect(coil.n,inductiveGround.p) annotation(Line(points={{219,-66},{224,-66},{224,-126},{-259,-126},{-259,-131}},color={0,0,255}));
  connect(coil.p,dump.p) annotation(Line(points={{191,-66},{183,-66},{183,-162},{188,-162}},color={0,0,255}));
  connect(dump.n,inductiveGround.p) annotation(Line(points={{218,-162},{223,-162},{223,-126},{-259,-126},{-259,-131}},color={0,0,255}));
  connect(trip.y,dump.command) annotation(Line(points={{-248.7,190},{-19.85,190},{-19.85,-141},{203,-141},{203,-147}},color={255,0,255}));
  annotation(experiment(StartTime=0,StopTime=5,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true)),
    Documentation(info="<html><p>Use a trip command at 1 s in two independent 12 V circuits. The first supplies a resistor through a disconnect. The second supplies a resistor and inductor, with a separately connected dump resistor across the inductor.</p><p>The command opens both supply paths and enables the dump branch. Inspect the switch currents and voltage drops, <code>coil.i</code> and <code>dump.lossPower</code>. The disconnects retain their finite off-state conductance; the dump branch provides a discharge path rather than resetting the inductor state.</p></html>"));
end ElectricalTripAndDump;
