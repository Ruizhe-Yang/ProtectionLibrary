within ProtectionLibrary.Criteria;
block SignalValidity "Range and age qualification with an invalid-data policy"
parameter Boolean useValidInput=false "Enable the external validity input";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput  "External qualification of the supplied signal" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Real lower=-1 "Inclusive lower accepted signal value";
  parameter Real upper=1 "Inclusive upper accepted signal value";
  parameter Modelica.Units.SI.Time maxAge(min=0)=0.5 "Maximum accepted data age";
    Modelica.Blocks.Interfaces.RealInput u  "Signal to assess" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput age(unit="s")  "Externally supplied data age" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput outOfRange  "Value lies outside the inclusive accepted interval" annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput expired  "Data age is negative or exceeds maxAge" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted  "Bound external validity, or true when the input is disabled" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));

initial equation
  assert(lower<=upper and maxAge>=0,"Invalid signal limits.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  outOfRange=not (u>=lower and u<=upper);
  expired=not (age>=0 and age<=maxAge);
  condition=outOfRange or expired;
  inputValid=trusted and not outOfRange and not expired;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-62,38},{10,38}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-62,-17},{10,-17}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-59,1},{-40,16},{-22,4},{-3,22},{10,9}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Ellipse(extent={{14,-36},{64,14}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{39,6},{39,12}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{39,-11},{39,15},{39,-11}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{39,-11},{62,-24}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-44.75,-45},{-36.58,-53.6},{-20.67,-32.96}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Accept values in the inclusive interval <code>[lower,upper]</code> and ages in <code>[0,maxAge]</code>. Expose failures through <code>outOfRange</code> and <code>expired</code>; their union is <code>condition</code>. Input validity also requires the optional external validity flag.</p><p>The request is false for valid input and equals <code>failSafe</code> otherwise. Setting failSafe false therefore suppresses the request for range and age failures as well as external invalidity. Read the cause outputs separately when that distinction is required.</p></html>"));
end SignalValidity;
