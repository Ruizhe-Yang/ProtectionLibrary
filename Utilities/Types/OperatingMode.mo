within ProtectionLibrary.Utilities.Types;
type OperatingMode = enumeration(Nominal "Nominal operation requested", Reduced "Reduced operation requested", Safe "Safe operation requested") "Requested operating modes for protection arbitration"
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="MODE", textColor={255,255,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Name Nominal, Reduced and Safe operating requests. The receiving model interprets these requests; the enumeration does not demonstrate achieved plant operation.</p></html>"));
