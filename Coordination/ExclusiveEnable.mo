within ProtectionLibrary.Coordination;
block ExclusiveEnable "Conflict suppression for mutually exclusive requests"
  parameter Integer n(min=2) = 2 "Number of mutually exclusive destinations";
  Modelica.Blocks.Interfaces.BooleanInput requested[n] "Enable requests for individual destinations" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput permitted[n] "Individual destination permissives" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanOutput enabled[n] "The sole permitted request, or all false on conflict" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput conflict "More than one permitted request is present" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Integer accepted "Number of currently permitted requests";
equation
  accepted = sum({if requested[i] and permitted[i] then 1 else 0 for i in 1:n});
  conflict = accepted > 1;
  for i in 1:n loop
    enabled[i] = accepted == 1 and requested[i] and permitted[i];
  end for;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-63,34},{-22,34},{23,7},{63,7}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-63,-34},{-22,-34},{23,-7},{63,-7}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Rectangle(extent={{-12,-21},{12,21}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-9,17},{9,-15}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-9,46},{9,46}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{0,35},{0,57}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p>Count requests whose corresponding permissive is true. Enable a destination only when exactly one such request exists. With several permitted requests, set conflict and disable every destination.</p><p>The block resolves conflicts by inhibition, without assigning channel priority or retaining a selection.</p></html>"));
end ExclusiveEnable;
