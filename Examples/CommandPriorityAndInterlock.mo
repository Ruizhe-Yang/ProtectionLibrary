within ProtectionLibrary.Examples;
model CommandPriorityAndInterlock "Combine command authority with a delayed start interlock"
  extends Modelica.Icons.Example;
  ProtectionLibrary.Utilities.Internal.PriorityPattern requests  "Shared command values and permission pattern" annotation(Placement(transformation(origin={-246,35},extent={{-34,-34},{34,34}},rotation=0)));
  ProtectionLibrary.Coordination.PrioritySelector selectCommand  "Fixed authority-priority command selector" annotation(Placement(transformation(origin={-38,107},extent={{-23,-23},{23,23}},rotation=0)));
  ProtectionLibrary.Coordination.StartInterlock interlock(n=2)  "Start request gated by permissives and trip" annotation(Placement(transformation(origin={-37,-84},extent={{-20,-20},{20,20}},rotation=0)));
  ProtectionLibrary.Coordination.OnOffDelay release(onDelay=0.2,offDelay=0)  "Delayed acquisition and immediate removal of start permission" annotation(Placement(transformation(origin={119,-84},extent={{-18,-18},{18,18}},rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput selectedCommand  "Value selected by the highest active authority" annotation(Placement(transformation(origin={213,107},extent={{-7,-7},{7,7}},rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput startAllowed  "Start permission after its on-delay" annotation(Placement(transformation(origin={233,-84},extent={{-7,-7},{7,7}},rotation=0)));
equation
  connect(requests.normalValue,selectCommand.normalValue) annotation(Line(points={{-212,58.8},{-136.5,58.8},{-136.5,123.1},{-61,123.1}},color={0,0,127}));
  connect(requests.degradedValue,selectCommand.degradedValue) annotation(Line(points={{-212,52.85},{-207,52.85},{-207,117.73334},{-61,117.73334}},color={0,0,127}));
  connect(requests.protectionValue,selectCommand.protectionValue) annotation(Line(points={{-212,46.9},{-207,46.9},{-207,112.36666},{-61,112.36666}},color={0,0,127}));
  connect(requests.emergencyValue,selectCommand.emergencyValue) annotation(Line(points={{-212,40.95},{-136.5,40.95},{-136.5,107},{-61,107}},color={0,0,127}));
  connect(requests.degraded,selectCommand.degraded) annotation(Line(points={{-212,35},{-207,35},{-207,101.63334},{-61,101.63334}},color={255,0,255}));
  connect(requests.protection,selectCommand.protection) annotation(Line(points={{-212,29.05},{-207,29.05},{-207,96.26666},{-61,96.26666}},color={255,0,255}));
  connect(requests.emergency,selectCommand.emergency) annotation(Line(points={{-212,23.1},{-136.5,23.1},{-136.5,90.9},{-61,90.9}},color={255,0,255}));
  connect(requests.start,interlock.startRequest) annotation(Line(points={{-212,17.15},{-134.5,17.15},{-134.5,-70},{-57,-70}},color={255,0,255}));
  connect(requests.permissions,interlock.permissive) annotation(Line(points={{-212,11.2},{-134.5,11.2},{-134.5,-84},{-57,-84}},color={255,0,255}));
  connect(requests.emergency,interlock.trip) annotation(Line(points={{-212,23.1},{-134.5,23.1},{-134.5,-98},{-57,-98}},color={255,0,255}));
  connect(selectCommand.y,selectedCommand) annotation(Line(points={{-15,123.1},{213,123.1},{213,107}},color={0,0,127}));
  connect(interlock.startPermitted,release.u) annotation(Line(points={{-17,-70},{42,-70},{42,-84},{101,-84}},color={255,0,255}));
  connect(release.y,startAllowed) annotation(Line(points={{137,-84},{233,-84}},color={255,0,255}));
  annotation(experiment(StartTime=0,StopTime=6,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true)),
    Documentation(info="<html><p>Select normal, degraded, protection or emergency command values using fixed authority priority. In a separate Boolean path, combine a start request, two permissives and the emergency trip input.</p><p>The start-permission path has a 0.2 s on-delay and immediate removal. Plot <code>selectedCommand</code>, <code>selectCommand.selectedSource</code>, <code>interlock.startPermitted</code> and <code>startAllowed</code>. The command selector and interlock have distinct responsibilities.</p></html>"));
end CommandPriorityAndInterlock;
