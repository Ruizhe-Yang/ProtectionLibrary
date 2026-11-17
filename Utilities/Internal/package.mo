within ProtectionLibrary.Utilities;
package Internal "Low-level helpers and prescribed example signals"
  extends Modelica.Icons.Package;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-50.6,-50.6},{50.6,50.6}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-32.2,-32.2},{32.2,32.2}}, color={128,128,128}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-32.2,32.2},{32.2,-32.2}}, color={128,128,128}, thickness=1.1, pattern=LinePattern.Solid)
      }), Documentation(info="<html><p>Supporting vote counts, unqualified-vector fusion and fixed signal patterns used by the examples. These helpers have narrower contracts than the public voting blocks.</p></html>"));
end Internal;
