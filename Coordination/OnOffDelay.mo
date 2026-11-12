within ProtectionLibrary.Coordination;
block OnOffDelay "Require separate continuous dwell times for rising and falling states"
parameter Modelica.Units.SI.Time onDelay(min=0)=0.1;
  parameter Modelica.Units.SI.Time offDelay(min=0)=0.1;
    Modelica.Blocks.Interfaces.BooleanInput u annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y(start=false,fixed=true) annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  discrete Modelica.Units.SI.Time changed(start=0,fixed=true);
  Boolean riseQualified;
  Boolean fallQualified;
initial equation
  assert(onDelay>=0 and offDelay>=0,"Invalid on/off delay.");
equation
  when {initial(),change(u)} then changed=time; end when;
  riseQualified=u and time>=changed+onDelay;
  fallQualified=not u and time>=changed+offDelay;
  when {initial(),riseQualified,fallQualified} then
    y=if riseQualified then true elseif fallQualified or initial() then false else pre(y);
  end when;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,29},{-45,29},{-45,55},{17,55},{17,29},{65,29}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-66,-34},{-17,-34},{-17,-8},{45,-8},{45,-34},{65,-34}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-45,10},{-17,10}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{17,10},{45,10}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Require separate continuous dwell times for rising and falling states.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput u; Modelica.Blocks.Interfaces.BooleanOutput y(start=false,fixed=true)</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time onDelay(min=0)=0.1; parameter Modelica.Units.SI.Time offDelay(min=0)=0.1</p><p><b>Behavior</b> Require separate continuous dwell times for rising and falling states</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> y</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end OnOffDelay;
