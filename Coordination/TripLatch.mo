within ProtectionLibrary.Coordination;
block TripLatch "Latch trip requests and admit only a permitted reset edge"
Modelica.Blocks.Interfaces.BooleanInput trip annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput reset annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput resetAllowed annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput latched(start=false,fixed=true) annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
equation
  when {initial(),trip,reset} then
    latched=if trip then true elseif reset and (initial() or not pre(reset)) and resetAllowed then false else pre(latched);
  end when;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-40,-32},{37,45}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-32,37},{-8,12}}, textString="S", textColor={64,64,64}, fontSize=0),
        Text(extent={{-32,-6},{-8,-29}}, textString="R", textColor={64,64,64}, fontSize=0),
        Text(extent={{11,32},{33,8}}, textString="Q", textColor={64,64,64}, fontSize=0),
        Line(points={{-65,25},{-40,25}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-20},{-40,-20}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{37,22},{61,22},{61,-43},{-1,-43},{-1,-32}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Latch trip requests and admit only a permitted reset edge.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput trip; Modelica.Blocks.Interfaces.BooleanInput reset; Modelica.Blocks.Interfaces.BooleanInput resetAllowed; Modelica.Blocks.Interfaces.BooleanOutput latched(start=false,fixed=true)</p><p><b>Parameters</b> No tuning parameters; use the declared input contract.</p><p><b>Behavior</b> Trip dominates reset. A reset held high does not become a new edge when permission later returns.</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> latched</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end TripLatch;
