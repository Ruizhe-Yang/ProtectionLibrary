within ProtectionLibrary.Coordination;
block TripLatch "Trip-priority latch with a qualified reset edge"
Modelica.Blocks.Interfaces.BooleanInput trip  "Set the latch with priority over reset" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput reset  "Rising request to clear the latch when permitted" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput resetAllowed  "Permission sampled when a reset edge occurs" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput latched(start=false,fixed=true)  "Retained trip state" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
equation
  when {initial(),trip,reset} then
    latched=if trip then true elseif reset and (initial() or not pre(reset)) and resetAllowed then false else pre(latched);
  end when;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-40,-32},{37,45}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-32,37},{-8,12}}, textString="S", textColor={64,64,64}, fontSize=0),
        Text(extent={{-32,-6},{-8,-29}}, textString="R", textColor={64,64,64}, fontSize=0),
        Text(extent={{11,32},{33,8}}, textString="Q", textColor={64,64,64}, fontSize=0),
        Line(points={{-65,25},{-40,25}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-20},{-40,-20}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{37,22},{61,22},{61,-43},{-1,-43},{-1,-32}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Latch every trip request. Clear only on a rising reset while resetAllowed is true and trip is false. Trip has priority when trip and reset occur together.</p><p>A reset already held true does not clear the latch merely because resetAllowed later becomes true or trip clears. Release reset and issue a new edge. Initialisation evaluates the current trip and reset inputs, with a false initial latch unless trip is active.</p></html>"));
end TripLatch;
