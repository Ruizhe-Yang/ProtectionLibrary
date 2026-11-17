within ProtectionLibrary.Utilities.Types;
type Fallback = enumeration(Value "Use the configured constant fallback", HoldLast "Retain the fusion from before availability was lost") "Output policy for unavailable analogue fusion" annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="V / hold", textColor={255,255,255}, fontSize=0)
      }), Documentation(info="<html><p>Value selects the configured fallback constant. HoldLast uses that constant at initialisation, then retains the fusion evaluated from the previous inputs when availability is lost. A fallback value does not make the fusion available.</p></html>"));
