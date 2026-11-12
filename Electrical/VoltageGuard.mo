within ProtectionLibrary.Electrical;
block VoltageGuard "对欠压和过压采用独立的迟滞保护请求"
  parameter Modelica.Units.SI.Voltage lowTrip = 18 "欠压触发，V";
  parameter Modelica.Units.SI.Voltage lowClear = 20 "欠压清除，V";
  parameter Modelica.Units.SI.Voltage highClear = 27 "过压清除，V";
  parameter Modelica.Units.SI.Voltage highTrip = 30 "过压触发，V";
  Modelica.Blocks.Interfaces.RealInput voltage(unit="V") "被保护母线电压" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "欠压或过压保护请求" annotation(Placement(transformation(extent={{94,42},{106,54}}), iconTransformation(extent={{94,42},{106,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput undervoltage "欠压判据当前请求" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput overvoltage "过压判据当前请求" annotation(Placement(transformation(extent={{94,-54},{106,-42}}), iconTransformation(extent={{94,-54},{106,-42}})));
protected
  ProtectionLibrary.Criteria.HighLimit low(tripLevel=-lowTrip,resetLevel=-lowClear);
  ProtectionLibrary.Criteria.HighLimit high(tripLevel=highTrip,resetLevel=highClear);
initial equation
  assert(lowTrip < lowClear and lowClear <= highClear and highClear < highTrip, "Voltage thresholds must be ordered.");
equation
  low.u = -voltage;
  high.u = voltage;
  undervoltage = low.request;
  overvoltage = high.request;
  request = undervoltage or overvoltage;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-61,34},{63,34}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-61,-18},{63,-18}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-60,3},{-38,7},{-18,44},{3,6},{27,1},{42,-31},{60,6}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Text(extent={{20,70},{63,46}}, textString="U", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="VoltageGuard")}),
    Documentation(info="<html><p><b>Purpose</b> 对欠压和过压采用独立的迟滞保护请求</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput voltage(unit=\"V\") \"被保护母线电压\"; Modelica.Blocks.Interfaces.BooleanOutput request \"欠压或过压保护请求\"; Modelica.Blocks.Interfaces.BooleanOutput undervoltage \"欠压判据当前请求\"; Modelica.Blocks.Interfaces.BooleanOutput overvoltage \"过压判据当前请求\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Voltage lowTrip = 18 \"欠压触发，V\"; parameter Modelica.Units.SI.Voltage lowClear = 20 \"欠压清除，V\"; parameter Modelica.Units.SI.Voltage highClear = 27 \"过压清除，V\"; parameter Modelica.Units.SI.Voltage highTrip = 30 \"过压触发，V\"</p><p><b>Behavior</b> 对欠压和过压采用独立的迟滞保护请求</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ElectricalTripAndDump\">ProtectionLibrary.Examples.ElectricalTripAndDump</a></p>
<p>对欠压和过压采用独立的迟滞保护请求</p>
<p>专业分类为 ElectricalProtection.SupplyLimits。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput voltage(unit=\"V\") \"被保护母线电压\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput request \"欠压或过压保护请求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput undervoltage \"欠压判据当前请求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput overvoltage \"过压判据当前请求\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Voltage lowTrip = 18 \"欠压触发，V\"</code></li>
<li><code>Modelica.Units.SI.Voltage lowClear = 20 \"欠压清除，V\"</code></li>
<li><code>Modelica.Units.SI.Voltage highClear = 27 \"过压清除，V\"</code></li>
<li><code>Modelica.Units.SI.Voltage highTrip = 30 \"过压触发，V\"</code></li>
</ul>
<p><b>时序与基准行为</b> 在任一危险门限（包含等号）请求，对应清除门限达到后撤销。</p>
<p><b>最小用法</b> 接测得的直流电压或上游计算的交流有效值。下游接转供或断路逻辑。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ElectricalOvercurrentProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 瞬时交流波形应先得到适用的有效值或包络。</p>
</html>"));
end VoltageGuard;
