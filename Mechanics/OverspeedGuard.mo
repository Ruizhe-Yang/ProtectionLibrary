within ProtectionLibrary.Mechanics;
block OverspeedGuard "Overspeed request wrapper with persistence settings"
  parameter Modelica.Units.SI.AngularVelocity limit(min=0) = 10 "Positive angular-speed magnitude used by the comparison";
  parameter Modelica.Units.SI.Time dwell(min=0) = 0.2 "Hold time passed to the persistence block";
  Modelica.Blocks.Interfaces.RealInput speed(unit="rad/s") "Measured angular speed" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "Request exposed by the internal persistence block" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  ProtectionLibrary.Criteria.Persistence persistence(holdTime=dwell) "Persistence block whose input binding requires correction";
initial equation
  assert(limit > 0, "Speed limit must be positive.");
equation
  persistence.condition = abs(speed) > limit;
  request = persistence.request;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-53,-36},{43,60}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-41,12},{-33,12}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-29,43},{-23,37}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-5,49},{-5,41}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{19,43},{13,37}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{30,12},{22,12}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-5,10},{29,37}}, color={0,0,127}, thickness=1.3, pattern=LinePattern.Solid),
        Ellipse(extent={{-9,6},{-1,14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-29,6},{18,-25}}, textString="w", textColor={64,64,64}, fontSize=0),
        Line(points={{42,42},{66,42}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{54,51},{66,42},{54,33}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="OverspeedGuard")}),
    Documentation(info="<html><p>The wrapper compares <code>abs(speed)&gt;limit</code> and exposes the request of an internal Persistence block configured with <code>holdTime=dwell</code>.</p><p><b>Binding limitation:</b> the current equation assigns the comparison to <code>persistence.condition</code>, which is an internally computed output, while <code>persistence.u</code> is left unbound. This is not a correctly connected dwell chain. To construct the intended chain, feed the comparison to the Boolean input <code>Criteria.Persistence.u</code> and use its request output.</p></html>"));
end OverspeedGuard;
