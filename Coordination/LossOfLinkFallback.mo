within ProtectionLibrary.Coordination;
block LossOfLinkFallback "Fallback selection with separate loss and recovery dwells"
  parameter Modelica.Units.SI.Time lossDwell(min=0) = 0.3 "Continuous unhealthy-link interval required for fallback";
  parameter Modelica.Units.SI.Time recoveryDwell(min=0) = 1 "Continuous healthy-link interval required for recovery";
  parameter Real fallback = 0 "Fallback command in the same unit as u";
  Modelica.Blocks.Interfaces.BooleanInput linkHealthy "Externally determined link-health state" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.RealInput u "Nominal command" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput y "Selected nominal or fallback command" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput usingFallback(start=false,fixed=true) "Fallback command is currently selected" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  discrete Modelica.Units.SI.Time lastChange(start=0,fixed=true) "Time of initialisation or the latest link-health change";
initial equation
  assert(lossDwell >= 0 and recoveryDwell >= 0, "Dwell times must be nonnegative.");
equation
  when {initial(),linkHealthy,not linkHealthy} then
    lastChange = time;
  end when;
  when {initial(),not linkHealthy and time >= lastChange+lossDwell,
      linkHealthy and time >= lastChange+recoveryDwell} then
    usingFallback = not linkHealthy and time >= lastChange+lossDwell;
  end when;
  y = if usingFallback then fallback else u;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,37},{-27,37}}, color={128,128,128}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-8,37},{40,37}}, color={128,128,128}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-25,26},{-10,48}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-25,48},{-10,26}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-65,-28},{-13,-28},{28,4},{65,4}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Ellipse(extent={{-17,-32},{-9,-24}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{24,0},{32,8}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{17,-22},{55,-51}}, textString="t", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p>Select the fallback command after linkHealthy has remained false for lossDwell. Return to the nominal command only after it has remained true for recoveryDwell. Every change in link health starts a fresh confirmation interval.</p><p>Initialisation begins in nominal operation unless an initially unhealthy link qualifies immediately with zero loss dwell. During an unconfirmed loss the nominal command remains selected; during unconfirmed recovery the fallback remains selected.</p></html>"));
end LossOfLinkFallback;
