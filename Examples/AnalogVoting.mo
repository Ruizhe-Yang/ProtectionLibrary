within ProtectionLibrary.Examples;
model AnalogVoting "Compare median and mean under changing channel validity"
  extends Modelica.Icons.Example;
  ProtectionLibrary.Utilities.Internal.AnalogPattern pattern  "Common real signals and validity pattern" annotation(Placement(transformation(origin={-247,0},extent={{-24,-24},{24,24}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Median3 median3(useValidInput=true,fallbackValue=-9)  "Median of eligible channels from three inputs" annotation(Placement(transformation(origin={-16,150},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput median3Value  "Reported median3 output, including its fallback" annotation(Placement(transformation(origin={202,150},extent={{-7,-7},{7,7}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Mean3 mean3(useValidInput=true,fallbackValue=-9)  "Arithmetic mean of eligible channels from three inputs" annotation(Placement(transformation(origin={-16,50},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mean3Value  "Reported mean3 output, including its fallback" annotation(Placement(transformation(origin={202,50},extent={{-7,-7},{7,7}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Median5 median5(useValidInput=true,fallbackValue=-9)  "Median of eligible channels from five inputs" annotation(Placement(transformation(origin={-16,-50},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput median5Value  "Reported median5 output, including its fallback" annotation(Placement(transformation(origin={202,-50},extent={{-7,-7},{7,7}},rotation=0)));
  ProtectionLibrary.Voting.AnalogVoting.Mean5 mean5(useValidInput=true,fallbackValue=-9)  "Arithmetic mean of eligible channels from five inputs" annotation(Placement(transformation(origin={-16,-150},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mean5Value  "Reported mean5 output, including its fallback" annotation(Placement(transformation(origin={202,-150},extent={{-7,-7},{7,7}},rotation=0)));
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
    Documentation(info="<html><p>Apply one shared pattern to three-channel and five-channel median and arithmetic-mean blocks. The pattern includes an outlying value and changing channel qualification.</p><p>Plot the four top-level value outputs together with each voter's <code>available</code> and <code>nValid</code>. An unavailable result uses the configured fallback value of -9. Median and mean respond differently to an eligible outlier; validity flags determine which channels are eligible.</p></html>"));
end AnalogVoting;
