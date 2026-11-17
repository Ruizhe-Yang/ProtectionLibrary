within ProtectionLibrary.Criteria;
block HighLimit "Upper-limit criterion with hysteretic reset"
parameter Boolean useValidInput=false "Enable the external validity input";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput  "External qualification of the supplied signal" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));
  parameter Real tripLevel=10 "Inclusive upper threshold that sets the condition";
  parameter Real resetLevel=8 "Inclusive lower threshold that clears the condition";
  Modelica.Blocks.Interfaces.RealInput u  "Signal to assess" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted  "Bound external validity, or true when the input is disabled" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));

initial equation
  assert(resetLevel<tripLevel,"Invalid trip/reset ordering.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  when {initial(),u>=tripLevel,u<=resetLevel} then
    condition=if u>=tripLevel then true elseif initial() or u<=resetLevel then false else pre(condition);
  end when;
  inputValid=trusted and abs(u)<Modelica.Constants.inf;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,57},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-58,-24},{17,-24},{17,35},{60,35}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{60,26},{-19,26},{-19,-33},{-58,-33}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-19,10},{-19,-8}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{17,-7},{17,12}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-19,-48},{-19,-39}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{17,-48},{17,-39}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Text(extent={{-65,-50},{65,-75}}, textString="> hi", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Set <code>condition</code> when <code>u&gt;=tripLevel</code> and clear it when <code>u&lt;=resetLevel</code>, with <code>resetLevel&lt;tripLevel</code>. Initialisation below the trip level starts with a clear condition, including within the hysteresis band.</p><p>The hysteresis state follows the signal independently of external validity. <code>inputValid</code> combines the optional validity input with a finite-value check; <code>request</code> follows condition for valid input and otherwise takes <code>failSafe</code>.</p></html>"));
end HighLimit;
