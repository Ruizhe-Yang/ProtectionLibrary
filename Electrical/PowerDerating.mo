within ProtectionLibrary.Electrical;
block PowerDerating "Scale a power demand during derating and enforce the rated bound"
parameter Modelica.Units.SI.Power ratedPower(min=0)=100;
  parameter Real factor(min=0,max=1)=0.6;
    Modelica.Blocks.Interfaces.RealInput u(unit="W") annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput derate annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="W") annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput limited annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
initial equation
  assert(ratedPower>=0 and factor>=0 and factor<=1,"Invalid power derating.");
equation
  y=min(ratedPower,max(-ratedPower,u*(if derate then factor else 1)));
  limited=y<u or y>u;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-62,55},{-62,-40},{65,-40}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-57,-27},{54,44}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-57,-16},{54,27}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-57,27},{60,27}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{26,69},{65,43}}, textString="P", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Scale a power demand during derating and enforce the rated bound.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput u(unit=\"W\"); Modelica.Blocks.Interfaces.BooleanInput derate; Modelica.Blocks.Interfaces.RealOutput y(unit=\"W\"); Modelica.Blocks.Interfaces.BooleanOutput limited</p><p><b>Parameters</b> parameter Modelica.Units.SI.Power ratedPower(min=0)=100; parameter Real factor(min=0,max=1)=0.6</p><p><b>Behavior</b> Scale a power demand during derating and enforce the rated bound</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The output is a request in watts. The power delivered by the host is a separate measurement.</p><p><b>Observables</b> y, limited</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ElectricalTripAndDump\">ProtectionLibrary.Examples.ElectricalTripAndDump</a></p></html>"));
end PowerDerating;
