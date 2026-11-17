within ProtectionLibrary.Mechanics;
block ControlledStop "Signed speed-command ramp towards rest"
  parameter Modelica.Units.SI.AngularAcceleration deceleration(min=Modelica.Constants.small) = 3 "Positive rate of reduction of the captured speed magnitude";
  Modelica.Blocks.Interfaces.RealInput speedReference(unit="rad/s") "Normal angular-speed command" annotation(Placement(transformation(extent={{-106,42},{-94,54}}), iconTransformation(extent={{-106,42},{-94,54}})));
  Modelica.Blocks.Interfaces.RealInput measuredSpeed(unit="rad/s") "Angular speed captured when a stop begins" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanInput request "Enable the captured-speed stopping ramp" annotation(Placement(transformation(extent={{-106,-54},{-94,-42}}), iconTransformation(extent={{-106,-54},{-94,-42}})));
  Modelica.Blocks.Interfaces.RealOutput speedCommand(unit="rad/s") "Normal or stopping angular-speed command" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  discrete Modelica.Units.SI.AngularVelocity captured "Angular speed stored at initialisation or a rising request";
  discrete Modelica.Units.SI.Time entered "Time at which the stopping trajectory was captured";
initial equation
  assert(deceleration > 0, "Deceleration must be positive.");
equation
  when {initial(),request} then
    captured = measuredSpeed;
    entered = time;
  end when;
  speedCommand = if request then sign(captured)*max(0,abs(captured)-deceleration*(time-entered)) else speedReference;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-58,40},{-30,40},{29,-37},{61,-37}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-30,40},{-30,-40}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Text(extent={{20,61},{60,29}}, textString="w", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="ControlledStop")}),
    Documentation(info="<html><p>At initialisation and each rising edge of <code>request</code>, capture measuredSpeed and the current time. While the request is true, reduce the captured speed magnitude at <code>deceleration</code> and hold zero after the ramp finishes.</p><p>When the request is false, pass speedReference directly to speedCommand. The ramp is a command trajectory; measuredSpeed is not tracked continuously during stopping. Clearing or retriggering the request can change the command abruptly.</p></html>"));
end ControlledStop;
