within ProtectionLibrary.Criteria;
block HighLimit "Request on a limit with independent hysteretic reset"
parameter Boolean useValidInput=false;
  parameter Boolean failSafe=true;
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));
  parameter Real tripLevel=10;
  parameter Real resetLevel=8;
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));

initial equation
  assert(resetLevel<tripLevel,"Invalid trip/reset ordering.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  when {initial(),u>=tripLevel,u<=resetLevel} then
    condition=if u>=tripLevel then true elseif initial() or u<=resetLevel then false else pre(condition);
  end when;
  inputValid=trusted and abs(u)<Modelica.Constants.inf;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,57},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-58,-24},{17,-24},{17,35},{60,35}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{60,26},{-19,26},{-19,-33},{-58,-33}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-19,10},{-19,-8}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{17,-7},{17,12}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-19,-48},{-19,-39}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{17,-48},{17,-39}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Text(extent={{-65,-50},{65,-75}}, textString="> hi", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Request on a limit with independent hysteretic reset.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput inputValid; Modelica.Blocks.Interfaces.BooleanOutput condition; Modelica.Blocks.Interfaces.BooleanOutput request; Modelica.Blocks.Interfaces.RealInput u</p><p><b>Parameters</b> parameter Boolean useValidInput=false; parameter Boolean failSafe=true; parameter Real tripLevel=10; parameter Real resetLevel=8</p><p><b>Behavior</b> Request on a limit with independent hysteretic reset</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The protection request may be a fail-safe response to invalid data. inputValid and condition expose that distinction.</p><p><b>Observables</b> inputValid, condition, request</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end HighLimit;
