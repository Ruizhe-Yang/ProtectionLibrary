within ProtectionLibrary.Examples;
model ActionFeedbackAndFailure "Distinguish two identical requests using independent measured action"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanExpression request(y=time>=1) annotation(Placement(transformation(origin={-270,172},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.RealExpression requestedActuation(y=if request.y then 1 else 0) annotation(Placement(transformation(origin={-270,71},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression permit(y=false) annotation(Placement(transformation(origin={-270,-16},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation(Placement(transformation(origin={-270,-106},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Logical.Switch faultedInput annotation(Placement(transformation(origin={-145,-57},extent={{-15,-15},{15,15}},rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder goodActuator(T=0.05,y_start=0,initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(origin={-19,108},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression goodMeasured(y=goodActuator.y>=0.9) annotation(Placement(transformation(origin={99,108},extent={{-12,-12},{12,12}},rotation=0)));
  ProtectionLibrary.Coordination.ActionMonitor goodMonitor(timeout=0.2) annotation(Placement(transformation(origin={226,108},extent={{-20,-20},{20,20}},rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder refusedActuator(T=0.05,y_start=0,initType=Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(origin={-19,-63},extent={{-17,-17},{17,17}},rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression refusedMeasured(y=refusedActuator.y>=0.9) annotation(Placement(transformation(origin={99,-63},extent={{-12,-12},{12,12}},rotation=0)));
  ProtectionLibrary.Coordination.ActionMonitor refusedMonitor(timeout=0.2) annotation(Placement(transformation(origin={226,-63},extent={{-20,-20},{20,20}},rotation=0)));
equation
  connect(request.y,goodMonitor.command) annotation(Line(points={{-256.8,172},{200,172},{200,122},{206,122}},color={255,0,255}));
  connect(goodMeasured.y,goodMonitor.measuredAction) annotation(Line(points={{112.2,108},{159.1,108},{159.1,94},{206,94}},color={255,0,255}));
  connect(requestedActuation.y,goodActuator.u) annotation(Line(points={{-256.8,71},{-148.1,71},{-148.1,108},{-39.4,108}},color={0,0,127}));
  connect(request.y,refusedMonitor.command) annotation(Line(points={{-256.8,172},{200,172},{200,-49},{206,-49}},color={255,0,255}));
  connect(refusedMeasured.y,refusedMonitor.measuredAction) annotation(Line(points={{112.2,-63},{159.1,-63},{159.1,-77},{206,-77}},color={255,0,255}));
  connect(faultedInput.y,refusedActuator.u) annotation(Line(points={{-128.5,-57},{-83.95,-57},{-83.95,-63},{-39.4,-63}},color={0,0,127}));
  connect(requestedActuation.y,faultedInput.u1) annotation(Line(points={{-256.8,71},{-251.8,71},{-251.8,-45},{-163,-45}},color={0,0,127}));
  connect(permit.y,faultedInput.u2) annotation(Line(points={{-256.8,-16},{-209.9,-16},{-209.9,-57},{-163,-57}},color={255,0,255}));
  connect(zero.y,faultedInput.u3) annotation(Line(points={{-256.8,-106},{-251.8,-106},{-251.8,-69},{-163,-69}},color={0,0,127}));
  annotation(experiment(StartTime=0,StopTime=4,Interval=0.008,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true),graphics={Text(extent={{-11,165},{219,151}},textString="Measured actuator response",textColor={34,61,73}),Text(extent={{-69.5,-122},{217.5,-136}},textString="Independent response blocked by switch",textColor={34,61,73})}),
    Documentation(info="<html><p><b>Purpose</b> Distinguish two identical requests using independent measured action</p><p><b>Interfaces</b> Instances and connections are shown in the Diagram layer.</p><p><b>Parameters</b> Default values are shown in the component modifiers.</p><p><b>Behavior</b> The good measured response reaches 0.9 around 1.1151293 s. The blocked branch reaches timeout at 1.2 s with no measured action.</p><p><b>Initialization</b> All initial conditions are explicit in the source and component modifiers.</p><p><b>Activation and recovery</b> The given time windows follow the simulation time axis.</p><p><b>Limitations</b> This demonstration uses the declared inputs, initial conditions and idealized components.</p><p><b>Observables</b> goodMonitor.actionTime, goodMonitor.acknowledged, refusedMonitor.failed and both actuator outputs.</p></html>"));
end ActionFeedbackAndFailure;
