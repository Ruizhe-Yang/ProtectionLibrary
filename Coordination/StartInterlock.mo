within ProtectionLibrary.Coordination;
block StartInterlock "Start request gated by all permissives and trip clearance"
parameter Integer n(min=1)=2 "Number of required start permissives";
    Modelica.Blocks.Interfaces.BooleanInput startRequest  "Request to initiate operation" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput permissive[n]  "Individual conditions required for a permitted start" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput trip  "Trip condition with priority over a start" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput startPermitted  "Start request with every permissive true and trip false" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput refusedByTrip  "A start request is present while trip is true" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput refusedByPermission  "A start request is present with at least one missing permissive" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Boolean ready "Every start permissive is true";
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
    Documentation(info="<html><p>Pass startRequest only when every permissive is true and trip is false. The block responds to current levels and does not latch a start.</p><p>refusedByTrip and refusedByPermission are independent diagnostic causes during a start request; both may be true simultaneously.</p></html>"));
end StartInterlock;
