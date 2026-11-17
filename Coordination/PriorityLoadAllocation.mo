within ProtectionLibrary.Coordination;
block PriorityLoadAllocation "Sequential power allocation in channel-priority order"
  parameter Integer n(min=1) = 3 "Number of load channels in descending priority";
  Modelica.Blocks.Interfaces.RealInput demand[n](each unit="W") "Requested channel powers; negative values are treated as zero" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.RealInput budget(unit="W") "Available power; negative values are treated as zero" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput allocated[n](each unit="W") "Power allocated to individual channel commands" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.RealOutput remaining(unit="W") "Power remaining after all allocations" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Real left[n+1](each unit="W") "Remaining budget before each channel and after the final channel";
equation
  left[1] = max(0,budget);
  for i in 1:n loop
    allocated[i] = min(left[i],max(0,demand[i]));
    left[i+1] = left[i]-allocated[i];
  end for;
  remaining = left[n+1];
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-62,-43},{-62,51}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-62,43},{-38,43}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-79,77},{-40,54}}, textString="P", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-30,29},{58,49}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-28,48},{-9,30}}, textString="1", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-30,-8},{33,12}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-28,11},{-9,-7}}, textString="2", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-30,-45},{6,-25}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-28,-26},{-9,-44}}, textString="3", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p>Allocate available power to channels in increasing index order, so channel 1 has the highest priority. Each allocation is the smaller of its nonnegative demand and the remaining budget. Negative demands and a negative budget are treated as zero.</p><p><code>remaining</code> reports unused power. Outputs are load commands; physical power availability and delivered consumption require a receiving system model.</p></html>"));
end PriorityLoadAllocation;
