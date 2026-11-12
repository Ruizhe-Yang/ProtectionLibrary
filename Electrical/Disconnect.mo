within ProtectionLibrary.Electrical;
model Disconnect "Open a finite electrical path and expose its actual modeled conductance"
Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  parameter Boolean useHeatPort=false;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Voltage v;
  Modelica.Units.SI.Current i;
  Modelica.Units.SI.Power lossPower;
  parameter Modelica.Units.SI.Resistance Ron(min=0)=0.001;
  parameter Modelica.Units.SI.Conductance Goff(min=0)=1e-6;
  Modelica.Blocks.Interfaces.BooleanInput openCommand annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput isOpen annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Conductance conductance;
initial equation
  assert(Ron>0 and Goff>=0 and Goff<1/Ron,"Invalid passive electrical parameters.");
equation
  v=p.v-n.v;
  i=p.i;
  n.i=-i;
  i=conductance*v;
  conductance=if openCommand then Goff else 1/Ron;
  isOpen=conductance<=Goff;
  lossPower=v*i;
  if useHeatPort then heatPort.Q_flow=-lossPower; end if;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-34,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{34,0},{100,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-38,-4},{-30,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{30,-4},{38,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-34,0},{24,34}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-13,57},{-13,37}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Open a finite electrical path and expose its actual modeled conductance.</p><p><b>Interfaces</b> Modelica.Electrical.Analog.Interfaces.PositivePin p; Modelica.Electrical.Analog.Interfaces.NegativePin n; Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort; Modelica.Blocks.Interfaces.BooleanInput openCommand; Modelica.Blocks.Interfaces.BooleanOutput isOpen</p><p><b>Parameters</b> parameter Boolean useHeatPort=false; parameter Modelica.Units.SI.Resistance Ron(min=0)=0.001; parameter Modelica.Units.SI.Conductance Goff(min=0)=1e-6</p><p><b>Behavior</b> Open a finite electrical path and expose its actual modeled conductance</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Positive i enters p. Positive dissipation can be exported as heat. The off branch is defined by the declared finite conductance.</p><p><b>Observables</b> isOpen</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ElectricalTripAndDump\">ProtectionLibrary.Examples.ElectricalTripAndDump</a></p></html>"));
end Disconnect;
