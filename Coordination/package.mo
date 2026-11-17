within ProtectionLibrary;
package Coordination "Protection request coordination and command handling"
  extends Modelica.Icons.Package;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Text(extent={{-62.56,57.96},{-41.4,35.88}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-35.88,46.92},{-8.28,46.92},{24.84,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-62.56,26.68},{-41.4,4.6}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{-35.88,15.64},{-8.28,15.64},{24.84,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-62.56,-4.6},{-41.4,-26.68}}, textString="3", textColor={64,64,64}, fontSize=0),
        Line(points={{-35.88,-15.64},{-8.28,-15.64},{24.84,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-62.56,-35.88},{-41.4,-57.96}}, textString="4", textColor={64,64,64}, fontSize=0),
        Line(points={{-35.88,-46.92},{-8.28,-46.92},{24.84,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{24.84,0},{61.64,0}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled})
      }), Documentation(info="<html><p>Combine protection requests with latching, reset permission, dwell rules, priority selection, fallback and acknowledgement monitoring. Outputs represent requested actions or declared status; connect the corresponding physical actuators and feedback explicitly.</p></html>"));
end Coordination;
