within ProtectionLibrary.Coordination;
block LossOfLinkFallback "持续失联和持续恢复分别确认后的备用命令"
  parameter Modelica.Units.SI.Time lossDwell(min=0) = 0.3 "Loss confirmation";
  parameter Modelica.Units.SI.Time recoveryDwell(min=0) = 1 "Recovery confirmation";
  parameter Real fallback = 0 "Fallback command, same units as u";
  Modelica.Blocks.Interfaces.BooleanInput linkHealthy "Link health reported by the host" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.RealInput u "Nominal command" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput y "Selected command" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput usingFallback(start=false,fixed=true) "Fallback selected" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  discrete Modelica.Units.SI.Time lastChange(start=0,fixed=true);
initial equation
  assert(lossDwell >= 0 and recoveryDwell >= 0, "Dwell times must be nonnegative.");
equation
  when {initial(),linkHealthy,not linkHealthy} then
    lastChange = time;
  end when;
  when {initial(),not linkHealthy and time >= lastChange+lossDwell,
      linkHealthy and time >= lastChange+recoveryDwell} then
    usingFallback = not linkHealthy and time >= lastChange+lossDwell;
  end when;
  y = if usingFallback then fallback else u;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,37},{-27,37}}, color={128,128,128}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-8,37},{40,37}}, color={128,128,128}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-25,26},{-10,48}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-25,48},{-10,26}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-65,-28},{-13,-28},{28,4},{65,4}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Ellipse(extent={{-17,-32},{-9,-24}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{24,0},{32,8}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{17,-22},{55,-51}}, textString="t", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p><b>Purpose</b> 持续失联和持续恢复分别确认后的备用命令</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput linkHealthy \"Link health reported by the host\"; Modelica.Blocks.Interfaces.RealInput u \"Nominal command\"; Modelica.Blocks.Interfaces.RealOutput y \"Selected command\"; Modelica.Blocks.Interfaces.BooleanOutput usingFallback(start=false,fixed=true) \"Fallback selected\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time lossDwell(min=0) = 0.3 \"Loss confirmation\"; parameter Modelica.Units.SI.Time recoveryDwell(min=0) = 1 \"Recovery confirmation\"; parameter Real fallback = 0 \"Fallback command, same units as u\"</p><p><b>Behavior</b> 持续失联和持续恢复分别确认后的备用命令</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>持续失联和持续恢复分别确认后的备用命令</p>
<p><b>行为</b> 失联持续到门限才选择备用命令。连接恢复并持续到恢复门限后才回切。</p>
<p><b>最小用法</b> linkHealthy 由外部通信或看门狗给出，y 接单一执行链。</p>
<p><b>适用边界</b> 确认时段内沿用原选择。此块无法证明受控设备已进入安全状态。</p>
<p>参数的类型、默认值和取值见下列声明。</p>
<ul>
<li><code>Modelica.Units.SI.Time lossDwell(min=0) = 0.3 \"Loss confirmation\"</code></li>
<li><code>Modelica.Units.SI.Time recoveryDwell(min=0) = 1 \"Recovery confirmation\"</code></li>
<li><code>Real fallback = 0 \"Fallback command, same units as u\"</code></li>
</ul>
<p>接口及方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput linkHealthy \"Link health reported by the host\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealInput u \"Nominal command\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput y \"Selected command\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput usingFallback(start=false,fixed=true) \"Fallback selected\"</code></li>
</ul>
<p><a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 提供同域宿主参考。</p>
</html>"));
end LossOfLinkFallback;
