within ProtectionLibrary.Electrical;
block CurrentLimiter "Symmetric saturation of a current command"
parameter Modelica.Units.SI.Current Imax(min=0)=2 "Maximum absolute current command";
  Modelica.Blocks.Interfaces.RealInput u(unit="A")  "Requested current" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="A")  "Limited current command" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput limited  "True when the output differs from the requested current" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
initial equation
  assert(Imax>=0,"Invalid command limits.");
equation
  y=min(Imax,max(-Imax,u));
  limited=y<u or y>u;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-61,-19},{-28,-19},{27,33},{62,33}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-28,-40},{-28,49}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Line(points={{27,-40},{27,49}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Text(extent={{-6,74},{52,48}}, textString="I", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Limit <code>u</code> to the interval [-Imax,Imax]. The output <code>limited</code> is true whenever the limited command differs from the input, including either sign of saturation.</p><p>Connect the output to a current-command input. This signal block contains no electrical pins and does not constrain the current in a physical circuit directly.</p></html>"));
end CurrentLimiter;
