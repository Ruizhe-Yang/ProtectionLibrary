within ProtectionLibrary.Criteria;
block SequencePermissive "Armed sequence with a timed proof requirement"
  parameter Modelica.Units.SI.Time proofDeadline(min=0) = 1 "Maximum interval from arm activation to an accepted proof";
  Modelica.Blocks.Interfaces.BooleanInput arm "Arm the sequence and establish its deadline" annotation(Placement(transformation(extent={{-106,42},{-94,54}}), iconTransformation(extent={{-106,42},{-94,54}})));
  Modelica.Blocks.Interfaces.BooleanInput prerequisite "Required condition for accepting and retaining permission" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanInput proof "New rising confirmation event" annotation(Placement(transformation(extent={{-106,-54},{-94,-42}}), iconTransformation(extent={{-106,-54},{-94,-42}})));
  Modelica.Blocks.Interfaces.BooleanOutput permit(start=false,fixed=true) "Accepted proof retained while arm and prerequisite remain true" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput timedOut "Armed without permission strictly after the deadline" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  discrete Modelica.Units.SI.Time armedAt(start=0,fixed=true) "Time of initialisation or the latest arm rising edge";
initial equation
  assert(proofDeadline >= 0, "Deadline cannot be negative.");
equation
  when {initial(),arm} then
    armedAt = time;
  end when;
  when initial() then
    permit = false;
  elsewhen not (arm and prerequisite) then
    permit = false;
  elsewhen proof then
    permit = arm and prerequisite and time <= armedAt+proofDeadline;
  end when;
  timedOut = arm and not permit and time > armedAt+proofDeadline;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-65,10},{-30,49}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-62,47},{-33,13}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-28,29},{4,29}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{8,10},{43,49}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{11,47},{40,13}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{22.25,-25},{32.7,-36},{53.05,-9.6}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Line(points={{-61,-23},{-8,-23}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-49,-32},{-18,-55}}, textString="t", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p>A rising arm starts the proof deadline. A new rising <code>proof</code> sets permit only while arm and prerequisite are true and the deadline has not been exceeded. Proof exactly at the deadline is accepted. Initialisation always starts with permit false, so an initially high proof is not accepted.</p><p>Permit is retained after an accepted proof until arm or prerequisite becomes false. Restoring prerequisite alone does not restore permission or restart the deadline. <code>timedOut</code> is true strictly after the deadline while armed without permit.</p></html>"));
end SequencePermissive;
