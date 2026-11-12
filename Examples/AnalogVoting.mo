within ProtectionLibrary.Examples;
model AnalogVoting "Compare median and mean with changing input qualification"
  extends Modelica.Icons.Example;
  ProtectionLibrary.Utilities.Internal.AnalogPattern pattern annotation(Placement(transformation(origin={-247,0},extent={{-24,-24},{24,24}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Median3 median3(useValidInput=true,fallbackValue=-9) annotation(Placement(transformation(origin={-16,150},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput median3Value annotation(Placement(transformation(origin={202,150},extent={{-7,-7},{7,7}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Mean3 mean3(useValidInput=true,fallbackValue=-9) annotation(Placement(transformation(origin={-16,50},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mean3Value annotation(Placement(transformation(origin={202,50},extent={{-7,-7},{7,7}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Median5 median5(useValidInput=true,fallbackValue=-9) annotation(Placement(transformation(origin={-16,-50},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput median5Value annotation(Placement(transformation(origin={202,-50},extent={{-7,-7},{7,7}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Mean5 mean5(useValidInput=true,fallbackValue=-9) annotation(Placement(transformation(origin={-16,-150},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mean5Value annotation(Placement(transformation(origin={202,-150},extent={{-7,-7},{7,7}},rotation=0)));
equation
  connect(median3.y,median3Value) annotation(Line(points={{1,161.9},{202,161.9},{202,150}},color={0,0,127}));
  connect(pattern.u3,median3.u) annotation(Line(points={{-223,16.8},{-128,16.8},{-128,161.9},{-33,161.9}},color={0,0,127}));
  connect(pattern.valid3,median3.valid) annotation(Line(points={{-223,-5.59999},{-218,-5.59999},{-218,172},{-16,172},{-16,167}},color={255,0,255}));
  connect(mean3.y,mean3Value) annotation(Line(points={{1,61.9},{202,61.9},{202,50}},color={0,0,127}));
  connect(pattern.u3,mean3.u) annotation(Line(points={{-223,16.8},{-128,16.8},{-128,61.9},{-33,61.9}},color={0,0,127}));
  connect(pattern.valid3,mean3.valid) annotation(Line(points={{-223,-5.59999},{-16,-5.59999},{-16,72},{-16,67}},color={255,0,255}));
  connect(median5.y,median5Value) annotation(Line(points={{1,-38.1},{202,-38.1},{202,-50}},color={0,0,127}));
  connect(pattern.u5,median5.u) annotation(Line(points={{-223,5.59999},{-218,5.59999},{-218,-38.1},{-33,-38.1}},color={0,0,127}));
  connect(pattern.valid5,median5.valid) annotation(Line(points={{-223,-16.8},{-16,-16.8},{-16,-33}},color={255,0,255}));
  connect(mean5.y,mean5Value) annotation(Line(points={{1,-138.1},{202,-138.1},{202,-150}},color={0,0,127}));
  connect(pattern.u5,mean5.u) annotation(Line(points={{-223,5.59999},{-218,5.59999},{-218,-138.1},{-33,-138.1}},color={0,0,127}));
  connect(pattern.valid5,mean5.valid) annotation(Line(points={{-223,-16.8},{-116.5,-16.8},{-116.5,-127},{-16,-127},{-16,-133}},color={255,0,255}));
  annotation(experiment(StartTime=0,StopTime=4,Interval=0.008,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true)),
    Documentation(info="<html><p><b>Purpose</b> Compare median and mean with changing input qualification</p><p><b>Interfaces</b> Instances and connections are shown in the Diagram layer.</p><p><b>Parameters</b> Default values are shown in the component modifiers.</p><p><b>Behavior</b> The first median is 1.1 and the first mean is 4.0333333. With the largest sample excluded both return 1.05. Insufficient valid channels return -9 with unavailable status.</p><p><b>Initialization</b> All initial conditions are explicit in the source and component modifiers.</p><p><b>Activation and recovery</b> The given time windows follow the simulation time axis.</p><p><b>Limitations</b> This demonstration uses the declared inputs, initial conditions and idealized components.</p><p><b>Observables</b> median3Value, mean3Value and each available and nValid.</p></html>"));
end AnalogVoting;
