within ProtectionLibrary.Thermal;
model CoolingConductance "Commanded increase of a thermal conductance"
parameter Modelica.Units.SI.ThermalConductance Goff(min=0)=1 "Thermal conductance without a command";
  parameter Modelica.Units.SI.ThermalConductance Gon(min=0)=10 "Thermal conductance with a command";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a  "First thermal connection" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b  "Second thermal connection" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput command  "Select the increased conductance" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.ThermalConductance conductance "Thermal conductance selected by the command";
  Modelica.Units.SI.HeatFlowRate heatFlow "Heat flow from port_a to port_b";
initial equation
  assert(Goff>=0 and Gon>=Goff,"Invalid thermal conductance ordering.");
equation
  conductance=if command then Gon else Goff;
  heatFlow=conductance*(port_a.T-port_b.T);
  port_a.Q_flow=heatFlow;
  port_b.Q_flow=-heatFlow;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-27,0}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{27,0},{100,0}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid),
        Rectangle(extent={{-26,-37},{-10,37}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{10,-37},{26,37}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-3,-25},{-3,25}}, color={191,0,0}, thickness=1.3, pattern=LinePattern.Solid),
        Line(points={{3,-25},{3,25}}, color={191,0,0}, thickness=1.3, pattern=LinePattern.Solid),
        Line(points={{-42,59},{42,59}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-45,-47},{45,-77}}, textString="G+", textColor={191,0,0}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Select <code>Gon</code> while command=true and <code>Goff</code> otherwise, with Gon at least Goff. The heat flow from port_a to port_b is conductance times their temperature difference.</p><p>Connect both ports to defined thermal nodes. The element transports heat in either direction and stores no energy; increased conductance cools a body only when the connected environment is colder.</p></html>"));
end CoolingConductance;
