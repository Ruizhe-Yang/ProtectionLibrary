within ProtectionLibrary.Utilities.Types;
type AnalogMethod = enumeration(Median "Median, averaging the middle pair for an even count", Mean "Arithmetic mean", TrimmedMean "Mean after symmetric trimming", WeightedMean "Mean normalised by the eligible weight sum") "Qualified analogue fusion methods" annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="FUSE", textColor={255,255,255}, fontSize=0)
      }), Documentation(info="<html><p>Select Median, Mean, TrimmedMean or WeightedMean for Fuse and the analogue voting blocks. The selected method determines its count, trimming and weight requirements.</p></html>"));
