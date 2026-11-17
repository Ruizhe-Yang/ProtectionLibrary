within ProtectionLibrary.Criteria;
block SensorDisagreement "Spread criterion over valid finite sensor channels"
parameter Integer n(min=2)=3 "Number of comparable sensor channels";
  parameter Real tolerance(min=0)=0.2 "Largest accepted spread between retained channels";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  parameter Boolean useValidInput=false "Enable the external validity input";
    Modelica.Blocks.Interfaces.RealInput u[n]  "Comparable measurements in a common unit" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput  "External validity flags for individual channels" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput spread  "Maximum minus minimum accepted value, or zero" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trust[n]  "Bound channel validity flags" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Real lo "Lowest retained finite value";
  Real hi "Highest retained finite value";
  Integer count "Number of retained finite channels";
initial equation
  assert(n>=2 and tolerance>=0,"Invalid disagreement criterion.");
equation
  connect(valid,trust);
  if not useValidInput then trust=fill(true,n); end if;
  count=sum(if trust[i] and abs(u[i])<Modelica.Constants.inf then 1 else 0 for i in 1:n);
  lo=min({if trust[i] and abs(u[i])<Modelica.Constants.inf then u[i] else Modelica.Constants.inf for i in 1:n});
  hi=max({if trust[i] and abs(u[i])<Modelica.Constants.inf then u[i] else -Modelica.Constants.inf for i in 1:n});
  inputValid=count>=2;
  spread=if inputValid then hi-lo else 0;
  condition=inputValid and spread>tolerance;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-62,55},{-62,-40},{65,-40}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-57,-12},{-30,4},{2,3},{29,18},{56,23}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-57,-18},{-30,-1},{2,-3},{29,8},{56,9}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-57,-14},{-30,2},{2,0},{29,-26},{56,-27}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{65,23},{65,-27}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-56,72},{60,48}}, textString="spread", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Exclude channels whose optional validity flag is false or whose magnitude is not finite. With at least two remaining channels, <code>spread</code> is the maximum minus the minimum and <code>condition</code> is true when the spread strictly exceeds <code>tolerance</code>.</p><p>With fewer than two accepted channels, input validity and condition are false, spread is zero and the request takes <code>failSafe</code>. No channel is selected as the correct measurement.</p></html>"));
end SensorDisagreement;
