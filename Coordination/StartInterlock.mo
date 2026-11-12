within ProtectionLibrary.Coordination;
block StartInterlock "Combine every permissive with a start request and independent trip priority"
parameter Integer n(min=1)=2;
    Modelica.Blocks.Interfaces.BooleanInput startRequest annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput permissive[n] annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput trip annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput startPermitted annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput refusedByTrip annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput refusedByPermission annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Boolean ready;
equation
  ready=sum(if permissive[i] then 1 else 0 for i in 1:n)==n;
  refusedByTrip=startRequest and trip;
  refusedByPermission=startRequest and not ready;
  startPermitted=startRequest and ready and not trip;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-37,-43},{34,50}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-27,38},{24,-18}}, textString="&", textColor={64,64,64}, fontSize=0),
        Line(points={{-65,30},{-37,30}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,3},{-37,3}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-24},{-37,-24}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{34,5},{65,5}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{16,62},{16,51}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{7,62},{25,62}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Combine every permissive with a start request and independent trip priority.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput startRequest; Modelica.Blocks.Interfaces.BooleanInput permissive[n]; Modelica.Blocks.Interfaces.BooleanInput trip; Modelica.Blocks.Interfaces.BooleanOutput startPermitted; Modelica.Blocks.Interfaces.BooleanOutput refusedByTrip; Modelica.Blocks.Interfaces.BooleanOutput refusedByPermission</p><p><b>Parameters</b> parameter Integer n(min=1)=2</p><p><b>Behavior</b> Combine every permissive with a start request and independent trip priority</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> startPermitted, refusedByTrip, refusedByPermission</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end StartInterlock;
