within ProtectionLibrary.Criteria;
block WindowEnergyTrip "Positive-energy criterion over a moving time window"
  parameter Modelica.Units.SI.Time windowLength(min=Modelica.Constants.small) = 1 "Positive duration of the moving energy window";
  parameter Modelica.Units.SI.Energy energyLimit(min=0) = 100 "Inclusive positive-energy trip threshold";
  Modelica.Blocks.Interfaces.RealInput power(unit="W") "Measured power, with negative values excluded from accumulation" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.RealOutput windowEnergy(unit="J") "Positive energy accumulated inside the current window" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "Window energy has reached or exceeded the limit" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Modelica.Units.SI.Energy cumulative(start=0,fixed=true) "Positive energy accumulated since initialisation";
initial equation
  assert(windowLength > 0 and energyLimit >= 0, "Invalid energy trip parameters.");
equation
  der(cumulative) = max(0,power);
  windowEnergy = cumulative-delay(cumulative,windowLength);
  request = windowEnergy >= energyLimit;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Polygon(points={{-30,-40},{-30,16},{-9,32},{13,7},{35,29},{35,-40},{-30,-40}}, lineColor={235,235,235}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-58,-9},{-45,8},{-30,16},{-9,32},{13,7},{35,29},{59,18}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-30,-44},{-30,51}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{35,-44},{35,51}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{39,68},{70,39}}, textString="E", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="WindowEnergyTrip")}),
    Documentation(info="<html><p>Integrate <code>max(0,power)</code> and subtract the delayed cumulative value over <code>windowLength</code>. The window contains only energy accumulated since initialisation until a full window is available. Request protection when <code>windowEnergy&gt;=energyLimit</code>.</p><p>Negative power contributes zero. The request clears when window energy falls below the limit; there is no latch. Long runs can expose cancellation error when subtracting two large cumulative values.</p></html>"));
end WindowEnergyTrip;
