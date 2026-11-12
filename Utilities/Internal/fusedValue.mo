within ProtectionLibrary.Utilities.Internal;
function fusedValue "对同单位向量计算中位数、均值、截尾或加权均值"
  input Real x[:];
  input ProtectionLibrary.Utilities.Types.FusionMethod method;
  input Integer trimEachSide;
  input Real weights[size(x,1)];
  output Real y;
protected
  Integer n = size(x,1);
  Integer middle;
  Real sorted[size(x,1)];
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
    Documentation(info="<html>
<p>对同单位向量计算中位数、均值、截尾或加权均值</p>
<p><b>行为</b> 对同单位向量计算中位数、均值、截尾或加权均值。</p>
<p><b>最小用法</b> 由本库组件按源码中的参数和接口装配。</p>
<p><b>适用边界</b> 实现细节随本库版本演进。</p>
<p>接口及方向</p>
<ul>
<li><code>input Real x[:]</code></li>
<li><code>input ProtectionLibrary.Utilities.Types.FusionMethod method</code></li>
<li><code>input Integer trimEachSide</code></li>
<li><code>input Real weights[size(x,1)]</code></li>
<li><code>output Real y</code></li>
</ul>
</html>"));
end fusedValue;
