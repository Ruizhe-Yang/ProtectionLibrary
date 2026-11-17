within ProtectionLibrary.Coordination;
block RealOverride "Immediate real override with optional controlled recovery"
parameter Real safeValue=0 "Command selected immediately during protection";
  parameter Real recoveryRate(min=0)=0 "Maximum recovery rate in signal units per second; zero restores u immediately";
  parameter Modelica.Units.SI.Time trackingTime(min=0)=0.01 "Tracking time constant during final recovery";
  parameter Real trackingTolerance(min=0)=1e-5 "Maximum tracking error for resuming direct input passage";
    Modelica.Blocks.Interfaces.RealInput u  "Nominal real command" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protect  "Select the immediate protective command" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y  "Protective, recovering or nominal command" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  Real recoveringValue "Internal command trajectory during recovery";
  Boolean reached "Recovery error is within the tracking tolerance";
  discrete Boolean recover(start=false,fixed=true) "Recovery remains active after protection clears";
initial equation
  assert(recoveryRate>=0 and trackingTime>0 and trackingTolerance>=0,"Invalid recovery settings.");
equation
  when {initial(),protect} then reinit(recoveringValue,safeValue); end when;
  der(recoveringValue)=if not protect and recover and recoveryRate>0 then
    min(recoveryRate,max(-recoveryRate,(u-recoveringValue)/trackingTime)) else 0;
  reached=not protect and abs(u-recoveringValue)<=trackingTolerance;
  when {initial(),protect,reached} then recover=protect or (not initial() and pre(recover) and not reached); end when;
  y=if protect then safeValue elseif recoveryRate>0 and recover then recoveringValue else u;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-53.95,41.54},{-24.07,41.54}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-53.95,-4.94},{-24.07,-4.94}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-27.39,38.22},{-20.75,44.86}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-27.39,-8.26},{-20.75,-1.62}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{24.9,14.98},{31.54,21.62}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{28.22,18.3},{54.78,18.3}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-19.09,-1.62},{28.22,18.3}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-19.09,38.22},{23.24,20.79}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{3.32,-33.99},{3.32,3.36}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-34,-51},{-15,-51},{12,-32},{36,-32}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Output safeValue immediately while protect is true. With recoveryRate zero, clearing protection immediately restores u. With a positive rate, recover from safeValue using a symmetric rate limit and trackingTime near the target, then pass u directly once the tracking error is within trackingTolerance.</p><p>At initialisation without protection the nominal input passes directly. Every new protection request restarts recovery from safeValue. The limiter applies only during recovery; subsequent nominal input changes pass unchanged. A zero tracking tolerance can leave an asymptotic recovery active indefinitely.</p></html>"));
end RealOverride;
