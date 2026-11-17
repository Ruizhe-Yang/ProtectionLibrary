within ProtectionLibrary.Mechanics;
model RotationalBrake "Saturated viscous brake for relative angular motion"
parameter Real tauMax(unit="N.m",min=0)=100 "Maximum absolute braking torque";
  parameter Real d(unit="N.m.s/rad",min=0)=2 "Nonnegative viscous braking coefficient";
  parameter Boolean useSupport=false "Expose a moving mechanical support";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange  "Connection to the braked body" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Support support if useSupport  "Optional moving reference connection" annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput command  "Enable viscous braking" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Real relativeSpeed(unit="rad/s") "Flange speed relative to the reference in radians per second";
  Real brakingEffort(unit="N.m") "Signed torque applied to the connected body in newton metres";
  Modelica.Units.SI.Power lossPower "Nonnegative mechanical dissipation";
protected
  Real reference "Support angle or zero for a fixed reference";
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
    Documentation(info="<html><p>While <code>command=true</code>, apply a viscous torque proportional to relativeSpeed, limited in magnitude by <code>tauMax</code>. The effort opposes motion in the connected body; <code>brakingEffort</code> is the negative of the effort entering the brake flange.</p><p>With useSupport=false, the reference angle is fixed at zero. Otherwise connect support to the moving reference. <code>lossPower</code> reports nonnegative dissipation. The brake produces no static holding effort at zero relative speed and contains no thermal port or heat storage.</p></html>"));
end RotationalBrake;
