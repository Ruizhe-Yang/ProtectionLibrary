within ProtectionLibrary.Examples;
model MechanicalBraking "Apply finite viscous braking to moving rotational and translational bodies"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanExpression brakeRequest(y=time>=1 and time<4) annotation(Placement(transformation(origin={-152,113},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia rotationBody(J=1,w(start=10,fixed=true),phi(start=0,fixed=true)) annotation(Placement(transformation(origin={-103,45},extent={{-16,-16},{16,16}},rotation=0)));
  ProtectionLibrary.Mechanics.RotationalBrake rotationBrake(d=2) annotation(Placement(transformation(origin={87,45},extent={{-16,-16},{16,16}},rotation=0)));
  Modelica.Mechanics.Translational.Components.Mass translationBody(m=1,v(start=10,fixed=true),s(start=0,fixed=true)) annotation(Placement(transformation(origin={-103,-82},extent={{-16,-16},{16,16}},rotation=0)));
  ProtectionLibrary.Mechanics.TranslationalBrake translationBrake(d=2) annotation(Placement(transformation(origin={87,-82},extent={{-16,-16},{16,16}},rotation=0)));
equation
  connect(rotationBody.flange_b,rotationBrake.flange) annotation(Line(points={{-87,45},{71,45}},color={0,0,0}));
  connect(brakeRequest.y,rotationBrake.command) annotation(Line(points={{-138.8,113},{87,113},{87,61}},color={255,0,255}));
  connect(translationBody.flange_b,translationBrake.flange) annotation(Line(points={{-87,-82},{71,-82}},color={0,127,0}));
  connect(brakeRequest.y,translationBrake.command) annotation(Line(points={{-138.8,113},{-22.9,113},{-22.9,-60},{87,-60},{87,-66}},color={255,0,255}));
  annotation(experiment(StartTime=0,StopTime=5,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-240,-160},{240,160}},preserveAspectRatio=true)),
    Documentation(info="<html><p><b>Purpose</b> Apply finite viscous braking to moving rotational and translational bodies</p><p><b>Interfaces</b> Instances and connections are shown in the Diagram layer.</p><p><b>Parameters</b> Default values are shown in the component modifiers.</p><p><b>Behavior</b> The rotational speed is 10 exp(-2(t-1)) in the active unsaturated interval. It is about 1.3533528 rad/s at 2 s.</p><p><b>Initialization</b> All initial conditions are explicit in the source and component modifiers.</p><p><b>Activation and recovery</b> The given time windows follow the simulation time axis.</p><p><b>Limitations</b> This demonstration uses the declared inputs, initial conditions and idealized components.</p><p><b>Observables</b> rotationBody.w, translationBody.v and both braking losses.</p></html>"));
end MechanicalBraking;
