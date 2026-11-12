within ProtectionLibrary.Mechanics;
block TorqueLimiter "Limit a signed torque request"
parameter Modelica.Units.SI.Torque lower=-10;
  parameter Modelica.Units.SI.Torque upper=10;
  Modelica.Blocks.Interfaces.RealInput u(unit="N.m") annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="N.m") annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput limited annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
initial equation
  assert(lower<=upper,"Invalid command limits.");
equation
  y=min(upper,max(lower,u));
  limited=y<u or y>u;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-61,-19},{-28,-19},{27,33},{62,33}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-28,-40},{-28,49}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Line(points={{27,-40},{27,49}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Text(extent={{-6,74},{52,48}}, textString="tau", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Limit a signed torque request.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput u(unit=\"N.m\"); Modelica.Blocks.Interfaces.RealOutput y(unit=\"N.m\"); Modelica.Blocks.Interfaces.BooleanOutput limited</p><p><b>Parameters</b> parameter Modelica.Units.SI.Torque lower=-10; parameter Modelica.Units.SI.Torque upper=10</p><p><b>Behavior</b> Limit a signed torque request</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Limits apply to the command. Verify the actual physical action independently.</p><p><b>Observables</b> y, limited</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.MechanicalBraking\">ProtectionLibrary.Examples.MechanicalBraking</a></p></html>"));
end TorqueLimiter;
