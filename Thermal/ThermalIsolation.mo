within ProtectionLibrary.Thermal;
model ThermalIsolation "Commanded reduction to a residual thermal conductance"
parameter Modelica.Units.SI.ThermalConductance Gnominal(min=0)=10 "Thermal conductance without an isolation command";
  parameter Modelica.Units.SI.ThermalConductance GResidual(min=0)=0.1 "Residual thermal conductance during isolation";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a  "First thermal connection" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b  "Second thermal connection" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput command  "Select the residual conductance" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.ThermalConductance conductance "Thermal conductance selected by the command";
  Modelica.Units.SI.HeatFlowRate heatFlow "Heat flow from port_a to port_b";
initial equation
  assert(GResidual>=0 and Gnominal>=GResidual,"Invalid thermal conductance ordering.");
equation
  conductance=if command then GResidual else Gnominal;
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
        Text(extent={{-45,-47},{45,-77}}, textString="G-", textColor={191,0,0}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Select <code>GResidual</code> while command=true and <code>Gnominal</code> otherwise. The conductance must be nonnegative and the residual value no greater than the nominal value. Heat flow from port_a to port_b follows their temperature difference.</p><p>Connect both ports to explicit thermal nodes. Switching is immediate and the element stores no energy. A positive residual conductance retains heat transfer during isolation.</p></html>"));
end ThermalIsolation;
