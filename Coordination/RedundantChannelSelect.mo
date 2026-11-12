within ProtectionLibrary.Coordination;
block RedundantChannelSelect "根据可用性接管到独立备用命令"
  parameter Real fallback = 0 "两通道均不可用时的显式回退命令";
  Modelica.Blocks.Interfaces.RealInput primary "主通道" annotation(Placement(transformation(extent={{-106,66},{-94,78}}), iconTransformation(extent={{-106,66},{-94,78}})));
  Modelica.Blocks.Interfaces.RealInput backup "备用通道" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput primaryValid "主通道有效" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  Modelica.Blocks.Interfaces.BooleanInput backupValid "备用通道有效" annotation(Placement(transformation(extent={{-106,-78},{-94,-66}}), iconTransformation(extent={{-106,-78},{-94,-66}})));
  Modelica.Blocks.Interfaces.RealOutput y "已选命令" annotation(Placement(transformation(extent={{94,42},{106,54}}), iconTransformation(extent={{94,42},{106,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput usingBackup "正在用备用通道" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid "至少一路有效" annotation(Placement(transformation(extent={{94,-54},{106,-42}}), iconTransformation(extent={{94,-54},{106,-42}})));
equation
  valid = primaryValid or backupValid;
  usingBackup = not primaryValid and backupValid;
  y = if primaryValid then primary elseif usingBackup then backup else fallback;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,38},{-29,38}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-18},{-29,-18}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-33,34},{-25,42}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-33,-22},{-25,-14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{30,6},{38,14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{34,10},{66,10}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-23,-14},{34,10}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-23,34},{28,13}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-64,66},{-35,43}}, textString="1", textColor={64,64,64}, fontSize=0),
        Text(extent={{-64,-24},{-35,-52}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{2.5,-40},{10.48,-48.4},{26.02,-28.24}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="RedundantChannelSelect")}),
    Documentation(info="<html><p><b>Purpose</b> 根据可用性接管到独立备用命令</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput primary \"主通道\"; Modelica.Blocks.Interfaces.RealInput backup \"备用通道\"; Modelica.Blocks.Interfaces.BooleanInput primaryValid \"主通道有效\"; Modelica.Blocks.Interfaces.BooleanInput backupValid \"备用通道有效\"; Modelica.Blocks.Interfaces.RealOutput y \"已选命令\"; Modelica.Blocks.Interfaces.BooleanOutput usingBackup \"正在用备用通道\"; Modelica.Blocks.Interfaces.BooleanOutput valid \"至少一路有效\"</p><p><b>Parameters</b> parameter Real fallback = 0 \"两通道均不可用时的显式回退命令\"</p><p><b>Behavior</b> 根据可用性接管到独立备用命令</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>根据可用性接管到独立备用命令</p>
<p>专业分类为 CommandManagement.CommandOverride。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput primary \"主通道\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealInput backup \"备用通道\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput primaryValid \"主通道有效\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput backupValid \"备用通道有效\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput y \"已选命令\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput usingBackup \"正在用备用通道\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput valid \"至少一路有效\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Real fallback = 0 \"两通道均不可用时的显式回退命令\"</code></li>
</ul>
<p><b>时序与基准行为</b> 主通道有效即优先。双路无效立即回退，主通道恢复后立即回切。</p>
<p><b>最小用法</b> 接两套已定义有效性的输入，y 接唯一执行端。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 展示同域接线。</p>
<p><b>适用边界</b> 两路幅值不连续时可能跳变。信号有效性可在上游做迟滞。</p>
</html>"));
end RedundantChannelSelect;
