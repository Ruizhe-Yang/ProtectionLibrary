within ProtectionLibrary.Coordination;
block ProtectiveRamp "以有限速率接近保护命令和恢复命令"
  parameter Real safeCommand = 0 "保护目标";
  parameter Real maxRate(min=Modelica.Constants.small) = 1 "最大命令变化速率，输入单位/s";
  parameter Modelica.Units.SI.Time responseTime(min=Modelica.Constants.small) = 0.08 "目标附近时间常数，s";
  Modelica.Blocks.Interfaces.RealInput u "正常命令" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput request "保护请求" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput y "有斜率约束的命令" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  Real target;
initial equation
  assert(maxRate > 0 and responseTime > 0, "Positive ramp parameters required.");
  y = if request then safeCommand else u;
equation
  target = if request then safeCommand else u;
  der(y) = min(maxRate,max(-maxRate,(target-y)/responseTime));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-59,38},{-28,38},{-28,-28},{62,-28}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-59,38},{-28,38},{36,-28},{62,-28}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="ProtectiveRamp")}),
    Documentation(info="<html><p><b>Purpose</b> 以有限速率接近保护命令和恢复命令</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput u \"正常命令\"; Modelica.Blocks.Interfaces.BooleanInput request \"保护请求\"; Modelica.Blocks.Interfaces.RealOutput y \"有斜率约束的命令\"</p><p><b>Parameters</b> parameter Real safeCommand = 0 \"保护目标\"; parameter Real maxRate(min=Modelica.Constants.small) = 1 \"最大命令变化速率，输入单位/s\"; parameter Modelica.Units.SI.Time responseTime(min=Modelica.Constants.small) = 0.08 \"目标附近时间常数，s\"</p><p><b>Behavior</b> 以有限速率接近保护命令和恢复命令</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>以有限速率接近保护命令和恢复命令</p>
<p>专业分类为 CommandManagement.CommandRamp。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput u \"正常命令\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput request \"保护请求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput y \"有斜率约束的命令\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Real safeCommand = 0 \"保护目标\"</code></li>
<li><code>Real maxRate(min=Modelica.Constants.small) = 1 \"最大命令变化速率，输入单位/s\"</code></li>
<li><code>Modelica.Units.SI.Time responseTime(min=Modelica.Constants.small) = 0.08 \"目标附近时间常数，s\"</code></li>
</ul>
<p><b>时序与基准行为</b> 请求切换目标，y 连续。解除后也以受限速率恢复到正常命令。</p>
<p><b>最小用法</b> 接不能承受命令跃变的执行器。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 展示同域接线。</p>
<p><b>适用边界</b> 正常通路同样存在速率限制和滤波，初始化直接采用当前目标。</p>
</html>"));
end ProtectiveRamp;
