within ProtectionLibrary.Voting.BooleanVoting;
block ThreeOutOfFive "Boolean 3-out-of-5 vote with invalid-channel substitution"
final parameter Integer n(min=1)=5 "Number of vote channels";
  final parameter Integer m(min=1,max=n)=3 "Minimum number of true effective votes";
  parameter Integer minValid(min=1,max=n)=m "Qualified-channel count required by enoughValid";
  parameter Boolean useValidInput=false "Expose external channel-qualification inputs";
  parameter Boolean invalidVote=true "Vote substituted for each unqualified channel";
    Modelica.Blocks.Interfaces.BooleanInput u[n]  "Boolean channel requests" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput  "External channel qualification" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y  "True when the effective true-vote count reaches m" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput nValid  "Number of qualified channels" annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput degraded  "True when any channel is unqualified" annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput enoughValid  "True when nValid reaches minValid, independent of y" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput qualified[n]  "Qualification vector after optional-input binding" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
initial equation
  assert(n>=1 and m>=1 and m<=n and minValid>=1 and minValid<=n,"Invalid vote dimensions.");
equation
  connect(valid,qualified);
  if not useValidInput then qualified=fill(true,n); end if;
  nValid=sum(if qualified[i] then 1 else 0 for i in 1:n);
  y=sum(if (if qualified[i] then u[i] else invalidVote) then 1 else 0 for i in 1:n)>=m;
  degraded=nValid<n;
  enoughValid=nValid>=minValid;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-13,-54},{57,54}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-66,44},{-58,52}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,48},{-13,48}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-66,20},{-58,28}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,24},{-13,24}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-66,-4},{-58,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,0},{-13,0}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-66,-28},{-58,-20}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,-24},{-13,-24}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-66,-52},{-58,-44}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,-48},{-13,-48}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{57,0},{75,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-7,26},{52,-8}}, textString=">= 3", textColor={64,64,64}, fontSize=0),
        Text(extent={{-65,-50},{65,-75}}, textString="3oo5", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Set <code>y</code> when at least 3 of the 5 effective votes are true. A qualified channel contributes its <code>u</code> value; an unqualified channel contributes <code>invalidVote</code>, which defaults to true. Enable <code>useValidInput</code> to supply the qualification vector; otherwise every channel is qualified.</p><p><code>nValid</code> counts qualified channels, <code>degraded</code> marks any loss of qualification, and <code>enoughValid</code> compares the count with <code>minValid</code>. These diagnostic outputs do not gate the vote or change its threshold.</p></html>"));
end ThreeOutOfFive;
