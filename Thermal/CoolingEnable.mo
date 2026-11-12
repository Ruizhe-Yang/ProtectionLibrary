within ProtectionLibrary.Thermal;
model CoolingEnable "请求时在实际热端抽取有限功率"
  parameter Modelica.Units.SI.Temperature coolingStart(min=0) = 303.15 "开始产生冷却功率的温度，K";
  parameter Modelica.Units.SI.Temperature coolingFull(min=0) = 323.15 "达到最大冷却功率的温度，K";
  parameter Modelica.Units.SI.Power maxCooling(min=0) = 100 "可抽取的最大热功率，W";
  Modelica.Blocks.Interfaces.BooleanInput request "允许开启冷却" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port "被冷却节点" annotation(Placement(transformation(extent={{-7,-107},{7,-93}}), iconTransformation(extent={{-7,-107},{7,-93}})));
  Modelica.Blocks.Interfaces.RealOutput extractedHeat(unit="W") "实际移除的热功率，非负" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow sink;
initial equation
  assert(coolingStart > 0 and coolingFull > coolingStart and maxCooling >= 0, "Invalid cooling limits.");
equation
  extractedHeat = if request then maxCooling*min(1,max(0,(port.T-coolingStart)/(coolingFull-coolingStart))) else 0;
  sink.Q_flow = -extractedHeat;
  connect(sink.port, port);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-46,8},{46,18}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-34,18},{-34,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-11,18},{-11,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{11,18},{11,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{34,18},{34,53}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{0,-100},{0,-51}}, color={191,0,0}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-18,-47},{-18,-3}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{18,-47},{18,-3}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="CoolingEnable")}),
    Documentation(info="<html><p><b>Purpose</b> 请求时在实际热端抽取有限功率</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput request \"允许开启冷却\"; Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port \"被冷却节点\"; Modelica.Blocks.Interfaces.RealOutput extractedHeat(unit=\"W\") \"实际移除的热功率，非负\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Temperature coolingStart(min=0) = 303.15 \"开始产生冷却功率的温度，K\"; parameter Modelica.Units.SI.Temperature coolingFull(min=0) = 323.15 \"达到最大冷却功率的温度，K\"; parameter Modelica.Units.SI.Power maxCooling(min=0) = 100 \"可抽取的最大热功率，W\"</p><p><b>Behavior</b> 请求时在实际热端抽取有限功率</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThermalCooling\">ProtectionLibrary.Examples.ThermalCooling</a></p>
<p>请求时在实际热端抽取有限功率</p>
<p>专业分类为 ThermalProtection.HeatActuation。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput request \"允许开启冷却\"</code></li>
<li><code>Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port \"被冷却节点\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput extractedHeat(unit=\"W\") \"实际移除的热功率，非负\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Temperature coolingStart(min=0) = 303.15 \"开始产生冷却功率的温度，K\"</code></li>
<li><code>Modelica.Units.SI.Temperature coolingFull(min=0) = 323.15 \"达到最大冷却功率的温度，K\"</code></li>
<li><code>Modelica.Units.SI.Power maxCooling(min=0) = 100 \"可抽取的最大热功率，W\"</code></li>
</ul>
<p><b>时序与基准行为</b> 许可时按端口温度增大冷却。低于或等于起点及未许可时为零。</p>
<p><b>最小用法</b> 并接热端，request 由保护请求或温度控制器驱动。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ThermalOvertemperatureProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 理想有界热汇，冷却功耗和冷源温度需由外部热系统建模。</p>
</html>"));
end CoolingEnable;
