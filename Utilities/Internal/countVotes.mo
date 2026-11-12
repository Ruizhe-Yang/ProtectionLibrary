within ProtectionLibrary.Utilities.Internal;
function countVotes "在当前有效通道中分别计数"
  input Boolean channel[:];
  input Boolean valid[size(channel,1)];
  output Integer available;
  output Integer votes;
algorithm
  available := 0;
  votes := 0;
  for i in 1:size(channel,1) loop
    if valid[i] then
      available := available + 1;
      votes := votes + (if channel[i] then 1 else 0);
    end if;
  end for;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(extent={{-88,-88},{88,88}}, lineColor={108,88,49}, fillColor={255,215,136}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-18,79},{18,47}}, textString="f", textColor={108,88,49}, fontSize=0),
        Rectangle(extent={{-45.88,10.72},{-34.04,22.56}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-45.88,-12.22},{-34.04,-0.38}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-45.88,-35.16},{-34.04,-23.32}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-34.04,16.64},{-11.1,6.28}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-34.04,-6.3},{-11.1,-6.3}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-34.04,-29.24},{-11.1,-18.88}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-7.4,14.42},{31.82,-21.84}}, textString="sum", textColor={64,64,64}, fontSize=0),
        Line(points={{31.82,3.32},{49.58,3.32}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{31.82,-15.92},{49.58,-15.92}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-48.1,-47},{48.1,-65.5}}, textString="count", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>在当前有效通道中分别计数</p>
<p><b>行为</b> 在当前有效通道中分别计数。</p>
<p><b>最小用法</b> 由本库组件按源码中的参数和接口装配。</p>
<p><b>适用边界</b> 实现细节随本库版本演进。</p>
<p>接口及方向</p>
<ul>
<li><code>input Boolean channel[:]</code></li>
<li><code>input Boolean valid[size(channel,1)]</code></li>
<li><code>output Integer available</code></li>
<li><code>output Integer votes</code></li>
</ul>
</html>"));
end countVotes;
