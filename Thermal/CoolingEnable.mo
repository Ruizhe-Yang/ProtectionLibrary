within ProtectionLibrary.Thermal;
model CoolingEnable "Temperature-dependent extraction of bounded heat flow"
  parameter Modelica.Units.SI.Temperature coolingStart(min=0) = 303.15 "Temperature at or below which extraction is zero";
  parameter Modelica.Units.SI.Temperature coolingFull(min=0) = 323.15 "Temperature at or above which extraction reaches maxCooling";
  parameter Modelica.Units.SI.Power maxCooling(min=0) = 100 "Maximum nonnegative heat-extraction rate";
  Modelica.Blocks.Interfaces.BooleanInput request "Enable temperature-dependent heat extraction" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port "Thermal node from which heat is extracted" annotation(Placement(transformation(extent={{-7,-107},{7,-93}}), iconTransformation(extent={{-7,-107},{7,-93}})));
  Modelica.Blocks.Interfaces.RealOutput extractedHeat(unit="W") "Nonnegative heat-removal rate" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow sink "Ideal prescribed heat-flow source used for extraction";
initial equation
  assert(coolingStart > 0 and coolingFull > coolingStart and maxCooling >= 0, "Invalid cooling limits.");
equation
  extractedHeat = if request then maxCooling*min(1,max(0,(port.T-coolingStart)/(coolingFull-coolingStart))) else 0;
  sink.Q_flow = -extractedHeat;
  connect(sink.port, port);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-46,8},{46,18}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-34,18},{-34,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-11,18},{-11,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{11,18},{11,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{34,18},{34,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{0,-100},{0,-51}}, color={191,0,0}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-18,-47},{-18,-3}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{18,-47},{18,-3}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="CoolingEnable")}),
    Documentation(info="<html><p>While request=true, extract heat from port with power increasing linearly from zero at <code>coolingStart</code> to <code>maxCooling</code> at <code>coolingFull</code>. Below and above that interval, the power is held at the respective bound. With request=false, extraction is zero.</p><p><code>extractedHeat</code> is the nonnegative heat-removal rate imposed by an ideal prescribed heat-flow source. The model has no coolant circuit, refrigeration power consumption or actuator dynamics.</p></html>"));
end CoolingEnable;
