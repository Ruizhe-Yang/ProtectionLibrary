within ProtectionLibrary.Coordination;
block OnOffDelay "Separate continuous delays for rising and falling commands"
parameter Modelica.Units.SI.Time onDelay(min=0)=0.1 "Required continuously true input interval";
  parameter Modelica.Units.SI.Time offDelay(min=0)=0.1 "Required continuously false input interval";
    Modelica.Blocks.Interfaces.BooleanInput u  "Boolean condition to delay" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y(start=false,fixed=true)  "Command after rising or falling qualification" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  discrete Modelica.Units.SI.Time changed(start=0,fixed=true) "Time of initialisation or the latest input change";
  Boolean riseQualified "True input has satisfied the on delay";
  Boolean fallQualified "False input has satisfied the off delay";
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
    Documentation(info="<html><p>Change y to true only after u has remained true for onDelay, and to false only after u has remained false for offDelay. Every input change restarts the relevant interval; shorter excursions leave the output unchanged.</p><p>At initialisation the output is false unless an initially true input qualifies immediately with zero on delay. This delays changes of the input condition rather than enforcing time since the latest output transition.</p></html>"));
end OnOffDelay;
