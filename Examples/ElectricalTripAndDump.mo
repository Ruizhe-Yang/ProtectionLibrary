within ProtectionLibrary.Examples;
model ElectricalTripAndDump "Open a resistive circuit and dissipate inductive energy in a separate circuit"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanExpression trip(y=time>=1) annotation(Placement(transformation(origin={-263,190},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage resistiveSupply(V=12) annotation(Placement(transformation(origin={-259,103},extent={{-14,-14},{14,14}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground resistiveGround annotation(Placement(transformation(origin={-259,46},extent={{-10,-10},{10,10}},rotation=0)));
  ProtectionLibrary.Electrical.Disconnect resistiveSwitch(Ron=0.001,Goff=1e-6) annotation(Placement(transformation(origin={-106,121},extent={{-15,-15},{15,15}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistiveLoad(R=10) annotation(Placement(transformation(origin={55,121},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage inductiveSupply(V=12) annotation(Placement(transformation(origin={-259,-84},extent={{-14,-14},{14,14}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground inductiveGround annotation(Placement(transformation(origin={-259,-141},extent={{-10,-10},{10,10}},rotation=0)));
  ProtectionLibrary.Electrical.Disconnect inductiveSwitch(Ron=0.001,Goff=1e-6) annotation(Placement(transformation(origin={-106,-66},extent={{-15,-15},{15,15}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor inductiveLoad(R=10) annotation(Placement(transformation(origin={55,-66},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor coil(L=0.1,i(start=0,fixed=true)) annotation(Placement(transformation(origin={205,-66},extent={{-14,-14},{14,14}},rotation=0)));
  ProtectionLibrary.Electrical.DumpLoad dump(R=10) annotation(Placement(transformation(origin={203,-162},extent={{-15,-15},{15,15}},rotation=0)));
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
    Documentation(info="<html><p><b>Purpose</b> Open a resistive circuit and dissipate inductive energy in a separate circuit</p><p><b>Interfaces</b> Instances and connections are shown in the Diagram layer.</p><p><b>Parameters</b> Default values are shown in the component modifiers.</p><p><b>Behavior</b> The resistive circuit has 1.19988 A before opening and below 50 microampere after opening. The coil retains a dissipative discharge route.</p><p><b>Initialization</b> All initial conditions are explicit in the source and component modifiers.</p><p><b>Activation and recovery</b> The given time windows follow the simulation time axis.</p><p><b>Limitations</b> This demonstration uses the declared inputs, initial conditions and idealized components.</p><p><b>Observables</b> resistiveLoad.i, inductiveSwitch.isOpen, coil.i and dump.lossPower.</p></html>"));
end ElectricalTripAndDump;
