within ProtectionLibrary.Criteria;
block SignalValidity "Expose range, freshness and external qualification failures"
parameter Boolean useValidInput=false;
  parameter Boolean failSafe=true;
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Real lower=-1;
  parameter Real upper=1;
  parameter Modelica.Units.SI.Time maxAge(min=0)=0.5;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput age(unit="s") annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput outOfRange annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput expired annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));

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
    Documentation(info="<html><p><b>Purpose</b> Expose range, freshness and external qualification failures.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput inputValid; Modelica.Blocks.Interfaces.BooleanOutput condition; Modelica.Blocks.Interfaces.BooleanOutput request; Modelica.Blocks.Interfaces.RealInput u; Modelica.Blocks.Interfaces.RealInput age(unit=\"s\"); Modelica.Blocks.Interfaces.BooleanOutput outOfRange; Modelica.Blocks.Interfaces.BooleanOutput expired</p><p><b>Parameters</b> parameter Boolean useValidInput=false; parameter Boolean failSafe=true; parameter Real lower=-1; parameter Real upper=1; parameter Modelica.Units.SI.Time maxAge(min=0)=0.5</p><p><b>Behavior</b> Expose range, freshness and external qualification failures</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The protection request may be a fail-safe response to invalid data. inputValid and condition expose that distinction.</p><p><b>Observables</b> inputValid, condition, request, outOfRange, expired</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end SignalValidity;
