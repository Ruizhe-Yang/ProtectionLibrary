within ProtectionLibrary.Thermal;
block OverTemperatureGuard "联合温度上界与已升温时的速率判据"
  parameter Modelica.Units.SI.Temperature tripTemperature(min=0) = 333.15 "高温触发，K";
  parameter Modelica.Units.SI.Temperature clearTemperature(min=0) = 323.15 "高温清除，K";
  parameter Modelica.Units.SI.Temperature armingTemperature(min=0) = 310.15 "速率判据最低温度，K";
  parameter Real slopeThreshold(unit="K/s",min=0) = 2 "正向温升率门限，K/s";
  parameter Modelica.Units.SI.Time samplePeriod(min=Modelica.Constants.small) = 0.1 "速率差分周期，s";
  parameter Modelica.Units.SI.Time sampleStart = 0 "速率采样起点，s";
  Modelica.Blocks.Interfaces.RealInput temperature(unit="K") "被保护节点温度" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "温度或速率判据请求" annotation(Placement(transformation(extent={{94,42},{106,54}}), iconTransformation(extent={{94,42},{106,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput fastRise "温度已达到布防点且温升率过高" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
  Modelica.Blocks.Interfaces.RealOutput rate(unit="K/s") "有符号采样温升率" annotation(Placement(transformation(extent={{94,-54},{106,-42}}), iconTransformation(extent={{94,-54},{106,-42}})));
protected
  ProtectionLibrary.Criteria.HighLimit ceiling(tripLevel=tripTemperature,resetLevel=clearTemperature);
  ProtectionLibrary.Criteria.RateOfChange trend(sense=ProtectionLibrary.Utilities.Types.RateSense.Rising,failSafe=false,threshold=slopeThreshold,samplePeriod=samplePeriod,sampleStart=sampleStart);
initial equation
  assert(armingTemperature > 0 and clearTemperature > 0 and armingTemperature <= tripTemperature, "Invalid thermal arming temperatures.");
equation
  ceiling.u = temperature;
  trend.u = temperature;
  rate = trend.rate;
  fastRise = temperature >= armingTemperature and trend.request;
  request = ceiling.request or fastRise;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-45,-43},{-13,-11}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{-35,-14},{-23,53}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-29,-23},{-29,39}}, color={191,0,0}, thickness=1.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-37,-35},{-21,-19}}, lineColor={191,0,0}, fillColor={191,0,0}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-15,39},{16,39}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{14,-30},{14,29},{58,29}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{21,-23},{36,-7},{45,5},{54,31}}, color={191,0,0}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="OverTemperatureGuard")}),
    Documentation(info="<html><p><b>Purpose</b> 联合温度上界与已升温时的速率判据</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput temperature(unit=\"K\") \"被保护节点温度\"; Modelica.Blocks.Interfaces.BooleanOutput request \"温度或速率判据请求\"; Modelica.Blocks.Interfaces.BooleanOutput fastRise \"温度已达到布防点且温升率过高\"; Modelica.Blocks.Interfaces.RealOutput rate(unit=\"K/s\") \"有符号采样温升率\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Temperature tripTemperature(min=0) = 333.15 \"高温触发，K\"; parameter Modelica.Units.SI.Temperature clearTemperature(min=0) = 323.15 \"高温清除，K\"; parameter Modelica.Units.SI.Temperature armingTemperature(min=0) = 310.15 \"速率判据最低温度，K\"; parameter Real slopeThreshold(unit=\"K/s\",min=0) = 2 \"正向温升率门限，K/s\"; parameter Modelica.Units.SI.Time samplePeriod(min=Modelica.Constants.small) = 0.1 \"速率差分周期，s\"; parameter Modelica.Units.SI.Time sampleStart = 0 \"速率采样起点，s\"</p><p><b>Behavior</b> 联合温度上界与已升温时的速率判据</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThermalCooling\">ProtectionLibrary.Examples.ThermalCooling</a></p>
<p>联合温度上界与已升温时的速率判据</p>
<p>专业分类为 ThermalProtection.TemperatureLimits。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput temperature(unit=\"K\") \"被保护节点温度\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput request \"温度或速率判据请求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput fastRise \"温度已达到布防点且温升率过高\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput rate(unit=\"K/s\") \"有符号采样温升率\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Temperature tripTemperature(min=0) = 333.15 \"高温触发，K\"</code></li>
<li><code>Modelica.Units.SI.Temperature clearTemperature(min=0) = 323.15 \"高温清除，K\"</code></li>
<li><code>Modelica.Units.SI.Temperature armingTemperature(min=0) = 310.15 \"速率判据最低温度，K\"</code></li>
<li><code>Real slopeThreshold(unit=\"K/s\",min=0) = 2 \"正向温升率门限，K/s\"</code></li>
<li><code>Modelica.Units.SI.Time samplePeriod(min=Modelica.Constants.small) = 0.1 \"速率差分周期，s\"</code></li>
<li><code>Modelica.Units.SI.Time sampleStart = 0 \"速率采样起点，s\"</code></li>
</ul>
<p><b>时序与基准行为</b> 绝对温度为连续迟滞判据，温升率在时钟刻度更新。两者任一请求即可切热。</p>
<p><b>最小用法</b> 接热端温度传感器并将 request 送到切断热源、冷却或锁存逻辑。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ThermalOvertemperatureProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 采样速率可能漏掉短峰。热源有惯性时切断后可能继续升温。</p>
</html>"));
end OverTemperatureGuard;
