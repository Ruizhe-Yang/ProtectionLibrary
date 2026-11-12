within ProtectionLibrary.Voting.BooleanVoting;
block TwoOutOfFour "Boolean 2-out-of-4 protection vote"
final parameter Integer n(min=1)=4;
  final parameter Integer m(min=1,max=n)=2;
  parameter Integer minValid(min=1,max=n)=m;
  parameter Boolean useValidInput=false;
  parameter Boolean invalidVote=true;
    Modelica.Blocks.Interfaces.BooleanInput u[n] annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput nValid annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput degraded annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput enoughValid annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput qualified[n] annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
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
        Ellipse(extent={{-66,12},{-58,20}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,16},{-13,16}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-66,-20},{-58,-12}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,-16},{-13,-16}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-66,-52},{-58,-44}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-57,-48},{-13,-48}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{57,0},{75,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-7,26},{52,-8}}, textString=">= 2", textColor={64,64,64}, fontSize=0),
        Text(extent={{-65,-50},{65,-75}}, textString="2oo4", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Boolean 2-out-of-4 protection vote.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput u[n]; Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput y; Modelica.Blocks.Interfaces.IntegerOutput nValid; Modelica.Blocks.Interfaces.BooleanOutput degraded; Modelica.Blocks.Interfaces.BooleanOutput enoughValid</p><p><b>Parameters</b> final parameter Integer n(min=1)=4; final parameter Integer m(min=1,max=n)=2; parameter Integer minValid(min=1,max=n)=m; parameter Boolean useValidInput=false; parameter Boolean invalidVote=true</p><p><b>Behavior</b> Boolean 2-out-of-4 protection vote</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The threshold is fixed. An invalid channel is a protection vote by default. Choosing false can suppress a request with missing data.</p><p><b>Observables</b> y, nValid, degraded, enoughValid</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.BooleanVoting\">ProtectionLibrary.Examples.BooleanVoting</a></p></html>"));
end TwoOutOfFour;
