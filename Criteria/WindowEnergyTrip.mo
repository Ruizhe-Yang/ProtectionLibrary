within ProtectionLibrary.Criteria;
block WindowEnergyTrip "基于滑窗内正向能量累计限制负载"
  parameter Modelica.Units.SI.Time windowLength(min=Modelica.Constants.small) = 1 "滑窗长度，s";
  parameter Modelica.Units.SI.Energy energyLimit(min=0) = 100 "滑窗能量门限，J";
  Modelica.Blocks.Interfaces.RealInput power(unit="W") "被监测功率" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.RealOutput windowEnergy(unit="J") "滑窗内正向能量" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "能量达到门限" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Modelica.Units.SI.Energy cumulative(start=0,fixed=true);
initial equation
  assert(windowLength > 0 and energyLimit >= 0, "Invalid energy trip parameters.");
equation
  der(cumulative) = max(0,power);
  windowEnergy = cumulative-delay(cumulative,windowLength);
  request = windowEnergy >= energyLimit;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Polygon(points={{-30,-40},{-30,16},{-9,32},{13,7},{35,29},{35,-40},{-30,-40}}, lineColor={235,235,235}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-58,-9},{-45,8},{-30,16},{-9,32},{13,7},{35,29},{59,18}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-30,-44},{-30,51}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{35,-44},{35,51}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{39,68},{70,39}}, textString="E", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="WindowEnergyTrip")}),
    Documentation(info="<html><p><b>Purpose</b> 基于滑窗内正向能量累计限制负载</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput power(unit=\"W\") \"被监测功率\"; Modelica.Blocks.Interfaces.RealOutput windowEnergy(unit=\"J\") \"滑窗内正向能量\"; Modelica.Blocks.Interfaces.BooleanOutput request \"能量达到门限\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time windowLength(min=Modelica.Constants.small) = 1 \"滑窗长度，s\"; parameter Modelica.Units.SI.Energy energyLimit(min=0) = 100 \"滑窗能量门限，J\"</p><p><b>Behavior</b> 基于滑窗内正向能量累计限制负载</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p>
<p>基于滑窗内正向能量累计限制负载</p>
<p>专业分类为 ProtectionLogic.Window。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput power(unit=\"W\") \"被监测功率\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput windowEnergy(unit=\"J\") \"滑窗内正向能量\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput request \"能量达到门限\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Time windowLength(min=Modelica.Constants.small) = 1 \"滑窗长度，s\"</code></li>
<li><code>Modelica.Units.SI.Energy energyLimit(min=0) = 100 \"滑窗能量门限，J\"</code></li>
</ul>
<p><b>时序与基准行为</b> 仿真起点前累计为零，满窗前使用实际已积分长度。超过门限请求，能量滑出窗口后解除。</p>
<p><b>最小用法</b> 接负载的已测功率与切断或限流逻辑。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ElectricalOvercurrentProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 用于正向功率累计。很长运行时累计差存在消减误差。</p>
</html>"));
end WindowEnergyTrip;
