within ProtectionLibrary.Criteria;
block SequenceGuard "监测动作要求是否在截止前获得持续反馈"
  parameter Modelica.Units.SI.Time deadline(min=0) = 0.5 "请求反馈截止时间，s";
  Modelica.Blocks.Interfaces.BooleanInput commandActive "要求动作的命令" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput confirmed "由执行反馈得到的完成条件" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "到期仍缺少反馈" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  discrete Modelica.Units.SI.Time entered;
initial equation
  assert(deadline >= 0, "Action deadline must be nonnegative.");
equation
  when {initial(), commandActive} then
    entered = time;
  end when;
  request = commandActive and not confirmed and time >= entered+deadline;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,39},{-45,39},{-45,59},{48,59}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-8},{-17,-8},{-17,11},{33,11}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{48,66},{48,-33}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Dash),
        Text(extent={{35,-21},{65,-52}}, textString="?", textColor={64,64,64}, fontSize=0),
        Line(points={{-45,-30},{21,-30}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="SequenceGuard")}),
    Documentation(info="<html><p><b>Purpose</b> 监测动作要求是否在截止前获得持续反馈</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput commandActive \"要求动作的命令\"; Modelica.Blocks.Interfaces.BooleanInput confirmed \"由执行反馈得到的完成条件\"; Modelica.Blocks.Interfaces.BooleanOutput request \"到期仍缺少反馈\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time deadline(min=0) = 0.5 \"请求反馈截止时间，s\"</p><p><b>Behavior</b> 监测动作要求是否在截止前获得持续反馈</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p>
<p>监测动作要求是否在截止前获得持续反馈</p>
<p>专业分类为 ProtectionLogic.Sequence。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput commandActive \"要求动作的命令\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput confirmed \"由执行反馈得到的完成条件\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput request \"到期仍缺少反馈\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Time deadline(min=0) = 0.5 \"请求反馈截止时间，s\"</code></li>
</ul>
<p><b>时序与基准行为</b> 持续命令从入口计时。到期且当前无完成反馈即请求；反馈消失时可重新产生请求。</p>
<p><b>最小用法</b> 把 confirmed 接实际开关状态、位置或压力判据。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 展示同域接线。</p>
<p><b>适用边界</b> 持续真反馈可满足检查，反馈数据的真实性由宿主保证。</p>
</html>"));
end SequenceGuard;
