within ProtectionLibrary.Coordination;
block MinimumOffTime "Restart inhibition measured from each trip edge"
  parameter Modelica.Units.SI.Time holdOff(min=0) = 0.5 "Restart inhibition measured from the latest trip rising edge";
  Modelica.Blocks.Interfaces.BooleanInput trip "Trip request that inhibits operation" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput runDemand "Nominal request to operate" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanOutput runCommand "Run demand qualified by trip clearance and waiting time" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  discrete Modelica.Units.SI.Time lastTrip "Time of initialisation or the latest trip rising edge";
  discrete Boolean seen "A trip has occurred since initialisation";
initial equation
  assert(holdOff >= 0, "Hold-off time must be nonnegative.");
equation
  when {initial(), trip} then
    lastTrip = time;
    seen = if initial() then trip else true;
  end when;
  runCommand = runDemand and not trip and (not seen or time >= lastTrip+holdOff);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,42},{-35,42},{-35,-2},{35,-2},{35,42},{65,42}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-35,-25},{35,-25}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Line(points={{-35,-32},{-35,9}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{35,-32},{35,9}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-32,-40},{32,-64}}, textString="OFF", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="MinimumOffTime")}),
    Documentation(info="<html><p>Pass runDemand only when trip is false and holdOff has elapsed since the latest trip rising edge. Before any trip, the demand passes immediately. An initially true trip starts the same waiting interval at initialisation.</p><p>The interval is measured from trip activation, not clearance. If a trip lasts longer than holdOff, its removal can allow an immediate restart. Each new trip edge restarts the interval.</p></html>"));
end MinimumOffTime;
