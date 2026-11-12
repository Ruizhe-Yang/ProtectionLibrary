within ProtectionLibrary.Coordination;
block MinimumOffTime "保护切断后强制最短断开时间"
  parameter Modelica.Units.SI.Time holdOff(min=0) = 0.5 "从切断请求上升沿算起的禁止时长，s";
  Modelica.Blocks.Interfaces.BooleanInput trip "切断请求" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput runDemand "名义运行需求" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanOutput runCommand "符合保护等待时间的运行命令" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  discrete Modelica.Units.SI.Time lastTrip;
  discrete Boolean seen;
initial equation
  assert(holdOff >= 0, "Hold-off time must be nonnegative.");
equation
  when {initial(), trip} then
    lastTrip = time;
    seen = if initial() then trip else true;
  end when;
  runCommand = runDemand and not trip and (not seen or time >= lastTrip+holdOff);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,42},{-35,42},{-35,-2},{35,-2},{35,42},{65,42}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-35,-25},{35,-25}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Line(points={{-35,-32},{-35,9}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{35,-32},{35,9}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-32,-40},{32,-64}}, textString="OFF", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="MinimumOffTime")}),
    Documentation(info="<html><p><b>Purpose</b> 保护切断后强制最短断开时间</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput trip \"切断请求\"; Modelica.Blocks.Interfaces.BooleanInput runDemand \"名义运行需求\"; Modelica.Blocks.Interfaces.BooleanOutput runCommand \"符合保护等待时间的运行命令\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time holdOff(min=0) = 0.5 \"从切断请求上升沿算起的禁止时长，s\"</p><p><b>Behavior</b> 保护切断后强制最短断开时间</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>保护切断后强制最短断开时间</p>
<p>专业分类为 LatchingAndReset.ResetInhibit。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput trip \"切断请求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput runDemand \"名义运行需求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput runCommand \"符合保护等待时间的运行命令\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Time holdOff(min=0) = 0.5 \"从切断请求上升沿算起的禁止时长，s\"</code></li>
</ul>
<p><b>时序与基准行为</b> 请求存在期间保持切断。请求早于 holdOff 撤销时继续等待。首次请求前允许正常运行。</p>
<p><b>最小用法</b> 接接触器许可。若需以真实断开时刻计时，可由动作反馈触发独立保持逻辑。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 展示同域接线。</p>
<p><b>适用边界</b> 该模型以请求时刻计时，实际断开可能有执行延时。</p>
</html>"));
end MinimumOffTime;
