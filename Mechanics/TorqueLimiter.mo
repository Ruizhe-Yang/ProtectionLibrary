within ProtectionLibrary.Mechanics;
block TorqueLimiter "Saturation of a signed torque command"
parameter Modelica.Units.SI.Torque lower=-10 "Lower command bound";
  parameter Modelica.Units.SI.Torque upper=10 "Upper command bound";
  Modelica.Blocks.Interfaces.RealInput u(unit="N.m")  "Requested torque" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="N.m")  "Limited torque command" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput limited  "True when the output differs from the request" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
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
    Documentation(info="<html><p>Limit the torque request <code>u</code> to the inclusive interval [lower,upper]. The bounds may be asymmetric. <code>limited</code> is true whenever y differs from u.</p><p>Use u and y in newton metres. This is a signal limiter; it does not impose the same bound directly on a connected physical network.</p></html>"));
end TorqueLimiter;
