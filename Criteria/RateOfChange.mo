within ProtectionLibrary.Criteria;
block RateOfChange "Sampled finite-difference rate criterion"
parameter Boolean useValidInput=false "Enable the external validity input";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput  "External qualification of the supplied signal" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Modelica.Units.SI.Time samplePeriod(min=0)=0.01 "Positive interval between rate samples";
  parameter Modelica.Units.SI.Time sampleStart=0 "First scheduled sample time";
  parameter Real threshold(min=0)=1 "Inclusive threshold in signal units per second";
  parameter ProtectionLibrary.Utilities.Types.RateSense sense=ProtectionLibrary.Utilities.Types.RateSense.Absolute "Absolute, rising or falling rate selection";
    Modelica.Blocks.Interfaces.RealInput u  "Signal to assess" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput rate(start=0,fixed=true)  "Held finite-difference rate from the latest sample" annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput available(start=false,fixed=true)  "Two consecutive samples have true validity flags" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted  "Bound external validity, or true when the input is disabled" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  discrete Real last(start=0,fixed=true) "Previous sampled signal value";
  discrete Boolean seen(start=false,fixed=true) "Validity flag at the previous sample";
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
    Documentation(info="<html><p>At <code>sampleStart+k*samplePeriod</code>, calculate the difference between consecutive externally trusted samples divided by the positive sample period. The first trusted sample establishes history; <code>available</code> becomes true only after a second consecutive trusted sample. An untrusted sample breaks that sequence.</p><p>Select absolute, rising or falling rate and compare it inclusively with <code>threshold</code>. Rate and availability are held between samples. The request uses the current finite-value and validity check; sampled history and availability use the validity flag alone. Supply finite samples or mark them invalid explicitly.</p></html>"));
end RateOfChange;
