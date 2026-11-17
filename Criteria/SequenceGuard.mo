within ProtectionLibrary.Criteria;
block SequenceGuard "Deadline check for sustained action feedback"
  parameter Modelica.Units.SI.Time deadline(min=0) = 0.5 "Allowed interval from command activation to confirmation";
  Modelica.Blocks.Interfaces.BooleanInput commandActive "Sustained command requiring action feedback" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput confirmed "Current measured confirmation of the requested action" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "Active command lacks confirmation at or after its deadline" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  discrete Modelica.Units.SI.Time entered "Time of initialisation or the latest command rising edge";
initial equation
  assert(deadline >= 0, "Action deadline must be nonnegative.");
equation
  when {initial(), commandActive} then
    entered = time;
  end when;
  request = commandActive and not confirmed and time >= entered+deadline;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,39},{-45,39},{-45,59},{48,59}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-8},{-17,-8},{-17,11},{33,11}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{48,66},{48,-33}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Dash),
        Text(extent={{35,-21},{65,-52}}, textString="?", textColor={64,64,64}, fontSize=0),
        Line(points={{-45,-30},{21,-30}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="SequenceGuard")}),
    Documentation(info="<html><p>Start a deadline at initialisation or each rising <code>commandActive</code>. Once that deadline is reached, request protection whenever the command remains active and the current <code>confirmed</code> input is false.</p><p>Confirmation clears the request immediately. If confirmation is later lost while the same overdue command remains active, the request returns immediately. Confirmation need not have a new rising edge.</p></html>"));
end SequenceGuard;
