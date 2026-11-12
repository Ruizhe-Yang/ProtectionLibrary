within ProtectionLibrary.Examples;
model ThresholdLatchReset "Qualify a threshold then latch until a safe reset edge"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.RealExpression signal(y=if time<0.35 then 12 elseif time<1 then 7 elseif time<3 then 12 else 7) annotation(Placement(transformation(origin={-263,100},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression reset(y=(time>=1.2 and time<1.3) or (time>=3.4 and time<3.5)) annotation(Placement(transformation(origin={-263,-87},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression clearPermission(y=true) annotation(Placement(transformation(origin={-263,-160},extent={{-12,-12},{12,12}},rotation=0)));
  ProtectionLibrary.Criteria.HighLimit limit(tripLevel=10,resetLevel=8) annotation(Placement(transformation(origin={-147,100},extent={{-15,-15},{15,15}},rotation=0)));
  ProtectionLibrary.Criteria.Persistence persist(holdTime=0.2) annotation(Placement(transformation(origin={-35,100},extent={{-15,-15},{15,15}},rotation=0)));
  ProtectionLibrary.Coordination.ResetPermission safeDwell(clearTime=0.25) annotation(Placement(transformation(origin={-35,-70},extent={{-16,-16},{16,16}},rotation=0)));
  ProtectionLibrary.Coordination.TripLatch latch annotation(Placement(transformation(origin={123,35},extent={{-18,-18},{18,18}},rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput protectedState annotation(Placement(transformation(origin={246,35},extent={{-7,-7},{7,7}},rotation=0)));
equation
  connect(signal.y,limit.u) annotation(Line(points={{-249.8,100},{-205.9,100},{-205.9,110.5},{-162,110.5}},color={0,0,127}));
  connect(limit.request,persist.u) annotation(Line(points={{-157.5,115},{-157.5,120},{-157.5,110.5},{-50,110.5}},color={255,0,255}));
  connect(limit.request,safeDwell.danger) annotation(Line(points={{-157.5,115},{-157.5,120},{-157.5,-58.8},{-51,-58.8}},color={255,0,255}));
  connect(clearPermission.y,safeDwell.permissives) annotation(Line(points={{-249.8,-160},{-150.4,-160},{-150.4,-81.2},{-51,-81.2}},color={255,0,255}));
  connect(persist.request,latch.trip) annotation(Line(points={{-45.5,115},{-45.5,120},{-45.5,47.6},{105,47.6}},color={255,0,255}));
  connect(reset.y,latch.reset) annotation(Line(points={{-249.8,-87},{-244.8,-87},{-244.8,58},{123,58},{123,53}},color={255,0,255}));
  connect(safeDwell.resetAllowed,latch.resetAllowed) annotation(Line(points={{-19,-70},{43,-70},{43,22.4},{105,22.4}},color={255,0,255}));
  connect(latch.latched,protectedState) annotation(Line(points={{141,35},{246,35}},color={255,0,255}));
  annotation(experiment(StartTime=0,StopTime=6,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true)),
    Documentation(info="<html><p><b>Purpose</b> Qualify a threshold then latch until a safe reset edge</p><p><b>Interfaces</b> Instances and connections are shown in the Diagram layer.</p><p><b>Parameters</b> Default values are shown in the component modifiers.</p><p><b>Behavior</b> The high criterion is active at initialization. Reset at 1.2 s cannot override a qualified trip. Reset at 3.4 s follows the clear dwell.</p><p><b>Initialization</b> All initial conditions are explicit in the source and component modifiers.</p><p><b>Activation and recovery</b> The given time windows follow the simulation time axis.</p><p><b>Limitations</b> This demonstration uses the declared inputs, initial conditions and idealized components.</p><p><b>Observables</b> limit.request, persist.request, safeDwell.resetAllowed and protectedState.</p></html>"));
end ThresholdLatchReset;
