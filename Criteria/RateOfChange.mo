within ProtectionLibrary.Criteria;
block RateOfChange "Check an explicitly sampled finite difference"
parameter Boolean useValidInput=false;
  parameter Boolean failSafe=true;
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Modelica.Units.SI.Time samplePeriod(min=0)=0.01;
  parameter Modelica.Units.SI.Time sampleStart=0;
  parameter Real threshold(min=0)=1;
  parameter ProtectionLibrary.Utilities.Types.RateSense sense=ProtectionLibrary.Utilities.Types.RateSense.Absolute;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput rate(start=0,fixed=true) annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput available(start=false,fixed=true) annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  discrete Real last(start=0,fixed=true);
  discrete Boolean seen(start=false,fixed=true);
initial equation
  assert(samplePeriod>0 and threshold>=0,"Invalid rate criterion.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  when sample(sampleStart,samplePeriod) then
    rate=if trusted and pre(seen) then (u-pre(last))/samplePeriod else 0;
    available=trusted and pre(seen);
    last=u;
    seen=trusted;
  end when;
  condition=available and (if sense==ProtectionLibrary.Utilities.Types.RateSense.Absolute then abs(rate) else if sense==ProtectionLibrary.Utilities.Types.RateSense.Rising then rate else -rate)>=threshold;
  inputValid=trusted and abs(u)<Modelica.Constants.inf;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-64,55},{-64,-42},{65,-42}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-56,-31},{44,43}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Ellipse(extent={{-33,-15},{-25,-7}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{23,26},{31,34}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-29,-11},{27,-11},{27,30}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Dash),
        Text(extent={{-26,67},{62,40}}, textString="du/dt", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Check an explicitly sampled finite difference.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput inputValid; Modelica.Blocks.Interfaces.BooleanOutput condition; Modelica.Blocks.Interfaces.BooleanOutput request; Modelica.Blocks.Interfaces.RealInput u; Modelica.Blocks.Interfaces.RealOutput rate(start=0,fixed=true); Modelica.Blocks.Interfaces.BooleanOutput available(start=false,fixed=true)</p><p><b>Parameters</b> parameter Boolean useValidInput=false; parameter Boolean failSafe=true; parameter Modelica.Units.SI.Time samplePeriod(min=0)=0.01; parameter Modelica.Units.SI.Time sampleStart=0; parameter Real threshold(min=0)=1; parameter ProtectionLibrary.Utilities.Types.RateSense sense=ProtectionLibrary.Utilities.Types.RateSense.Absolute</p><p><b>Behavior</b> Check an explicitly sampled finite difference</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The protection request may be a fail-safe response to invalid data. inputValid and condition expose that distinction.</p><p><b>Observables</b> inputValid, condition, request, rate, available</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end RateOfChange;
