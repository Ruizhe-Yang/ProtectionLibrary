within ProtectionLibrary.Coordination;
block MinimumHold "Minimum on and off dwell with immediate emergency enable"
parameter Modelica.Units.SI.Time minOnTime(min=0)=0.2 "Minimum on duration after an output transition";
  parameter Modelica.Units.SI.Time minOffTime(min=0)=0.2 "Minimum off duration before a normal turn-on";
    Modelica.Blocks.Interfaces.BooleanInput u  "Requested Boolean state" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency  "Force the output true immediately" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y(start=false,fixed=true)  "Boolean command after dwell qualification" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  discrete Modelica.Units.SI.Time since(start=0,fixed=true) "Time of the latest output transition";
  Boolean canTurnOn "Normal turn-on request has satisfied the off dwell";
  Boolean canTurnOff "Turn-off request has satisfied the on dwell";
initial equation
  assert(minOnTime>=0 and minOffTime>=0,"Negative hold time.");
equation
  canTurnOn=u and time>=pre(since)+minOffTime;
  canTurnOff=not u and time>=pre(since)+minOnTime;
  when {initial(),emergency,not emergency,canTurnOn,canTurnOff} then
    y=if emergency then true elseif initial() then u elseif canTurnOn then true elseif canTurnOff then false else pre(y);
    since=if initial() or y<>pre(y) then time else pre(since);
  end when;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,-15},{-37,-15},{-37,36},{22,36},{22,-15},{65,-15}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-37,54},{22,54}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Line(points={{22,-35},{65,-35}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-39,78},{24,58}}, textString="min", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Hold the output on for minOnTime and off for minOffTime, measured from its latest state change. A normal request changes the state once the corresponding dwell has elapsed. At initialisation, the output follows u without waiting for an off dwell.</p><p>Emergency forces the output true immediately and overrides the off dwell. After emergency clears, normal dwell rules apply from the latest output transition. This emergency path enables the output; its physical interpretation depends on the connected command.</p></html>"));
end MinimumHold;
