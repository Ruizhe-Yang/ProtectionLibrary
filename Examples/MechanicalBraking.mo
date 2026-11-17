within ProtectionLibrary.Examples;
model MechanicalBraking "Apply finite viscous braking to rotational and translational bodies"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanExpression brakeRequest(y=time>=1 and time<4)  "Finite braking interval" annotation(Placement(transformation(origin={-152,113},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia rotationBody(J=1,w(start=10,fixed=true),phi(start=0,fixed=true))  "Inertia with a prescribed initial angular velocity" annotation(Placement(transformation(origin={-103,45},extent={{-16,-16},{16,16}},rotation=0)));
  ProtectionLibrary.Mechanics.RotationalBrake rotationBrake(d=2)  "Viscous brake acting on the inertia" annotation(Placement(transformation(origin={87,45},extent={{-16,-16},{16,16}},rotation=0)));
  Modelica.Mechanics.Translational.Components.Mass translationBody(m=1,v(start=10,fixed=true),s(start=0,fixed=true))  "Mass with a prescribed initial velocity" annotation(Placement(transformation(origin={-103,-82},extent={{-16,-16},{16,16}},rotation=0)));
  ProtectionLibrary.Mechanics.TranslationalBrake translationBrake(d=2)  "Viscous brake acting on the mass" annotation(Placement(transformation(origin={87,-82},extent={{-16,-16},{16,16}},rotation=0)));
equation
  connect(rotationBody.flange_b,rotationBrake.flange) annotation(Line(points={{-87,45},{71,45}},color={0,0,0}));
  connect(brakeRequest.y,rotationBrake.command) annotation(Line(points={{-138.8,113},{87,113},{87,61}},color={255,0,255}));
  connect(translationBody.flange_b,translationBrake.flange) annotation(Line(points={{-87,-82},{71,-82}},color={0,127,0}));
  connect(brakeRequest.y,translationBrake.command) annotation(Line(points={{-138.8,113},{-22.9,113},{-22.9,-60},{87,-60},{87,-66}},color={255,0,255}));
  annotation(experiment(StartTime=0,StopTime=5,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-240,-160},{240,160}},preserveAspectRatio=true)),
    Documentation(info="<html><p>Begin with angular velocity 10 rad/s and translational velocity 10 m/s in separate mechanical systems. Enable both viscous brakes over the interval <code>[1,4)</code> s.</p><p>Plot <code>rotationBody.w</code>, <code>translationBody.v</code> and the brake reaction variables. The brakes dissipate motion through finite velocity-dependent resistance; the command does not impose an instantaneous stop or a static lock.</p></html>"));
end MechanicalBraking;
