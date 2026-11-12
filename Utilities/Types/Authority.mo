within ProtectionLibrary.Utilities.Types;
type Authority = enumeration(Normal "正常任务", Interlock "联锁", Emergency "紧急停车") "控制命令来源"
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="SRC", textColor={255,255,255}, fontSize=0)
      }),
    Documentation(info="<html>
<p>优先级从正常、联锁到紧急依次升高。</p>
</html>"));
