within ProtectionLibrary.Coordination;
block DegradedMode "Enter degraded or safe state according to available capability"
Modelica.Blocks.Interfaces.BooleanInput fullCapability annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput minimumCapability annotation(Placement(transformation(origin={-100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protect annotation(Placement(transformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput restoreAllowed annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput mode annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  output ProtectionLibrary.Utilities.Types.DegradedState state(start=ProtectionLibrary.Utilities.Types.DegradedState.Normal,fixed=true);
protected
  Boolean safe;
  Boolean degraded;
  Boolean canRestore;
equation
  safe=protect or not minimumCapability;
  degraded=not fullCapability;
  canRestore=fullCapability and minimumCapability and restoreAllowed and not protect;
  when {initial(),change(safe),change(degraded),canRestore} then
    state=if safe then ProtectionLibrary.Utilities.Types.DegradedState.Safe
      elseif canRestore then ProtectionLibrary.Utilities.Types.DegradedState.Normal
      elseif degraded then ProtectionLibrary.Utilities.Types.DegradedState.Degraded
      else pre(state);
  end when;
  mode=Integer(state);
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-63,18},{-28,56}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-59,50},{-32,24}}, textString="N", textColor={64,64,64}, fontSize=0),
        Line(points={{-24,36},{7,4}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{9,-12},{45,26}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{13,20},{41,-6}}, textString="D", textColor={64,64,64}, fontSize=0),
        Line(points={{26,-16},{6,-43}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-12,-77},{24,-41}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-8,-47},{20,-71}}, textString="S", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Enter degraded or safe state according to available capability.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput fullCapability; Modelica.Blocks.Interfaces.BooleanInput minimumCapability; Modelica.Blocks.Interfaces.BooleanInput protect; Modelica.Blocks.Interfaces.BooleanInput restoreAllowed; Modelica.Blocks.Interfaces.IntegerOutput mode; output ProtectionLibrary.Utilities.Types.DegradedState state(start=ProtectionLibrary.Utilities.Types.DegradedState.Normal,fixed=true)</p><p><b>Parameters</b> No tuning parameters; use the declared input contract.</p><p><b>Behavior</b> Enter degraded or safe state according to available capability</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> mode</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end DegradedMode;
