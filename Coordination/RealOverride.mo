within ProtectionLibrary.Coordination;
block RealOverride "Override a real command and optionally limit the recovery rate"
parameter Real safeValue=0;
  parameter Real recoveryRate(min=0)=0 "Command units per second, zero requests immediate recovery";
  parameter Modelica.Units.SI.Time trackingTime(min=0)=0.01;
  parameter Real trackingTolerance(min=0)=1e-5;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protect annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
protected
  Real recoveringValue;
  Boolean reached;
  discrete Boolean recover(start=false,fixed=true);
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
    Documentation(info="<html><p><b>Purpose</b> Override a real command and optionally limit the recovery rate.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput u; Modelica.Blocks.Interfaces.BooleanInput protect; Modelica.Blocks.Interfaces.RealOutput y</p><p><b>Parameters</b> parameter Real safeValue=0; parameter Real recoveryRate(min=0)=0 \"Command units per second, zero requests immediate recovery\"; parameter Modelica.Units.SI.Time trackingTime(min=0)=0.01; parameter Real trackingTolerance(min=0)=1e-5</p><p><b>Behavior</b> Override a real command and optionally limit the recovery rate</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> A positive recovery rate applies until the command is rejoined within trackingTolerance. After handoff, normal command passes through.</p><p><b>Observables</b> y</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end RealOverride;
