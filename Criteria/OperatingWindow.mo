within ProtectionLibrary.Criteria;
block OperatingWindow "Mode-qualified request with an independent emergency path"
parameter Integer modeId=1 "Operating mode in which the local request applies";
    Modelica.Blocks.Interfaces.BooleanInput localRequest  "Request qualified by mode and enable" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput enabled  "Enable the local operating criterion" annotation(Placement(transformation(origin={-100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerInput mode  "Current integer operating-mode code" annotation(Placement(transformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency  "Request that bypasses mode and enable qualification" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput applicable  "True when enabled in the selected mode" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Emergency or qualified local protection request" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
equation
  applicable=enabled and mode==modeId;
  request=emergency or (applicable and localRequest);
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-45,-20},{0,28}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-38,23},{-7,-13}}, textString="&", textColor={64,64,64}, fontSize=0),
        Line(points={{-68,15},{-45,15}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-68,-7},{-45,-7}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{26,-19},{66,21}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{29,17},{63,-14}}, textString=">=1", textColor={64,64,64}, fontSize=0),
        Line(points={{0,4},{26,4}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-62,58},{46,58},{46,21}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{66,1},{76,1}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Set <code>applicable</code> when enabled and the integer mode equals <code>modeId</code>. A local request is passed only while applicable; an emergency request is passed regardless of mode or enable.</p><p>The block is combinational and has no latch or timing delay.</p></html>"));
end OperatingWindow;
