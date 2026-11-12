within ProtectionLibrary.Electrical;
model VoltageClamp "Dissipate bus energy above a symmetric voltage threshold"
Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  parameter Boolean useHeatPort=false;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Voltage v;
  Modelica.Units.SI.Current i;
  Modelica.Units.SI.Power lossPower;
  parameter Modelica.Units.SI.Voltage Vmax(min=0)=14;
  parameter Modelica.Units.SI.Conductance G(min=0)=1;


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
    Documentation(info="<html><p><b>Purpose</b> Dissipate bus energy above a symmetric voltage threshold.</p><p><b>Interfaces</b> Modelica.Electrical.Analog.Interfaces.PositivePin p; Modelica.Electrical.Analog.Interfaces.NegativePin n; Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort</p><p><b>Parameters</b> parameter Boolean useHeatPort=false; parameter Modelica.Units.SI.Voltage Vmax(min=0)=14; parameter Modelica.Units.SI.Conductance G(min=0)=1</p><p><b>Behavior</b> Dissipate bus energy above a symmetric voltage threshold</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Positive i enters p. Positive dissipation can be exported as heat. The off branch is defined by the declared finite conductance.</p><p><b>Observables</b> Public outputs and the stated input conditions.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ElectricalTripAndDump\">ProtectionLibrary.Examples.ElectricalTripAndDump</a></p></html>"));
end VoltageClamp;
