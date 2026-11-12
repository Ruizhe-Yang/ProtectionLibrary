within ProtectionLibrary.Mechanics;
model TravelStop "Limit relative travel through finite compressive contact"
parameter Modelica.Units.SI.Length lower=-0.1;
  parameter Modelica.Units.SI.Length upper=0.1;
  parameter Boolean twoSided=true;
  parameter Real k(unit="N/m",min=0)=1000;
  parameter Real d(unit="N.s/m",min=0)=5;
  parameter Modelica.Units.SI.Length blend(min=0)=0.001;
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.Length position;
  Modelica.Units.SI.Velocity speed;
  Modelica.Units.SI.Force contactForce;
  Modelica.Units.SI.Power lossPower;
protected
  Modelica.Units.SI.Length over;
  Modelica.Units.SI.Length under;
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
    Documentation(info="<html><p><b>Purpose</b> Limit relative travel through finite compressive contact.</p><p><b>Interfaces</b> Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a; Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b</p><p><b>Parameters</b> parameter Modelica.Units.SI.Length lower=-0.1; parameter Modelica.Units.SI.Length upper=0.1; parameter Boolean twoSided=true; parameter Real k(unit=\"N/m\",min=0)=1000; parameter Real d(unit=\"N.s/m\",min=0)=5; parameter Modelica.Units.SI.Length blend(min=0)=0.001</p><p><b>Behavior</b> Limit relative travel through finite compressive contact</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Contact resists compression outside the travel range. The force law is a finite compliance, not an ideal position constraint.</p><p><b>Observables</b> Public outputs and the stated input conditions.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.MechanicalBraking\">ProtectionLibrary.Examples.MechanicalBraking</a></p></html>"));
end TravelStop;
