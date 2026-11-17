within ProtectionLibrary.Coordination;
block RedundantChannelSelect "Availability-based primary and backup command selection"
  parameter Real fallback = 0 "Command used when neither channel is valid";
  Modelica.Blocks.Interfaces.RealInput primary "Preferred command channel" annotation(Placement(transformation(extent={{-106,66},{-94,78}}), iconTransformation(extent={{-106,66},{-94,78}})));
  Modelica.Blocks.Interfaces.RealInput backup "Backup command channel" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput primaryValid "External validity of the primary channel" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanInput backupValid "External validity of the backup channel" annotation(Placement(transformation(extent={{-106,-78},{-94,-66}}), iconTransformation(extent={{-106,-78},{-94,-66}})));
  Modelica.Blocks.Interfaces.RealOutput y "Selected command" annotation(Placement(transformation(extent={{94,42},{106,54}}), iconTransformation(extent={{94,42},{106,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput usingBackup "Backup is selected because the primary is invalid" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid "At least one channel is declared valid" annotation(Placement(transformation(extent={{94,-54},{106,-42}}), iconTransformation(extent={{94,-54},{106,-42}})));
equation
  valid = primaryValid or backupValid;
  usingBackup = not primaryValid and backupValid;
  y = if primaryValid then primary elseif usingBackup then backup else fallback;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
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
        Text(extent={{-64,66},{-35,43}}, textString="1", textColor={64,64,64}, fontSize=0),
        Text(extent={{-64,-24},{-35,-52}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{2.5,-40},{10.48,-48.4},{26.02,-28.24}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="RedundantChannelSelect")}),
    Documentation(info="<html><p>Use primary whenever primaryValid is true. Otherwise use backup if backupValid is true, and fallback if neither channel is valid. Expose the backup selection and overall validity separately.</p><p>Validity is taken directly from the two input flags. The selector does not compare values, reject non-finite data or smooth transfers.</p></html>"));
end RedundantChannelSelect;
