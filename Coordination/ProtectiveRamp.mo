within ProtectionLibrary.Coordination;
block ProtectiveRamp "Rate-limited tracking of protective and normal commands"
  parameter Real safeCommand = 0 "Target command selected during protection";
  parameter Real maxRate(min=Modelica.Constants.small) = 1 "Maximum absolute command derivative in signal units per second";
  parameter Modelica.Units.SI.Time responseTime(min=Modelica.Constants.small) = 0.08 "Tracking time constant near the selected target";
  Modelica.Blocks.Interfaces.RealInput u "Nominal target command" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput request "Select safeCommand as the target" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput y "Command after symmetric rate-limited tracking" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  Real target "Selected protective or nominal target";
initial equation
  assert(maxRate > 0 and responseTime > 0, "Positive ramp parameters required.");
  y = if request then safeCommand else u;
equation
  target = if request then safeCommand else u;
  der(y) = min(maxRate,max(-maxRate,(target-y)/responseTime));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-59,38},{-28,38},{-28,-28},{62,-28}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-59,38},{-28,38},{36,-28},{62,-28}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="ProtectiveRamp")}),
    Documentation(info="<html><p>Select safeCommand while request is true and otherwise select u. Track that target with <code>der(y)</code> limited symmetrically to maxRate. Close to the target, responseTime gives a first-order approach.</p><p>Initialisation places y directly at the selected target. Both protection and recovery use the same rate limit after initialisation; the block provides neither an immediate trip override nor a fixed target-arrival time.</p></html>"));
end ProtectiveRamp;
