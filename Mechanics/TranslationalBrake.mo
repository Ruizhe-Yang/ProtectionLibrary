within ProtectionLibrary.Mechanics;
model TranslationalBrake "Saturated viscous brake for relative translation"
parameter Real Fmax(unit="N",min=0)=100 "Maximum absolute braking force";
  parameter Real d(unit="N.s/m",min=0)=2 "Nonnegative viscous braking coefficient";
  parameter Boolean useSupport=false "Expose a moving mechanical support";
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange  "Connection to the braked body" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Interfaces.Support support if useSupport  "Optional moving reference connection" annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.BooleanInput command  "Enable viscous braking" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Real relativeSpeed(unit="m/s") "Flange speed relative to the reference in metres per second";
  Real brakingEffort(unit="N") "Signed force applied to the connected body in newtons";
  Modelica.Units.SI.Power lossPower "Nonnegative mechanical dissipation";
protected
  Real reference "Support position or zero for a fixed reference";
initial equation
  assert(Fmax>=0 and d>=0,"Invalid braking limits.");
equation
  if useSupport then
    reference=support.s;
    support.f=-flange.f;
  else
    reference=0;
  end if;
  relativeSpeed=der(flange.s-reference);
  flange.f=if command then min(Fmax,max(-Fmax,d*relativeSpeed)) else 0;
  brakingEffort=-flange.f;
  lossPower=flange.f*relativeSpeed;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-43,0}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Rectangle(extent={{-43,-18},{43,18}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-21,0},{23,0}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-33,46},{33,58}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-33,-58},{33,-46}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{0,-59},{0,-100}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-55,51},{-55,-51},{0,-51}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>While <code>command=true</code>, apply a viscous force proportional to relativeSpeed, limited in magnitude by <code>Fmax</code>. The effort opposes motion in the connected body; <code>brakingEffort</code> is the negative of the effort entering the brake flange.</p><p>With useSupport=false, the reference position is fixed at zero. Otherwise connect support to the moving reference. <code>lossPower</code> reports nonnegative dissipation. The brake produces no static holding effort at zero relative speed and contains no thermal port or heat storage.</p></html>"));
end TranslationalBrake;
