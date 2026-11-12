within ProtectionLibrary.Electrical;
model DumpLoad "Connect a finite dissipative electrical dump load"
Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  parameter Boolean useHeatPort=false;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Voltage v;
  Modelica.Units.SI.Current i;
  Modelica.Units.SI.Power lossPower;
  parameter Modelica.Units.SI.Resistance R(min=0)=10;
  parameter Modelica.Units.SI.Conductance Goff(min=0)=1e-8;
  Modelica.Blocks.Interfaces.BooleanInput command annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));

initial equation
  assert(R>0 and Goff>=0,"Invalid passive electrical parameters.");
equation
  v=p.v-n.v;
  i=p.i;
  n.i=-i;
  i=(if command then 1/R else Goff)*v;
  lossPower=v*i;
  if useHeatPort then heatPort.Q_flow=-lossPower; end if;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-68,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-68,0},{-39,24}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Ellipse(extent={{-72,-4},{-64,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-40,-4},{-32,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-36,0},{-19,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Rectangle(extent={{-19,-17},{45,17}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{45,0},{100,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-15,12},{40,-12}}, textString="R", textColor={64,64,64}, fontSize=0),
        Line(points={{-4,-35},{-4,-58}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{19,-35},{19,-58}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Connect a finite dissipative electrical dump load.</p><p><b>Interfaces</b> Modelica.Electrical.Analog.Interfaces.PositivePin p; Modelica.Electrical.Analog.Interfaces.NegativePin n; Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort; Modelica.Blocks.Interfaces.BooleanInput command</p><p><b>Parameters</b> parameter Boolean useHeatPort=false; parameter Modelica.Units.SI.Resistance R(min=0)=10; parameter Modelica.Units.SI.Conductance Goff(min=0)=1e-8</p><p><b>Behavior</b> Connect a finite dissipative electrical dump load</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Positive i enters p. Positive dissipation can be exported as heat. The off branch is defined by the declared finite conductance.</p><p><b>Observables</b> Public outputs and the stated input conditions.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ElectricalTripAndDump\">ProtectionLibrary.Examples.ElectricalTripAndDump</a></p></html>"));
end DumpLoad;
