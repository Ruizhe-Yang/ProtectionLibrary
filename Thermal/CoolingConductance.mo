within ProtectionLibrary.Thermal;
model CoolingConductance "Increase a finite heat transfer path on demand"
parameter Modelica.Units.SI.ThermalConductance Goff(min=0)=1;
  parameter Modelica.Units.SI.ThermalConductance Gon(min=0)=10;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput command annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.ThermalConductance conductance;
  Modelica.Units.SI.HeatFlowRate heatFlow;
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
    Documentation(info="<html><p><b>Purpose</b> Increase a finite heat transfer path on demand.</p><p><b>Interfaces</b> Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a; Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b; Modelica.Blocks.Interfaces.BooleanInput command</p><p><b>Parameters</b> parameter Modelica.Units.SI.ThermalConductance Goff(min=0)=1; parameter Modelica.Units.SI.ThermalConductance Gon(min=0)=10</p><p><b>Behavior</b> Increase a finite heat transfer path on demand</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Connect both heat ports to explicit thermal nodes. The device transports heat and stores no energy.</p><p><b>Observables</b> Public outputs and the stated input conditions.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThermalCooling\">ProtectionLibrary.Examples.ThermalCooling</a></p></html>"));
end CoolingConductance;
