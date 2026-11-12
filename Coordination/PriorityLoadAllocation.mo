within ProtectionLibrary.Coordination;
block PriorityLoadAllocation "按给定顺序分配有限可用功率"
  parameter Integer n(min=1) = 3 "Channels in descending priority";
  Modelica.Blocks.Interfaces.RealInput demand[n](each unit="W") "Requested nonnegative loads" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.RealInput budget(unit="W") "Available nonnegative power" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput allocated[n](each unit="W") "Load commands" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.RealOutput remaining(unit="W") "Unallocated power" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Real left[n+1](each unit="W");
equation
  left[1] = max(0,budget);
  for i in 1:n loop
    allocated[i] = min(left[i],max(0,demand[i]));
    left[i+1] = left[i]-allocated[i];
  end for;
  remaining = left[n+1];
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-62,-43},{-62,51}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-62,43},{-38,43}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-79,77},{-40,54}}, textString="P", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-30,29},{58,49}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-28,48},{-9,30}}, textString="1", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-30,-8},{33,12}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-28,11},{-9,-7}}, textString="2", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-30,-45},{6,-25}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-28,-26},{-9,-44}}, textString="3", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p><b>Purpose</b> 按给定顺序分配有限可用功率</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput demand[n](each unit=\"W\") \"Requested nonnegative loads\"; Modelica.Blocks.Interfaces.RealInput budget(unit=\"W\") \"Available nonnegative power\"; Modelica.Blocks.Interfaces.RealOutput allocated[n](each unit=\"W\") \"Load commands\"; Modelica.Blocks.Interfaces.RealOutput remaining(unit=\"W\") \"Unallocated power\"</p><p><b>Parameters</b> parameter Integer n(min=1) = 3 \"Channels in descending priority\"</p><p><b>Behavior</b> 按给定顺序分配有限可用功率</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>按给定顺序分配有限可用功率</p>
<p><b>行为</b> 优先级由索引从小到大确定，容许部分供给。负需求或负预算按零处理。</p>
<p><b>最小用法</b> 将可用功率及各负载需求连接到输入，allocated 接负载控制。</p>
<p><b>适用边界</b> 输出是命令，实际负载和供电裕量仍由执行反馈判断。</p>
<p>参数的类型、默认值和取值见下列声明。</p>
<ul>
<li><code>Integer n(min=1) = 3 \"Channels in descending priority\"</code></li>
</ul>
<p>接口及方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput demand[n](each unit=\"W\") \"Requested nonnegative loads\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealInput budget(unit=\"W\") \"Available nonnegative power\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput allocated[n](each unit=\"W\") \"Load commands\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput remaining(unit=\"W\") \"Unallocated power\"</code></li>
</ul>
<p><a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ElectricalOvercurrentProtection</a> 提供同域宿主参考。</p>
</html>"));
end PriorityLoadAllocation;
