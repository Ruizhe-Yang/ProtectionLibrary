within ProtectionLibrary.Coordination;
block DegradedMode "Capability-based degraded and safe-state selection"
Modelica.Blocks.Interfaces.BooleanInput fullCapability  "Full operating capability is available" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput minimumCapability  "Minimum capability for degraded operation is available" annotation(Placement(transformation(origin={-100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protect  "Request the Safe state" annotation(Placement(transformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput restoreAllowed  "Permit return to Normal when full capability is available" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput mode  "Integer representation of the selected DegradedState" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  output ProtectionLibrary.Utilities.Types.DegradedState state(start=ProtectionLibrary.Utilities.Types.DegradedState.Normal,fixed=true) "Selected Normal, Degraded or Safe state";
protected
  Boolean safe "Safe-state condition";
  Boolean degraded "Full capability is unavailable";
  Boolean canRestore "All conditions for return to Normal are satisfied";
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
    Documentation(info="<html><p>Select Safe whenever protection is requested or minimum capability is unavailable. With minimum capability available but full capability absent, select Degraded. Normal is restored only when both capabilities and restoreAllowed are true and protection is clear.</p><p>Otherwise retain the previous state. Restoration from Safe to Degraded does not require restoreAllowed; that input qualifies return to Normal. <code>mode</code> is the integer representation of the declared DegradedState enumeration.</p></html>"));
end DegradedMode;
