within ProtectionLibrary.Coordination;
block ExclusiveEnable "互斥设备请求的冲突抑制"
  parameter Integer n(min=2) = 2 "Mutually exclusive destinations";
  Modelica.Blocks.Interfaces.BooleanInput requested[n] "Enable requests" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput permitted[n] "Destination permissives" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanOutput enabled[n] "At most one destination is enabled" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput conflict "Several permitted requests coincide" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Integer accepted;
equation
  accepted = sum({if requested[i] and permitted[i] then 1 else 0 for i in 1:n});
  conflict = accepted > 1;
  for i in 1:n loop
    enabled[i] = accepted == 1 and requested[i] and permitted[i];
  end for;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-63,34},{-22,34},{23,7},{63,7}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-63,-34},{-22,-34},{23,-7},{63,-7}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Rectangle(extent={{-12,-21},{12,21}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-9,17},{9,-15}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-9,46},{9,46}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{0,35},{0,57}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p><b>Purpose</b> 互斥设备请求的冲突抑制</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput requested[n] \"Enable requests\"; Modelica.Blocks.Interfaces.BooleanInput permitted[n] \"Destination permissives\"; Modelica.Blocks.Interfaces.BooleanOutput enabled[n] \"At most one destination is enabled\"; Modelica.Blocks.Interfaces.BooleanOutput conflict \"Several permitted requests coincide\"</p><p><b>Parameters</b> parameter Integer n(min=2) = 2 \"Mutually exclusive destinations\"</p><p><b>Behavior</b> 互斥设备请求的冲突抑制</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>互斥设备请求的冲突抑制</p>
<p><b>行为</b> 恰好一个允许的请求才能通过。同刻冲突时全部抑制，冲突解除后立即重算。</p>
<p><b>最小用法</b> 将 enabled 接互斥执行链，并单独检查执行器反馈。</p>
<p><b>适用边界</b> 此块不提供机械联锁或先断后合时延。</p>
<p>参数的类型、默认值和取值见下列声明。</p>
<ul>
<li><code>Integer n(min=2) = 2 \"Mutually exclusive destinations\"</code></li>
</ul>
<p>接口及方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput requested[n] \"Enable requests\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput permitted[n] \"Destination permissives\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput enabled[n] \"At most one destination is enabled\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput conflict \"Several permitted requests coincide\"</code></li>
</ul>
<p><a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 提供同域宿主参考。</p>
</html>"));
end ExclusiveEnable;
