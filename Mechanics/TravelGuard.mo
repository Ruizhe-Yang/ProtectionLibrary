within ProtectionLibrary.Mechanics;
block TravelGuard "按剩余行程削减朝向边界的速度指令"
  parameter Modelica.Units.SI.Position minimumPosition = 0 "允许行程下界，m";
  parameter Modelica.Units.SI.Position maximumPosition = 1 "允许行程上界，m";
  parameter Modelica.Units.SI.Length buffer(min=Modelica.Constants.small) = 0.1 "边界减速区宽度，m";
  Modelica.Blocks.Interfaces.RealInput position(unit="m") "实际位置" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.RealInput requestedSpeed(unit="m/s") "方向速度指令" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.RealOutput speedCommand(unit="m/s") "行程约束后的速度指令" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  Real fraction;
initial equation
  assert(maximumPosition > minimumPosition and buffer > 0 and 2*buffer <= maximumPosition-minimumPosition, "Invalid travel bounds.");
equation
  fraction = if requestedSpeed >= 0 then (maximumPosition-position)/buffer else (position-minimumPosition)/buffer;
  speedCommand = requestedSpeed*min(1,max(0,fraction));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,-28},{66,-28}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-62,-34},{-62,45}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{62,-34},{62,45}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Rectangle(extent={{-23,-19},{21,17}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-19,-27},{-9,-17}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{8,-27},{18,-17}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{4,35},{42,35}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{39,-24},{39,49}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{-39,-24},{-39,49}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="TravelGuard")}),
    Documentation(info="<html><p><b>Purpose</b> 按剩余行程削减朝向边界的速度指令</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput position(unit=\"m\") \"实际位置\"; Modelica.Blocks.Interfaces.RealInput requestedSpeed(unit=\"m/s\") \"方向速度指令\"; Modelica.Blocks.Interfaces.RealOutput speedCommand(unit=\"m/s\") \"行程约束后的速度指令\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Position minimumPosition = 0 \"允许行程下界，m\"; parameter Modelica.Units.SI.Position maximumPosition = 1 \"允许行程上界，m\"; parameter Modelica.Units.SI.Length buffer(min=Modelica.Constants.small) = 0.1 \"边界减速区宽度，m\"</p><p><b>Behavior</b> 按剩余行程削减朝向边界的速度指令</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.MechanicalBraking\">ProtectionLibrary.Examples.MechanicalBraking</a></p>
<p>按剩余行程削减朝向边界的速度指令</p>
<p>专业分类为 MechanicalProtection.MotionLimits。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput position(unit=\"m\") \"实际位置\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealInput requestedSpeed(unit=\"m/s\") \"方向速度指令\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput speedCommand(unit=\"m/s\") \"行程约束后的速度指令\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Position minimumPosition = 0 \"允许行程下界，m\"</code></li>
<li><code>Modelica.Units.SI.Position maximumPosition = 1 \"允许行程上界，m\"</code></li>
<li><code>Modelica.Units.SI.Length buffer(min=Modelica.Constants.small) = 0.1 \"边界减速区宽度，m\"</code></li>
</ul>
<p><b>时序与基准行为</b> 进入边界缓冲区即线性削减朝外命令，越界后仍允许向内。</p>
<p><b>最小用法</b> 插在平动速度环指令入口，位置来自实际传感器。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MechanicalOverspeedProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 宿主停车距离可能大于缓冲区，资产不施加刚性位置约束。</p>
</html>"));
end TravelGuard;
