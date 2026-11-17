within ProtectionLibrary.Electrical;
model SourceTransfer "Break-before-make transfer between two electrical feeds"
  parameter Modelica.Units.SI.Time deadTime(min=Modelica.Constants.small) = 0.05 "Interval with both contacts open after initialisation or a selection change";
  parameter Modelica.Units.SI.Resistance contactResistance(min=Modelica.Constants.small) = 0.01 "Positive resistance of either closed contact";
  Modelica.Blocks.Interfaces.BooleanInput selectBackup "Select the backup feed after the open interval" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin primary "Primary-feed connection" annotation(Placement(transformation(extent={{-107,37},{-93,51}}), iconTransformation(extent={{-107,37},{-93,51}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin backup "Backup-feed connection" annotation(Placement(transformation(extent={{-107,-51},{-93,-37}}), iconTransformation(extent={{-107,-51},{-93,-37}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin load "Supplied load connection" annotation(Placement(transformation(extent={{93,-7},{107,7}}), iconTransformation(extent={{93,-7},{107,7}})));
  Modelica.Blocks.Interfaces.BooleanOutput primaryClosed "True when the primary contact is closed" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput backupClosed "True when the backup contact is closed" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch mainContact(Ron=contactResistance,Goff=0) "Primary-feed contact";
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch backupContact(Ron=contactResistance,Goff=0) "Backup-feed contact";
  discrete Modelica.Units.SI.Time lastChange "Most recent selection-change or initialisation time";
  Boolean transferComplete "True after the open interval has elapsed";
initial equation
  assert(deadTime > 0 and contactResistance > 0, "Dead time and contact resistance must be positive.");
equation
  when {initial(), selectBackup, not selectBackup} then
    lastChange = time;
  end when;
  transferComplete = time >= lastChange+deadTime;
  primaryClosed = transferComplete and not selectBackup;
  backupClosed = transferComplete and selectBackup;
  mainContact.control = not primaryClosed;
  backupContact.control = not backupClosed;
  connect(primary, mainContact.p);
  connect(backup, backupContact.p);
  connect(mainContact.n, load);
  connect(backupContact.n, load);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,44},{-34,44}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-100,-44},{-34,-44}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-38,40},{-30,48}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-38,-48},{-30,-40}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{28,-4},{36,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{32,0},{100,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{32,0},{-27,35}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{32,0},{-27,-35}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Text(extent={{17,-41},{67,-68}}, textString="dt", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="SourceTransfer")}),
    Documentation(info="<html><p>Keep both contacts open for <code>deadTime</code> at initialisation and after each change of <code>selectBackup</code>. A further change restarts this interval. Afterwards, close only the selected feed through <code>contactResistance</code>.</p><p>Connect primary and backup to their respective feeds and load to the supplied node. The open contacts have zero conductance. The external circuit must remain well posed during the open interval and provide any required path for inductive current. Source synchronisation and arc dynamics are not represented.</p></html>"));
end SourceTransfer;
