within ProtectionLibrary.Coordination;
block PrioritySelector "Select emergency, protection, degraded or normal command by fixed priority"
Modelica.Blocks.Interfaces.RealInput normalValue annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput degradedValue annotation(Placement(transformation(origin={-100,46.66667},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,46.66667},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput protectionValue annotation(Placement(transformation(origin={-100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput emergencyValue annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput degraded annotation(Placement(transformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protection annotation(Placement(transformation(origin={-100,-46.66667},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-46.66667},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput selectedSource annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
equation
  selectedSource=if emergency then 4 elseif protection then 3 elseif degraded then 2 else 1;
  y=if emergency then emergencyValue elseif protection then protectionValue elseif degraded then degradedValue else normalValue;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-68,63},{-45,39}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,51},{-9,51},{27,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-68,29},{-45,5}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,17},{-9,17},{27,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-68,-5},{-45,-29}}, textString="3", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,-17},{-9,-17},{27,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-68,-39},{-45,-63}}, textString="4", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,-51},{-9,-51},{27,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{27,0},{67,0}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Select emergency, protection, degraded or normal command by fixed priority.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput normalValue; Modelica.Blocks.Interfaces.RealInput degradedValue; Modelica.Blocks.Interfaces.RealInput protectionValue; Modelica.Blocks.Interfaces.RealInput emergencyValue; Modelica.Blocks.Interfaces.BooleanInput degraded; Modelica.Blocks.Interfaces.BooleanInput protection; Modelica.Blocks.Interfaces.BooleanInput emergency; Modelica.Blocks.Interfaces.RealOutput y; Modelica.Blocks.Interfaces.IntegerOutput selectedSource</p><p><b>Parameters</b> No tuning parameters; use the declared input contract.</p><p><b>Behavior</b> Select emergency, protection, degraded or normal command by fixed priority</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> y, selectedSource</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end PrioritySelector;
