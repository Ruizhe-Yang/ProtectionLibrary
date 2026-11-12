within ProtectionLibrary.Electrical;
model SourceTransfer "先断后合的双电源切换装置"
  parameter Modelica.Units.SI.Time deadTime(min=Modelica.Constants.small) = 0.05 "换源全断时间，s";
  parameter Modelica.Units.SI.Resistance contactResistance(min=Modelica.Constants.small) = 0.01 "每路导通电阻，Ohm";
  Modelica.Blocks.Interfaces.BooleanInput selectBackup "请求选择备用馈线" annotation(Placement(transformation(extent={{-106,-6},{-94,6}}), iconTransformation(extent={{-106,-6},{-94,6}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin primary "主馈线端" annotation(Placement(transformation(extent={{-107,37},{-93,51}}), iconTransformation(extent={{-107,37},{-93,51}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin backup "备用馈线端" annotation(Placement(transformation(extent={{-107,-51},{-93,-37}}), iconTransformation(extent={{-107,-51},{-93,-37}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin load "负载端" annotation(Placement(transformation(extent={{93,-7},{107,7}}), iconTransformation(extent={{93,-7},{107,7}})));
  Modelica.Blocks.Interfaces.BooleanOutput primaryClosed "主接点闭合" annotation(Placement(transformation(extent={{94,18},{106,30}}), iconTransformation(extent={{94,18},{106,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput backupClosed "备用接点闭合" annotation(Placement(transformation(extent={{94,-30},{106,-18}}), iconTransformation(extent={{94,-30},{106,-18}})));
protected
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch mainContact(Ron=contactResistance,Goff=0);
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch backupContact(Ron=contactResistance,Goff=0);
  discrete Modelica.Units.SI.Time lastChange;
  Boolean transferComplete;
initial equation
  assert(deadTime > 0 and contactResistance > 0, "Dead time and contact resistance must be positive.");
equation
  when {initial(), selectBackup, not selectBackup} then
    lastChange = time;
  end when;
  transferComplete = time >= lastChange+deadTime;
  primaryClosed = transferComplete and not selectBackup;
  backupClosed = transferComplete and selectBackup;
  mainContact.control = not primaryClosed;
  backupContact.control = not backupClosed;
  connect(primary, mainContact.p);
  connect(backup, backupContact.p);
  connect(mainContact.n, load);
  connect(backupContact.n, load);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,44},{-34,44}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-100,-44},{-34,-44}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-38,40},{-30,48}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-38,-48},{-30,-40}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{28,-4},{36,4}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{32,0},{100,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{32,0},{-27,35}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{32,0},{-27,-35}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Text(extent={{17,-41},{67,-68}}, textString="dt", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={Text(extent={{-96,99},{96,88}}, textColor={25,90,132}, textString="SourceTransfer")}),
    Documentation(info="<html><p><b>Purpose</b> 先断后合的双电源切换装置</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput selectBackup \"请求选择备用馈线\"; Modelica.Electrical.Analog.Interfaces.PositivePin primary \"主馈线端\"; Modelica.Electrical.Analog.Interfaces.PositivePin backup \"备用馈线端\"; Modelica.Electrical.Analog.Interfaces.NegativePin load \"负载端\"; Modelica.Blocks.Interfaces.BooleanOutput primaryClosed \"主接点闭合\"; Modelica.Blocks.Interfaces.BooleanOutput backupClosed \"备用接点闭合\"</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time deadTime(min=Modelica.Constants.small) = 0.05 \"换源全断时间，s\"; parameter Modelica.Units.SI.Resistance contactResistance(min=Modelica.Constants.small) = 0.01 \"每路导通电阻，Ohm\"</p><p><b>Behavior</b> 先断后合的双电源切换装置</p><p><b>Initialization</b> Use the declared initial values and host state modifiers.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Use the declared parameter range. The catalog identifies simulation coverage.</p><p><b>Observables</b> Inspect the declared output variables.</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ElectricalTripAndDump\">ProtectionLibrary.Examples.ElectricalTripAndDump</a></p>
<p>先断后合的双电源切换装置</p>
<p>专业分类为 ElectricalProtection.PowerIsolation。</p>
<p>接口与方向</p>
<ul>
<li><code>Modelica.Blocks.Interfaces.BooleanInput selectBackup \"请求选择备用馈线\"</code></li>
<li><code>Modelica.Electrical.Analog.Interfaces.PositivePin primary \"主馈线端\"</code></li>
<li><code>Modelica.Electrical.Analog.Interfaces.PositivePin backup \"备用馈线端\"</code></li>
<li><code>Modelica.Electrical.Analog.Interfaces.NegativePin load \"负载端\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput primaryClosed \"主接点闭合\"</code></li>
<li><code>Modelica.Blocks.Interfaces.BooleanOutput backupClosed \"备用接点闭合\"</code></li>
</ul>
<p>参数、类型、默认值及约束</p>
<ul>
<li><code>Modelica.Units.SI.Time deadTime(min=Modelica.Constants.small) = 0.05 \"换源全断时间，s\"</code></li>
<li><code>Modelica.Units.SI.Resistance contactResistance(min=Modelica.Constants.small) = 0.01 \"每路导通电阻，Ohm\"</code></li>
</ul>
<p><b>时序与基准行为</b> 初始和每次选择变化后全断 deadTime。等待期间新选择重新计时。始终互斥。</p>
<p><b>最小用法</b> 接两条具有已定义回路参考的馈线，load 接下游负载。 <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ElectricalOvercurrentProtection</a> 展示同域接线。</p>
<p><b>适用边界</b> 全断时负载端需自行定解。感性负载需续流，模型无同步或过零检测。</p>
</html>"));
end SourceTransfer;
