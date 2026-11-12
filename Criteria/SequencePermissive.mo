within ProtectionLibrary.Criteria;
block SequencePermissive "对启动证明设置顺序与截止时间"
  parameter Modelica.Units.SI.Time proofDeadline(min=0) = 1 "Arm-to-proof deadline in seconds";
  Modelica.Blocks.Interfaces.BooleanInput arm "Sequence armed" annotation(Placement(transformation(extent={{-106,42},{-94,54}}), iconTransformation(extent={{-106,42},{-94,54}})));
  Modelica.Blocks.Interfaces.BooleanInput prerequisite "External precondition proven" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanInput proof "A new confirmation edge" annotation(Placement(transformation(extent={{-106,-54},{-94,-42}}), iconTransformation(extent={{-106,-54},{-94,-42}})));
  Modelica.Blocks.Interfaces.BooleanOutput permit(start=false,fixed=true) "Proof accepted this sequence" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput timedOut "No accepted proof by the deadline" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  discrete Modelica.Units.SI.Time armedAt(start=0,fixed=true);
initial equation
  assert(proofDeadline >= 0, "Deadline cannot be negative.");
equation
  when {initial(),arm} then
    armedAt = time;
  end when;
  when initial() then
    permit = false;
  elsewhen not (arm and prerequisite) then
    permit = false;
  elsewhen proof then
    permit = arm and prerequisite and time <= armedAt+proofDeadline;
  end when;
  timedOut = arm and not permit and time > armedAt+proofDeadline;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-65,10},{-30,49}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-62,47},{-33,13}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-28,29},{4,29}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{8,10},{43,49}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{11,47},{40,13}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{22.25,-25},{32.7,-36},{53.05,-9.6}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Line(points={{-61,-23},{-8,-23}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-49,-32},{-18,-55}}, textString="t", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p><b>Purpose</b> 对启动证明设置顺序与截止时间</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput arm \"Sequence armed\"; Modelica.Blocks.Interfaces.BooleanInput prerequisite \"External precondition proven\"; Modelica.Blocks.Interfaces.BooleanInput proof \"A new confirmation edge\"; Modelica.Blocks.Interfaces.BooleanOutput permit(start=false,fixed=true) \"Proof accepted this sequence\"; Modelica.Blocks.Interfaces.BooleanOutput timedOut \"No accepted proof by the deadline\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time proofDeadline(min=0) = 1 \"Arm-to-proof deadline in seconds\"</p><p><b>Behavior</b> 对启动证明设置顺序与截止时间</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p>
<p>对启动证明设置顺序与截止时间</p>
<p><b>行为</b> 收到布防后计时。前置条件有效且出现新的证明沿才放行。撤销布防或前置条件清除许可。</p>
<p><b>最小用法</b> 启动证明、点火许可或启动反馈分别接三个布尔输入。permit 接后续命令管理。</p>
<p><b>适用边界</b> 用于通用顺序协调。初始化高电平的 proof 不视为新证明。</p>
<p>参数的类型、默认值和取值见下列声明。</p>
<ul>
<li><code>Modelica.Units.SI.Time proofDeadline(min=0) = 1 \"Arm-to-proof deadline in seconds\"</code></li>
</ul>
<p>接口及方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput arm \"Sequence armed\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput prerequisite \"External precondition proven\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput proof \"A new confirmation edge\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput permit(start=false,fixed=true) \"Proof accepted this sequence\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput timedOut \"No accepted proof by the deadline\"</code></li>
</ul>
<p><a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 提供同域宿主参考。</p>
</html>"));
end SequencePermissive;
