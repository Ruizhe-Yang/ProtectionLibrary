within ProtectionLibrary.Mechanics;
block TravelGuard "Directional speed reduction near travel bounds"
  parameter Modelica.Units.SI.Position minimumPosition = 0 "Lower travel bound";
  parameter Modelica.Units.SI.Position maximumPosition = 1 "Upper travel bound";
  parameter Modelica.Units.SI.Length buffer(min=Modelica.Constants.small) = 0.1 "Width of each linear command-reduction zone";
  Modelica.Blocks.Interfaces.RealInput position(unit="m") "Measured translational position" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.RealInput requestedSpeed(unit="m/s") "Signed translational-speed command" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput speedCommand(unit="m/s") "Command scaled for the approached travel bound" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  Real fraction "Normalised distance to the bound selected by command direction";
initial equation
  assert(maximumPosition > minimumPosition and buffer > 0 and 2*buffer <= maximumPosition-minimumPosition, "Invalid travel bounds.");
equation
  fraction = if requestedSpeed >= 0 then (maximumPosition-position)/buffer else (position-minimumPosition)/buffer;
  speedCommand = requestedSpeed*min(1,max(0,fraction));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,-28},{66,-28}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-62,-34},{-62,45}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{62,-34},{62,45}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Rectangle(extent={{-23,-19},{21,17}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-19,-27},{-9,-17}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{8,-27},{18,-17}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{4,35},{42,35}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{39,-24},{39,49}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{-39,-24},{-39,49}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="TravelGuard")}),
    Documentation(info="<html><p>Scale requestedSpeed by the remaining distance towards its selected travel bound divided by <code>buffer</code>, clipped to [0,1]. Positive commands use maximumPosition; negative commands use minimumPosition. Within the buffer, the command falls linearly to zero at the approached bound.</p><p>A command pointing back into the travel range is retained unless it approaches the opposite bound. Connect the actual position and use speedCommand in the motion controller. The block neither constrains position nor accounts for stopping distance.</p></html>"));
end TravelGuard;
