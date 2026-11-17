within ProtectionLibrary.Coordination;
block ModeFallback "Operating-mode override with safe-state priority"
  input ProtectionLibrary.Utilities.Types.OperatingMode normalMode "Nominal requested operating mode";
  Modelica.Blocks.Interfaces.BooleanInput degrade "Select Reduced mode unless Safe has priority" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput stop "Select Safe mode" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  output ProtectionLibrary.Utilities.Types.OperatingMode mode "Selected operating-mode command";
equation
  mode = if stop or normalMode == ProtectionLibrary.Utilities.Types.OperatingMode.Safe then
    ProtectionLibrary.Utilities.Types.OperatingMode.Safe
    elseif degrade then ProtectionLibrary.Utilities.Types.OperatingMode.Reduced else normalMode;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-65,21},{-29,57}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-61,53},{-33,25}}, textString="N", textColor={64,64,64}, fontSize=0),
        Line(points={{-25,38},{7,9}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{11,-6},{47,30}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{15,26},{43,-2}}, textString="R", textColor={64,64,64}, fontSize=0),
        Line(points={{27,-10},{8,-37}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-15,-73},{21,-37}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-11,-41},{17,-69}}, textString="S", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="ModeFallback")}),
    Documentation(info="<html><p>Select Safe when stop is true or normalMode is already Safe. Otherwise select Reduced while degrade is true, and pass normalMode when neither override applies.</p><p>Selection is immediate and has no latch, delay or capability assessment.</p></html>"));
end ModeFallback;
