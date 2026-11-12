within ProtectionLibrary.Coordination;
block SafeStateSelector "Map ordered requests into declared integer safe-state commands"
parameter Integer normalMode=0;
  parameter Integer protectedMode=1;
  parameter Integer emergencyMode=2;
    Modelica.Blocks.Interfaces.BooleanInput protect annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput modeRequest annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
equation
  modeRequest=if emergency then emergencyMode elseif protect then protectedMode else normalMode;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-69,61},{-45,37}}, textString="1", textColor={64,64,64}, fontSize=0),
        Text(extent={{-69,12},{-45,-12}}, textString="2", textColor={64,64,64}, fontSize=0),
        Text(extent={{-69,-37},{-45,-61}}, textString="3", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,47},{2,47},{25,8}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-39,0},{2,0},{25,8}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-39,-47},{2,-47},{25,8}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{25,8},{66,8}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-48,-61},{60,-82}}, textString="mode", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Map ordered requests into declared integer safe-state commands.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput protect; Modelica.Blocks.Interfaces.BooleanInput emergency; Modelica.Blocks.Interfaces.IntegerOutput modeRequest</p><p><b>Parameters</b> parameter Integer normalMode=0; parameter Integer protectedMode=1; parameter Integer emergencyMode=2</p><p><b>Behavior</b> Map ordered requests into declared integer safe-state commands</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> modeRequest</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end SafeStateSelector;
