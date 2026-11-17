within ProtectionLibrary.Criteria;
block Persistence "Continuous dwell qualification of a Boolean condition"
parameter Boolean useValidInput=false "Enable the external validity input";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput  "External qualification of the supplied signal" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Modelica.Units.SI.Time holdTime(min=0)=0.2 "Required continuous true and valid interval";
    Modelica.Blocks.Interfaces.BooleanInput u  "Boolean condition to qualify" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted  "Bound external validity, or true when the input is disabled" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Boolean pending "True while the condition is externally valid";
  discrete Modelica.Units.SI.Time since(start=0,fixed=true) "Start of the current qualification interval";
initial equation
  assert(holdTime>=0,"Negative persistence time.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  pending=u and trusted;
  when {initial(),pending} then since=time; end when;
  condition=pending and time>=since+holdTime;
  inputValid=trusted;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,20},{-43,20},{-43,47},{57,47}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-27},{9,-27},{9,0},{57,0}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-43,8},{9,8}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Line(points={{-43,14},{-43,-34}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Line(points={{9,14},{9,-34}}, color={128,128,128}, thickness=0.4, pattern=LinePattern.Dash),
        Text(extent={{-29,6},{-5,-18}}, textString="t", textColor={64,64,64}, fontSize=0),
        Text(extent={{-65,-50},{65,-75}}, textString="dwell", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Qualify <code>u</code> only after it and the optional validity input have remained true continuously for <code>holdTime</code>. Initialisation starts a fresh dwell. A false condition or invalid input clears qualification, and the next accepted true interval starts again.</p><p><code>condition</code> remains true while the qualifying inputs remain true. <code>request</code> takes <code>failSafe</code> whenever input validity is false, so that invalid-data response bypasses the dwell.</p></html>"));
end Persistence;
