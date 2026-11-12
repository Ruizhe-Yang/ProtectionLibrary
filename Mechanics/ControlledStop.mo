within ProtectionLibrary.Mechanics;
block ControlledStop "以指定角减速度生成受控停车速度指令"
  parameter Modelica.Units.SI.AngularAcceleration deceleration(min=Modelica.Constants.small) = 3 "斜坡幅值，rad/s2";
  Modelica.Blocks.Interfaces.RealInput speedReference(unit="rad/s") "正常速度指令" annotation(Placement(transformation(extent={{-106,42},{-94,54}}), iconTransformation(extent={{-106,42},{-94,54}})));
  Modelica.Blocks.Interfaces.RealInput measuredSpeed(unit="rad/s") "切入时的实际角速度" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanInput request "受控停车请求" annotation(Placement(transformation(extent={{-106,-54},{-94,-42}}), iconTransformation(extent={{-106,-54},{-94,-42}})));
  Modelica.Blocks.Interfaces.RealOutput speedCommand(unit="rad/s") "给速度环的停车指令" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  discrete Modelica.Units.SI.AngularVelocity captured;
  discrete Modelica.Units.SI.Time entered;
initial equation
  assert(deceleration > 0, "Deceleration must be positive.");
equation
  when {initial(),request} then
    captured = measuredSpeed;
    entered = time;
  end when;
  speedCommand = if request then sign(captured)*max(0,abs(captured)-deceleration*(time-entered)) else speedReference;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-58,40},{-30,40},{29,-37},{61,-37}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-30,40},{-30,-40}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Text(extent={{20,61},{60,29}}, textString="w", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="ControlledStop")}),
    Documentation(info="<html><p><b>Purpose</b> 以指定角减速度生成受控停车速度指令</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput speedReference(unit=\"rad/s\") \"正常速度指令\"; Modelica.Blocks.Interfaces.RealInput measuredSpeed(unit=\"rad/s\") \"切入时的实际角速度\"; Modelica.Blocks.Interfaces.BooleanInput request \"受控停车请求\"; Modelica.Blocks.Interfaces.RealOutput speedCommand(unit=\"rad/s\") \"给速度环的停车指令\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.AngularAcceleration deceleration(min=Modelica.Constants.small) = 3 \"斜坡幅值，rad/s2\"</p><p><b>Behavior</b> 以指定角减速度生成受控停车速度指令</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.MechanicalBraking\">ProtectionLibrary.Examples.MechanicalBraking</a></p>
<p>以指定角减速度生成受控停车速度指令</p>
<p>专业分类为 MechanicalProtection.Stopping。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput speedReference(unit=\"rad/s\") \"正常速度指令\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealInput measuredSpeed(unit=\"rad/s\") \"切入时的实际角速度\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput request \"受控停车请求\"</code></li>
<li><code>Modelica.Blocks.Interfaces.RealOutput speedCommand(unit=\"rad/s\") \"给速度环的停车指令\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.AngularAcceleration deceleration(min=Modelica.Constants.small) = 3 \"斜坡幅值，rad/s2\"</code></li>
</ul>
<p><b>时序与基准行为</b> 请求上升沿捕获实际速度，按方向减到零并保持。撤销后跟随正常指令。</p>
<p><b>最小用法</b> 插在速度设定与闭环驱动之间。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MechanicalOverspeedProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 斜坡为命令，驱动和负载可能不能跟踪。重新接入正常指令可能发生跃变。</p>
</html>"));
end ControlledStop;
