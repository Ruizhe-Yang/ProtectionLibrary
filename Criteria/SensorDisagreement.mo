within ProtectionLibrary.Criteria;
block SensorDisagreement "Check spread only among sufficiently valid channels"
parameter Integer n(min=2)=3;
  parameter Real tolerance(min=0)=0.2;
  parameter Boolean failSafe=true;
  parameter Boolean useValidInput=false;
    Modelica.Blocks.Interfaces.RealInput u[n] annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput spread annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trust[n] annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Real lo;
  Real hi;
  Integer count;
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
    Documentation(info="<html><p><b>Purpose</b> Check spread only among sufficiently valid channels.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput u[n]; Modelica.Blocks.Interfaces.BooleanInput valid[n] if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput inputValid; Modelica.Blocks.Interfaces.BooleanOutput condition; Modelica.Blocks.Interfaces.BooleanOutput request; Modelica.Blocks.Interfaces.RealOutput spread</p><p><b>Parameters</b> parameter Integer n(min=2)=3; parameter Real tolerance(min=0)=0.2; parameter Boolean failSafe=true; parameter Boolean useValidInput=false</p><p><b>Behavior</b> Check spread only among sufficiently valid channels</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The spread detects disagreement. It does not identify which sensor is faulty.</p><p><b>Observables</b> inputValid, condition, request, spread</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end SensorDisagreement;
