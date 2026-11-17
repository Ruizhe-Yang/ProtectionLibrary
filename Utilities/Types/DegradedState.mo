within ProtectionLibrary.Utilities.Types;
type DegradedState = enumeration(Normal "Full requested capability", Degraded "Reduced requested capability", Safe "Requested safe state") "Declared capability states" annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="STATE", textColor={255,255,255}, fontSize=0)
      }), Documentation(info="<html><p>Name Normal, Degraded and Safe capability states used by DegradedMode. These values describe the selected state; the coordination block defines transitions and restoration.</p></html>"));
