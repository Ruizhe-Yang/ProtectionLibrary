within ProtectionLibrary.Mechanics;
model RotationalBrake "Apply passive limited viscous braking to relative motion"
parameter Real tauMax(unit="N.m",min=0)=100;
  parameter Real d(unit="N.m.s/rad",min=0)=2;
  parameter Boolean useSupport=false;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Support support if useSupport annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput command annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Real relativeSpeed(unit="rad/s");
  Real brakingEffort(unit="N.m");
  Modelica.Units.SI.Power lossPower;
protected
  Real reference;
initial equation
  assert(tauMax>=0 and d>=0,"Invalid braking limits.");
equation
  if useSupport then
    reference=support.phi;
    support.tau=-flange.tau;
  else
    reference=0;
  end if;
  relativeSpeed=der(flange.phi-reference);
  flange.tau=if command then min(tauMax,max(-tauMax,d*relativeSpeed)) else 0;
  brakingEffort=-flange.tau;
  lossPower=flange.tau*relativeSpeed;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-43,0}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Ellipse(extent={{-41,-40},{41,40}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-12,-12},{12,12}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{-33,46},{33,58}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-33,-58},{33,-46}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{0,-59},{0,-100}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-55,51},{-55,-51},{0,-51}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Apply passive limited viscous braking to relative motion.</p><p><b>Interfaces</b> Modelica.Mechanics.Rotational.Interfaces.Flange_a flange; Modelica.Blocks.Interfaces.BooleanInput command</p><p><b>Parameters</b> parameter Real tauMax(unit=\"N.m\",min=0)=100; parameter Real d(unit=\"N.m.s/rad\",min=0)=2; parameter Boolean useSupport=false</p><p><b>Behavior</b> Apply passive limited viscous braking to relative motion</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The braking force opposes relative velocity. Zero speed produces zero effort. No static hold is modeled.</p><p><b>Observables</b> Public outputs and the stated input conditions.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.MechanicalBraking\">ProtectionLibrary.Examples.MechanicalBraking</a></p></html>"));
end RotationalBrake;
