within ProtectionLibrary.Coordination;
block ResetPermission "Permit reset only after continuous safe dwell"
parameter Modelica.Units.SI.Time clearTime(min=0)=0.2;
    Modelica.Blocks.Interfaces.BooleanInput danger annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput permissives annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput resetAllowed annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  Boolean clear;
  discrete Modelica.Units.SI.Time clearSince(start=0,fixed=true);
initial equation
  assert(clearTime>=0,"Negative clear time.");
equation
  clear=not danger and permissives;
  when {initial(),clear} then clearSince=time; end when;
  resetAllowed=clear and time>=clearSince+clearTime;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-50,-27},{24,47}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-13,39},{-13,45}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-13,10},{-13,36},{-13,10}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-13,10},{10,-3}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{23.75,-27},{34.58,-38.4},{55.67,-11.04}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Text(extent={{-61,-53},{54,-78}}, textString="safe t", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Permit reset only after continuous safe dwell.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput danger; Modelica.Blocks.Interfaces.BooleanInput permissives; Modelica.Blocks.Interfaces.BooleanOutput resetAllowed</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time clearTime(min=0)=0.2</p><p><b>Behavior</b> Permit reset only after continuous safe dwell</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> resetAllowed</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end ResetPermission;
