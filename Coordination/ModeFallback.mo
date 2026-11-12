within ProtectionLibrary.Coordination;
block ModeFallback "对名义任务模式实施有优先级的降级或停车请求"
  input ProtectionLibrary.Utilities.Types.OperatingMode normalMode "名义请求模式";
  Modelica.Blocks.Interfaces.BooleanInput degrade "请求降级" annotation(Placement(transformation(extent={{-106,18},{-94,30}}), iconTransformation(extent={{-106,18},{-94,30}})));
  Modelica.Blocks.Interfaces.BooleanInput stop "请求进入安全模式" annotation(Placement(transformation(extent={{-106,-30},{-94,-18}}), iconTransformation(extent={{-106,-30},{-94,-18}})));
  output ProtectionLibrary.Utilities.Types.OperatingMode mode "仲裁后的模式";
equation
  mode = if stop or normalMode == ProtectionLibrary.Utilities.Types.OperatingMode.Safe then
    ProtectionLibrary.Utilities.Types.OperatingMode.Safe
    elseif degrade then ProtectionLibrary.Utilities.Types.OperatingMode.Reduced else normalMode;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-65,21},{-29,57}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-61,53},{-33,25}}, textString="N", textColor={64,64,64}, fontSize=0),
        Line(points={{-25,38},{7,9}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{11,-6},{47,30}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{15,26},{43,-2}}, textString="R", textColor={64,64,64}, fontSize=0),
        Line(points={{27,-10},{8,-37}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-15,-73},{21,-37}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-11,-41},{17,-69}}, textString="S", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="ModeFallback")}),
    Documentation(info="<html><p><b>Purpose</b> 对名义任务模式实施有优先级的降级或停车请求</p><p><b>Interfaces</b> input ProtectionLibrary.Utilities.Types.OperatingMode normalMode \"名义请求模式\"; Modelica.Blocks.Interfaces.BooleanInput degrade \"请求降级\"; Modelica.Blocks.Interfaces.BooleanInput stop \"请求进入安全模式\"; output ProtectionLibrary.Utilities.Types.OperatingMode mode \"仲裁后的模式\"</p><p><b>Parameters</b> The declaration has no standalone tuning parameters.</p><p><b>Behavior</b> 对名义任务模式实施有优先级的降级或停车请求</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p>
<p>对名义任务模式实施有优先级的降级或停车请求</p>
<p>专业分类为 SystemProtection.SafeState。</p>
<p>接口与方向</p>
<ul>
<li><code>input ProtectionLibrary.Utilities.Types.OperatingMode normalMode \"名义请求模式\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput degrade \"请求降级\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanInput stop \"请求进入安全模式\"</code></li>
<li><code>output ProtectionLibrary.Utilities.Types.OperatingMode mode \"仲裁后的模式\"</code></li>
</ul>
<p><b>时序与基准行为</b> 停止或已有 Safe 优先，降级不能将 Safe 提升至 Reduced。释放请求后跟随名义模式。</p>
<p><b>最小用法</b> 在宿主状态机之前绑定 mode，单独测量实际进入状态。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">MultiConditionInterlock</a> 展示同域接线。</p>
<p><b>适用边界</b> 需要手动恢复时将 stop 由锁存器驱动。</p>
</html>"));
end ModeFallback;
