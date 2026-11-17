within ProtectionLibrary.Utilities.Types;
type FusionMethod = enumeration(Median "Median, averaging the middle pair for an even count", Mean "Arithmetic mean", Trimmed "Mean after symmetric trimming", Weighted "Mean normalised by the total weight") "Algorithms for complete-vector fusion"
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="FUSE", textColor={255,255,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Select Median, Mean, Trimmed or Weighted for the internal fusedValue function. This is a distinct type from AnalogMethod and does not imply channel qualification or fallback.</p></html>"));
