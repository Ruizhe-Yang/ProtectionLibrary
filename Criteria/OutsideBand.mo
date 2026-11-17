within ProtectionLibrary.Criteria;
block OutsideBand "Independent lower and upper hysteresis criteria"
parameter Boolean useValidInput=false "Enable the external validity input";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput  "External qualification of the supplied signal" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Real low=0 "Inclusive lower trip threshold";
  parameter Real high=10 "Inclusive upper trip threshold";
  parameter Real resetLow=1 "Threshold that clears the lower cause";
  parameter Real resetHigh=9 "Threshold that clears the upper cause";
    Modelica.Blocks.Interfaces.RealInput u  "Signal to assess" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput below  "Retained lower-limit cause" annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput above  "Retained upper-limit cause" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted  "Bound external validity, or true when the input is disabled" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));

initial equation
  assert(low<resetLow and resetLow<=resetHigh and resetHigh<high,"Invalid band and reset limits.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  when {initial(),u<=low,u>=resetLow} then below=if u<=low then true elseif initial() or u>=resetLow then false else pre(below); end when;
  when {initial(),u>=high,u<=resetHigh} then above=if u>=high then true elseif initial() or u<=resetHigh then false else pre(above); end when;
  condition=below or above;
  inputValid=trusted and abs(u)<Modelica.Constants.inf;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-61,34},{63,34}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-61,-18},{63,-18}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-60,3},{-38,7},{-18,44},{3,6},{27,1},{42,-31},{60,6}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>The lower cause sets at <code>u&lt;=low</code> and clears at <code>u&gt;=resetLow</code>; the upper cause sets at <code>u&gt;=high</code> and clears at <code>u&lt;=resetHigh</code>. Configure <code>low&lt;resetLow&lt;=resetHigh&lt;high</code>. At initialisation, each cause is set only if its trip limit is reached.</p><p><code>condition</code> is the union of <code>below</code> and <code>above</code>. Both states evolve independently of external validity. <code>request</code> follows condition for a finite, externally valid input and otherwise takes <code>failSafe</code>.</p></html>"));
end OutsideBand;
