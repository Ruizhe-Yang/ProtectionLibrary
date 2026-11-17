within ProtectionLibrary.Thermal;
block OverTemperatureGuard "Hysteretic temperature limit with an armed rate criterion"
  parameter Modelica.Units.SI.Temperature tripTemperature(min=0) = 333.15 "Temperature at or above which the high-limit request is set";
  parameter Modelica.Units.SI.Temperature clearTemperature(min=0) = 323.15 "Temperature at or below which the high-limit request clears";
  parameter Modelica.Units.SI.Temperature armingTemperature(min=0) = 310.15 "Minimum temperature for the rising-rate request";
  parameter Real slopeThreshold(unit="K/s",min=0) = 2 "Minimum positive sampled rate that qualifies";
  parameter Modelica.Units.SI.Time samplePeriod(min=Modelica.Constants.small) = 0.1 "Positive interval between rate samples";
  parameter Modelica.Units.SI.Time sampleStart = 0 "First rate-sampling time";
  Modelica.Blocks.Interfaces.RealInput temperature(unit="K") "Temperature measure used by both criteria" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "Combined high-temperature or armed rising-rate request" annotation(Placement(transformation(extent={{94,42},{106,54}}), iconTransformation(extent={{94,42},{106,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput fastRise "True when temperature arms a qualifying rising-rate request" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
  Modelica.Blocks.Interfaces.RealOutput rate(unit="K/s") "Signed sampled temperature rate" annotation(Placement(transformation(extent={{94,-54},{106,-42}}), iconTransformation(extent={{94,-54},{106,-42}})));
protected
  ProtectionLibrary.Criteria.HighLimit ceiling(tripLevel=tripTemperature,resetLevel=clearTemperature) "Hysteretic high-temperature criterion";
  ProtectionLibrary.Criteria.RateOfChange trend(sense=ProtectionLibrary.Utilities.Types.RateSense.Rising,failSafe=false,threshold=slopeThreshold,samplePeriod=samplePeriod,sampleStart=sampleStart) "Sampled rising-rate criterion";
initial equation
  assert(armingTemperature > 0 and clearTemperature > 0 and armingTemperature <= tripTemperature, "Invalid thermal arming temperatures.");
equation
  ceiling.u = temperature;
  trend.u = temperature;
  rate = trend.rate;
  fastRise = temperature >= armingTemperature and trend.request;
  request = ceiling.request or fastRise;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-45,-43},{-13,-11}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{-35,-14},{-23,53}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-29,-23},{-29,39}}, color={191,0,0}, thickness=1.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-37,-35},{-21,-19}}, lineColor={191,0,0}, fillColor={191,0,0}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-15,39},{16,39}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{14,-30},{14,29},{58,29}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{21,-23},{36,-7},{45,5},{54,31}}, color={191,0,0}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="OverTemperatureGuard")}),
    Documentation(info="<html><p>Combine a hysteretic temperature request with a sampled rising-rate request. The temperature criterion sets at or above tripTemperature and clears at or below clearTemperature. The rate criterion is enabled in the combined logic only when temperature is at least armingTemperature.</p><p><code>rate</code> is a signed finite difference updated at samplePeriod, beginning at sampleStart; two samples are needed for an available estimate. <code>fastRise</code> uses rate at or above slopeThreshold and the arming condition. The rate is held between samples, so short transients can be missed.</p></html>"));
end OverTemperatureGuard;
