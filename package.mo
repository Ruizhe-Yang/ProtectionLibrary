within;
package ProtectionLibrary "Criteria, voting, coordination and physical protection components"
  extends Modelica.Icons.Package;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Polygon(points={{-48.76,50.6},{0,66.24},{48.76,50.6},{44.16,-11.04},{25.76,-39.56},{0,-58.88},{-25.76,-39.56},{-44.16,-11.04},{-48.76,50.6}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-29.44,4.6},{-8.28,-18.4},{28.52,25.76}}, color={0,0,127}, thickness=1.5, pattern=LinePattern.Solid)
      }),
    uses(Modelica(version="4.0.0")), version="1.0.0", Documentation(info="<html><p>ProtectionLibrary provides criteria, channel voting, command coordination, physical protective devices and independent action monitoring for Modelica simulations. Its only library dependency is Modelica Standard Library 4.0.0.</p><p>Begin with <a href=\"modelica://ProtectionLibrary.UsersGuide\">UsersGuide</a> and <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">Examples.ThresholdLatchReset</a>. Connect each decision and physical action explicitly to the receiving model.</p></html>"));
end ProtectionLibrary;
