within ProtectionLibrary.Utilities.Types;
type FusionMethod = enumeration(Median "中位数", Mean "算术平均", Trimmed "截尾平均", Weighted "加权平均") "同单位模拟量融合算法"
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={160,160,164}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=18),
        Text(extent={{-64,69},{64,-9}}, textString="E", textColor={255,255,255}, fontSize=0),
        Text(extent={{-70,-30},{70,-67}}, textString="FUSE", textColor={255,255,255}, fontSize=0)
      }),
    Documentation(info="<html>
<p>同单位模拟量融合算法</p>
</html>"));
