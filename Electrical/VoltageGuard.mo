within ProtectionLibrary.Electrical;
block VoltageGuard "Independent hysteretic under- and overvoltage requests"
  parameter Modelica.Units.SI.Voltage lowTrip = 18 "Voltage at or below which undervoltage is set";
  parameter Modelica.Units.SI.Voltage lowClear = 20 "Voltage at or above which undervoltage clears";
  parameter Modelica.Units.SI.Voltage highClear = 27 "Voltage at or below which overvoltage clears";
  parameter Modelica.Units.SI.Voltage highTrip = 30 "Voltage at or above which overvoltage is set";
  Modelica.Blocks.Interfaces.RealInput voltage(unit="V") "Voltage measure used by both criteria" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "Combined under- or overvoltage request" annotation(Placement(transformation(extent={{94,42},{106,54}}), iconTransformation(extent={{94,42},{106,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput undervoltage "Hysteretic undervoltage request" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput overvoltage "Hysteretic overvoltage request" annotation(Placement(transformation(extent={{94,-54},{106,-42}}), iconTransformation(extent={{94,-54},{106,-42}})));
protected
  ProtectionLibrary.Criteria.HighLimit low(tripLevel=-lowTrip,resetLevel=-lowClear) "High-limit criterion applied to the negative voltage";
  ProtectionLibrary.Criteria.HighLimit high(tripLevel=highTrip,resetLevel=highClear) "High-limit criterion applied to the voltage";
initial equation
  assert(lowTrip < lowClear and lowClear <= highClear and highClear < highTrip, "Voltage thresholds must be ordered.");
equation
  low.u = -voltage;
  high.u = voltage;
  undervoltage = low.request;
  overvoltage = high.request;
  request = undervoltage or overvoltage;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-61,34},{63,34}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-61,-18},{63,-18}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-60,3},{-38,7},{-18,44},{3,6},{27,1},{42,-31},{60,6}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Text(extent={{20,70},{63,46}}, textString="U", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="VoltageGuard")}),
    Documentation(info="<html><p>Set undervoltage at or below <code>lowTrip</code> and clear it at or above <code>lowClear</code>. Set overvoltage at or above <code>highTrip</code> and clear it at or below <code>highClear</code>. At initialisation, each criterion is clear unless its trip condition is already met.</p><p><code>request</code> is the logical OR of the two criteria. Their finite-input checks use the embedded fail-safe defaults. Supply a suitable voltage measure, such as a DC value or externally calculated RMS value, and connect the request to the required control logic.</p></html>"));
end VoltageGuard;
