within ProtectionLibrary.Utilities.Types;
type OperatingMode = enumeration(Nominal "正常", Reduced "降级", Safe "安全停机请求") "由宿主解释的保护模式"
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="MODE", textColor={255,255,255}, fontSize=0)
      }),
    Documentation(info="<html>
<p>降级或安全状态由请求仲裁。</p>
</html>"));
