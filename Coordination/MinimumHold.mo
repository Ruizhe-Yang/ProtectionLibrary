within ProtectionLibrary.Coordination;
block MinimumHold "Keep the commanded state for its minimum dwell and admit emergency action immediately"
parameter Modelica.Units.SI.Time minOnTime(min=0)=0.2;
  parameter Modelica.Units.SI.Time minOffTime(min=0)=0.2;
    Modelica.Blocks.Interfaces.BooleanInput u annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y(start=false,fixed=true) annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  discrete Modelica.Units.SI.Time since(start=0,fixed=true);
  Boolean canTurnOn;
  Boolean canTurnOff;
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
    Documentation(info="<html><p><b>Purpose</b> Keep the commanded state for its minimum dwell and admit emergency action immediately.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput u; Modelica.Blocks.Interfaces.BooleanInput emergency; Modelica.Blocks.Interfaces.BooleanOutput y(start=false,fixed=true)</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time minOnTime(min=0)=0.2; parameter Modelica.Units.SI.Time minOffTime(min=0)=0.2</p><p><b>Behavior</b> Keep the commanded state for its minimum dwell and admit emergency action immediately</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> y</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end MinimumHold;
