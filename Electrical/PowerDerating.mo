within ProtectionLibrary.Electrical;
block PowerDerating "Power-command scaling with symmetric rated limits"
parameter Modelica.Units.SI.Power ratedPower(min=0)=100 "Maximum absolute power command";
  parameter Real factor(min=0,max=1)=0.6 "Command multiplier during derating";
    Modelica.Blocks.Interfaces.RealInput u(unit="W")  "Requested signed power" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput derate  "Apply the derating multiplier" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="W")  "Scaled and limited power command" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput limited  "True when scaling or saturation changes the request" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
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
    Documentation(info="<html><p>Multiply the signed power request by <code>factor</code> while <code>derate=true</code>, then limit the result to [-ratedPower,ratedPower]. Otherwise the unscaled request is limited to the same interval.</p><p><code>limited</code> reports any difference between the final output and the original request, including a change caused only by derating. The block supplies a command in watts; delivered electrical power is determined by the receiving model.</p></html>"));
end PowerDerating;
