within ProtectionLibrary.Coordination;
block BooleanOverride "Boolean command override during protection"
parameter Boolean safeValue=false "Boolean command selected while protection is requested";
    Modelica.Blocks.Interfaces.BooleanInput u  "Nominal Boolean command" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protect  "Select the protective command" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y  "Selected Boolean command" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
equation
  y=if protect then safeValue else u;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,38},{-29,38}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-18},{-29,-18}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-33,34},{-25,42}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-33,-22},{-25,-14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{30,6},{38,14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{34,10},{66,10}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-23,-14},{34,10}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-23,34},{28,13}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{4,-53},{4,-8}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-65,-50},{65,-75}}, textString="0 / 1", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Output <code>safeValue</code> while protect is true and otherwise pass the nominal command unchanged. Protection and recovery are immediate; no latch or delay is included.</p></html>"));
end BooleanOverride;
