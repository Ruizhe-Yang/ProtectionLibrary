within ProtectionLibrary.Electrical;
model Disconnect "Commanded electrical contact with residual conductance"
Modelica.Electrical.Analog.Interfaces.PositivePin p  "Pin at the positive voltage reference" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n  "Pin at the negative voltage reference" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  parameter Boolean useHeatPort=false "Expose a heat port for electrical dissipation";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort  "Heat port exporting the dissipated power" annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Voltage v "Voltage from p to n";
  Modelica.Units.SI.Current i "Current entering p";
  Modelica.Units.SI.Power lossPower "Nonnegative electrical dissipation";
  parameter Modelica.Units.SI.Resistance Ron(min=0)=0.001 "Positive resistance of the closed contact";
  parameter Modelica.Units.SI.Conductance Goff(min=0)=1e-6 "Residual conductance of the open contact";
  Modelica.Blocks.Interfaces.BooleanInput openCommand  "Select the open-contact conductance" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput isOpen  "True for the selected off-conductance state" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Conductance conductance "Conductance selected by the command";
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
    Documentation(info="<html><p>Select conductance <code>1/Ron</code> when <code>openCommand=false</code> and <code>Goff</code> when true. Voltage is p.v-n.v and positive current enters p. The relation changes immediately with the command.</p><p><code>isOpen</code> identifies the selected off-conductance state; it is not independent actuator feedback. With <code>useHeatPort=true</code>, electrical dissipation is exported through the heat port. A positive Goff retains a leakage path.</p></html>"));
end Disconnect;
