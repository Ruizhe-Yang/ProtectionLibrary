within ProtectionLibrary.Utilities.Internal;
block AnalogPattern "Fixed analogue values with declining qualification"
Modelica.Blocks.Interfaces.RealOutput u3[3]  "Fixed three-channel measurement vector" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput u5[5]  "Fixed five-channel measurement vector" annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid3[3]  "Qualification of the three-channel vector" annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid5[5]  "Qualification of the five-channel vector" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
equation
  u3={1,1.1,10};
  u5={1,1.1,1.2,1.3,10};
  valid3=if time<1 then fill(true,3) elseif time<2 then {true,true,false} elseif time<3 then {true,false,false} else fill(false,3);
  valid5=if time<1 then fill(true,5) elseif time<2 then {true,true,true,true,false} elseif time<3 then {true,true,false,false,false} else fill(false,5);
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,-30},{66,-30}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-56,-30},{-56,-24}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-60,-28},{-52,-20}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-28,-30},{-28,-3}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-32,-7},{-24,1}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-30},{0,9}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-4,5},{4,13}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{28,-30},{28,28}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{24,24},{32,32}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{56,-30},{56,40}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{52,36},{60,44}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-62,8},{62,8}}, color={0,0,127}, thickness=1, pattern=LinePattern.Dash),
        Line(points={{-55,-52},{1,-52},{1,-63},{57,-63}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Supply the vectors <code>{1,1.1,10}</code> and <code>{1,1.1,1.2,1.3,10}</code>. Qualification changes at 1, 2 and 3 s: the three-channel count falls from 3 to 2, 1 and 0; the five-channel count falls from 5 to 4, 2 and 0.</p><p>The values stay constant. This prescribed pattern demonstrates channel exclusion and unavailable-fusion handling.</p></html>"));
end AnalogPattern;
