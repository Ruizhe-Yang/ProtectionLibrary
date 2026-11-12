within ProtectionLibrary.Criteria;
block OutsideBand "Expose independent low and high hysteresis causes"
parameter Boolean useValidInput=false;
  parameter Boolean failSafe=true;
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Real low=0;
  parameter Real high=10;
  parameter Real resetLow=1;
  parameter Real resetHigh=9;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput below annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput above annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));

initial equation
  assert(low<resetLow and resetLow<=resetHigh and resetHigh<high,"Invalid band and reset limits.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  when {initial(),u<=low,u>=resetLow} then below=if u<=low then true elseif initial() or u>=resetLow then false else pre(below); end when;
  when {initial(),u>=high,u<=resetHigh} then above=if u>=high then true elseif initial() or u<=resetHigh then false else pre(above); end when;
  condition=below or above;
  inputValid=trusted and abs(u)<Modelica.Constants.inf;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-61,34},{63,34}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-61,-18},{63,-18}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-60,3},{-38,7},{-18,44},{3,6},{27,1},{42,-31},{60,6}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Expose independent low and high hysteresis causes.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput inputValid; Modelica.Blocks.Interfaces.BooleanOutput condition; Modelica.Blocks.Interfaces.BooleanOutput request; Modelica.Blocks.Interfaces.RealInput u; Modelica.Blocks.Interfaces.BooleanOutput below; Modelica.Blocks.Interfaces.BooleanOutput above</p><p><b>Parameters</b> parameter Boolean useValidInput=false; parameter Boolean failSafe=true; parameter Real low=0; parameter Real high=10; parameter Real resetLow=1; parameter Real resetHigh=9</p><p><b>Behavior</b> Expose independent low and high hysteresis causes</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The protection request may be a fail-safe response to invalid data. inputValid and condition expose that distinction.</p><p><b>Observables</b> inputValid, condition, request, below, above</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end OutsideBand;
