within ProtectionLibrary.Criteria;
block OperatingWindow "Qualify a local request by mode without suppressing the emergency path"
parameter Integer modeId=1;
    Modelica.Blocks.Interfaces.BooleanInput localRequest annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput enabled annotation(Placement(transformation(origin={-100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerInput mode annotation(Placement(transformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput applicable annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
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
    Documentation(info="<html><p><b>Purpose</b> Qualify a local request by mode without suppressing the emergency path.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput localRequest; Modelica.Blocks.Interfaces.BooleanInput enabled; Modelica.Blocks.Interfaces.IntegerInput mode; Modelica.Blocks.Interfaces.BooleanInput emergency; Modelica.Blocks.Interfaces.BooleanOutput applicable; Modelica.Blocks.Interfaces.BooleanOutput request</p><p><b>Parameters</b> parameter Integer modeId=1</p><p><b>Behavior</b> Qualify a local request by mode without suppressing the emergency path</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> applicable, request</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end OperatingWindow;
