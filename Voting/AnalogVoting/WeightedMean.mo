within ProtectionLibrary.Voting.AnalogVoting;
block WeightedMean "Fuse only qualified measurements using weightedmean"
parameter Integer n(min=1)=3;
  parameter Integer minValid(min=1,max=n)=2;
  final parameter ProtectionLibrary.Utilities.Types.AnalogMethod method=ProtectionLibrary.Utilities.Types.AnalogMethod.WeightedMean;
  parameter Integer trimEachSide(min=0)=1;
  parameter Real weights[n]=fill(1,n);
  parameter Boolean useValidInput=false;
  parameter Real fallbackValue=0;
  parameter ProtectionLibrary.Utilities.Types.Fallback fallback=ProtectionLibrary.Utilities.Types.Fallback.Value;
    Modelica.Blocks.Interfaces.RealInput u[n] annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput available annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput nValid annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput qualified[n] annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Real candidate;
  Boolean eligible[n];
  Real qualifiedWeight;
  Real held(start=0,fixed=true);
initial equation
  assert(n>=1 and minValid>=1 and minValid<=n and trimEachSide>=0 and min(weights)>=0 and max(weights)<Modelica.Constants.inf,"Invalid fusion configuration.");
equation
  connect(valid,qualified);
  if not useValidInput then qualified=fill(true,n); end if;
  for i in 1:n loop
    eligible[i]=qualified[i] and abs(u[i])<Modelica.Constants.inf;
  end for;
  nValid=sum(if eligible[i] then 1 else 0 for i in 1:n);
  qualifiedWeight=sum(if eligible[i] then weights[i] else 0 for i in 1:n);
  available=nValid>=minValid and (if method==ProtectionLibrary.Utilities.Types.AnalogMethod.WeightedMean then qualifiedWeight>0
    elseif method==ProtectionLibrary.Utilities.Types.AnalogMethod.TrimmedMean then nValid-2*trimEachSide>=minValid else true);
  candidate=ProtectionLibrary.Utilities.Functions.Fuse(u,qualified,weights,minValid,trimEachSide,method);
  if fallback==ProtectionLibrary.Utilities.Types.Fallback.HoldLast then
    when {initial(),not available} then
      held=if initial() then fallbackValue else ProtectionLibrary.Utilities.Functions.Fuse(pre(u),pre(qualified),weights,minValid,trimEachSide,method);
    end when;
  else
    held=fallbackValue;
  end if;
  y=if available then candidate else if fallback==ProtectionLibrary.Utilities.Types.Fallback.HoldLast then held else fallbackValue;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,-30},{66,-30}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-56,-30},{-56,-20}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-60,-24},{-52,-16}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-30},{0,3}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-4,-1},{4,7}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{56,-30},{56,32}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{52,28},{60,36}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-62,8},{62,8}}, color={0,0,127}, thickness=1, pattern=LinePattern.Dash),
        Text(extent={{29,68},{68,43}}, textString="w", textColor={64,64,64}, fontSize=0),
        Text(extent={{-65,-50},{65,-75}}, textString="weighted", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Fuse only qualified measurements using weightedmean.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput u[n]; Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput; Modelica.Blocks.Interfaces.RealOutput y; Modelica.Blocks.Interfaces.BooleanOutput available; Modelica.Blocks.Interfaces.IntegerOutput nValid</p><p><b>Parameters</b> parameter Integer n(min=1)=3; parameter Integer minValid(min=1,max=n)=2; final parameter ProtectionLibrary.Utilities.Types.AnalogMethod method=ProtectionLibrary.Utilities.Types.AnalogMethod.WeightedMean; parameter Integer trimEachSide(min=0)=1; parameter Real weights[n]=fill(1,n); parameter Boolean useValidInput=false; parameter Real fallbackValue=0; parameter ProtectionLibrary.Utilities.Types.Fallback fallback=ProtectionLibrary.Utilities.Types.Fallback.Value</p><p><b>Behavior</b> Fuse only qualified measurements using weightedmean</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Missing channels never enter the statistic. A fallback can be returned while available remains false.</p><p><b>Observables</b> y, available, nValid</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.BooleanVoting\">ProtectionLibrary.Examples.BooleanVoting</a></p></html>"));
end WeightedMean;
