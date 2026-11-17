within ProtectionLibrary.Voting.AnalogVoting;
block Median5 "Median of qualified measurements from five channels"
final parameter Integer n(min=1)=5 "Number of measurement channels";
  parameter Integer minValid(min=1,max=n)=3 "Minimum eligible count, after trimming when used";
  final parameter ProtectionLibrary.Utilities.Types.AnalogMethod method=ProtectionLibrary.Utilities.Types.AnalogMethod.Median "Fusion method for eligible measurements";
  parameter Integer trimEachSide(min=0)=1 "Number removed at each sorted end for TrimmedMean";
  parameter Real weights[n]=fill(1,n) "Finite nonnegative channel weights for WeightedMean";
  parameter Boolean useValidInput=false "Expose external channel-qualification inputs";
  parameter Real fallbackValue=0 "Constant fallback and initial HoldLast value";
  parameter ProtectionLibrary.Utilities.Types.Fallback fallback=ProtectionLibrary.Utilities.Types.Fallback.Value "Output policy while fusion is unavailable";
    Modelica.Blocks.Interfaces.RealInput u[n]  "Measurements expressed in a common unit" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput  "External channel qualification" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y  "Available fused value or selected fallback" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput available  "True when count and method-specific requirements are met" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput nValid  "Number of finite qualified measurements before trimming" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput qualified[n]  "Qualification vector after optional-input binding" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Real candidate "Fused value before fallback selection";
  Boolean eligible[n] "Channels that are both qualified and finite";
  Real qualifiedWeight "Sum of eligible channel weights";
  Real held(start=0,fixed=true) "Fallback value retained for HoldLast";
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
        Line(points={{-56,-30},{-56,-24}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-60,-28},{-52,-20}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-28,-30},{-28,-3}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-32,-7},{-24,1}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-30},{0,9}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-4,5},{4,13}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{28,-30},{28,28}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{24,24},{32,32}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{56,-30},{56,40}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{52,36},{60,44}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-9,0},{9,18}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=1),
        Text(extent={{-65,-50},{65,-75}}, textString="med(5)", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Calculate the median of the eligible entries from five channels. An even eligible count returns the arithmetic mean of the two middle values. Use measurements in one common unit. An entry is eligible only when qualified and finite. With <code>useValidInput=false</code>, all entries are qualified, but non-finite values are still excluded.</p><p>Read <code>available</code> with <code>y</code>; <code>nValid</code> counts eligible entries before any trimming. While unavailable, Value returns <code>fallbackValue</code>. HoldLast starts at <code>fallbackValue</code> and, on loss of availability, retains the fusion evaluated from <code>pre(u)</code> and <code>pre(qualified)</code>.</p></html>"));
end Median5;
