within ProtectionLibrary.Mechanics;
model TravelStop "Compliant travel stops with compression-only damping"
parameter Modelica.Units.SI.Length lower=-0.1 "Relative position of the optional lower stop";
  parameter Modelica.Units.SI.Length upper=0.1 "Relative position of the upper stop";
  parameter Boolean twoSided=true "Enable the lower stop as well as the upper stop";
  parameter Real k(unit="N/m",min=0)=1000 "Nonnegative contact stiffness";
  parameter Real d(unit="N.s/m",min=0)=5 "Nonnegative damping coefficient during increasing penetration";
  parameter Modelica.Units.SI.Length blend(min=0)=0.001 "Positive penetration scale for damping activation";
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a  "First translational connection" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b  "Second translational connection" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Length position "Position of flange_b relative to flange_a";
  Modelica.Units.SI.Velocity speed "Rate of change of relative position";
  Modelica.Units.SI.Force contactForce "Signed contact force entering flange_b";
  Modelica.Units.SI.Power lossPower "Nonnegative damping dissipation";
protected
  Modelica.Units.SI.Length over "Penetration beyond the upper stop";
  Modelica.Units.SI.Length under "Penetration beyond the enabled lower stop";
initial equation
  assert(lower<upper and k>=0 and d>=0 and blend>0,"Invalid travel stop geometry.");
equation
  position=flange_b.s-flange_a.s;
  speed=der(position);
  over=max(0,position-upper);
  under=if twoSided then max(0,lower-position) else 0;
  contactForce=k*(over-under)+d*(over/(blend+over)*max(0,speed)-under/(blend+under)*max(0,-speed));
  flange_b.f=contactForce;
  flange_a.f=-contactForce;
  lossPower=d*(over/(blend+over)*max(0,speed)^2+under/(blend+under)*max(0,-speed)^2);
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-50,0}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{50,0},{100,0}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-50,-36},{-50,36},{-27,36}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-50,-36},{-27,-36}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{50,-36},{50,36},{27,36}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{50,-36},{27,-36}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Rectangle(extent={{-16,-23},{16,23}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{16,0},{23,0},{27,11},{33,-11},{39,11},{44,0},{50,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-27,53},{27,53}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Use <code>position=flange_b.s-flange_a.s</code> as relative travel. Above upper, a finite spring resists further separation; below lower, a second stop acts when twoSided=true. With twoSided=false, only the upper stop is present.</p><p>Damping acts only while penetration increases, with a smooth penetration multiplier set by <code>blend</code>. <code>contactForce</code> is the force entering flange_b; lossPower reports damping dissipation. Finite stiffness permits penetration and stores elastic energy, so this is not an ideal position constraint.</p></html>"));
end TravelStop;
