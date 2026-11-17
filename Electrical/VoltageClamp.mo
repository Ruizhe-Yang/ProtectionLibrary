within ProtectionLibrary.Electrical;
model VoltageClamp "Symmetric dissipative shunt above a voltage threshold"
Modelica.Electrical.Analog.Interfaces.PositivePin p  "Pin at the positive voltage reference" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n  "Pin at the negative voltage reference" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  parameter Boolean useHeatPort=false "Expose a heat port for electrical dissipation";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort  "Heat port exporting the dissipated power" annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Voltage v "Voltage from p to n";
  Modelica.Units.SI.Current i "Current entering p";
  Modelica.Units.SI.Power lossPower "Nonnegative electrical dissipation";
  parameter Modelica.Units.SI.Voltage Vmax(min=0)=14 "Absolute voltage threshold for conduction";
  parameter Modelica.Units.SI.Conductance G(min=0)=1 "Incremental conductance beyond either threshold";


initial equation
  assert(Vmax>=0 and G>=0,"Invalid passive electrical parameters.");
equation
  v=p.v-n.v;
  i=p.i;
  n.i=-i;
  i=G*(max(0,v-Vmax)+min(0,v+Vmax));
  lossPower=v*i;
  if useHeatPort then heatPort.Q_flow=-lossPower; end if;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-35,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Rectangle(extent={{-35,-17},{35,17}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{35,0},{100,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-23,-13},{-8,0},{8,0},{23,13}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-35,34},{-22,48},{22,48},{35,34}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-49,-37},{49,-66}}, textString="Vlim", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Draw no current while <code>abs(v)&lt;=Vmax</code>. Outside that band, current rises linearly with the excess voltage with slope <code>G</code>, with the same polarity as v. Positive current enters p and <code>lossPower=v*i</code> is nonnegative.</p><p>Connect the shunt across the protected nodes and optionally export dissipation through heatPort. A finite G gives a soft clamp: Vmax is the conduction threshold, not an enforced voltage ceiling.</p></html>"));
end VoltageClamp;
