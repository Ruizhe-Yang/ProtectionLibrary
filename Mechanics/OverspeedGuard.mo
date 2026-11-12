within ProtectionLibrary.Mechanics;
block OverspeedGuard "持续超速后才请求制动或切驱动"
  parameter Modelica.Units.SI.AngularVelocity limit(min=0) = 10 "允许速度幅值，rad/s";
  parameter Modelica.Units.SI.Time dwell(min=0) = 0.2 "连续超速确认时间，s";
  Modelica.Blocks.Interfaces.RealInput speed(unit="rad/s") "轴角速度" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Blocks.Interfaces.BooleanOutput request "持续超速请求" annotation(Placement(transformation(extent={{94,-6},{106,6}}), iconTransformation(extent={{94,-6},{106,6}})));
protected
  ProtectionLibrary.Criteria.Persistence persistence(holdTime=dwell);
initial equation
  assert(limit > 0, "Speed limit must be positive.");
equation
  persistence.condition = abs(speed) > limit;
  request = persistence.request;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-53,-36},{43,60}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-41,12},{-33,12}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-29,43},{-23,37}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-5,49},{-5,41}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{19,43},{13,37}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{30,12},{22,12}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-5,10},{29,37}}, color={0,0,127}, thickness=1.3, pattern=LinePattern.Solid),
        Ellipse(extent={{-9,6},{-1,14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-29,6},{18,-25}}, textString="w", textColor={64,64,64}, fontSize=0),
        Line(points={{42,42},{66,42}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{54,51},{66,42},{54,33}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="OverspeedGuard")}),
    Documentation(info="<html><p><b>Purpose</b> 持续超速后才请求制动或切驱动</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput speed(unit=\"rad/s\") \"轴角速度\"; Modelica.Blocks.Interfaces.BooleanOutput request \"持续超速请求\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.AngularVelocity limit(min=0) = 10 \"允许速度幅值，rad/s\"; parameter Modelica.Units.SI.Time dwell(min=0) = 0.2 \"连续超速确认时间，s\"</p><p><b>Behavior</b> 持续超速后才请求制动或切驱动</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.MechanicalBraking\">ProtectionLibrary.Examples.MechanicalBraking</a></p>
<p>持续超速后才请求制动或切驱动</p>
<p>专业分类为 MechanicalProtection.MotionLimits。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.RealInput speed(unit=\"rad/s\") \"轴角速度\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput request \"持续超速请求\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.AngularVelocity limit(min=0) = 10 \"允许速度幅值，rad/s\"</code></li>
<li><code>Modelica.Units.SI.Time dwell(min=0) = 0.2 \"连续超速确认时间，s\"</code></li>
</ul>
<p><b>时序与基准行为</b> 速度幅值严格超限并持续 dwell 才请求。达到等号或以下即撤销。</p>
<p><b>最小用法</b> 接转速传感器，request 接 TripLatch 和制动链。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MechanicalOverspeedProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 短于 dwell 的尖峰不会触发。触发后实际减速度受制动力与惯量限制。</p>
</html>"));
end OverspeedGuard;
