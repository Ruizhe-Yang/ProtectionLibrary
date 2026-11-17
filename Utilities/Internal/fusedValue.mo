within ProtectionLibrary.Utilities.Internal;
function fusedValue "Fuse a vector without qualification or fallback"
  input Real x[:] "Complete finite measurement vector in a common unit";
  input ProtectionLibrary.Utilities.Types.FusionMethod method "Fusion algorithm for the complete vector";
  input Integer trimEachSide "Number removed from each sorted end for Trimmed";
  input Real weights[size(x,1)] "Weights normalised by their total for Weighted";
  output Real y "Fused value";
protected
  Integer n = size(x,1) "Number of vector entries";
  Integer middle "Lower middle index for the median";
  Real sorted[size(x,1)] "Vector sorted in ascending order";
algorithm
  if method == ProtectionLibrary.Utilities.Types.FusionMethod.Mean then
    y := sum(x)/n;
  elseif method == ProtectionLibrary.Utilities.Types.FusionMethod.Weighted then
    y := sum({x[i]*(weights[i]/sum(weights)) for i in 1:n});
  else
    sorted := Modelica.Math.Vectors.sort(x);
    if method == ProtectionLibrary.Utilities.Types.FusionMethod.Trimmed then
      y := sum(sorted[1+trimEachSide:n-trimEachSide])/(n-2*trimEachSide);
    else
      middle := div(n+1,2);
      y := (sorted[middle]+sorted[n+1-middle])/2;
    end if;
  end if;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(extent={{-88,-88},{88,88}}, lineColor={108,88,49}, fillColor={255,215,136}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-18,79},{18,47}}, textString="f", textColor={108,88,49}, fontSize=0),
        Line(points={{-48.84,-32.2},{48.84,-32.2}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-41.44,-32.2},{-41.44,-24.8}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-44.4,-27.76},{-38.48,-21.84}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-32.2},{0,-7.78}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-2.96,-10.74},{2.96,-4.82}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{41.44,-32.2},{41.44,13.68}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{38.48,10.72},{44.4,16.64}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-48.1,-47},{48.1,-65.5}}, textString="f(x)", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p>Calculate the arithmetic mean, median, trimmed mean or normalised weighted mean of the complete vector <code>x</code>. An even median averages the two middle values. Trimming removes <code>trimEachSide</code> entries from each sorted end.</p><p>The caller must provide a nonempty finite vector, valid trimming with at least one remaining entry, and a nonzero total weight for Weighted. No qualification, parameter validation, availability output or fallback is provided.</p></html>"));
end fusedValue;
