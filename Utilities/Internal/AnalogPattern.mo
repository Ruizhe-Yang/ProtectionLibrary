within ProtectionLibrary.Utilities.Internal;
block AnalogPattern "Supply three and five channel examples with declining validity"
Modelica.Blocks.Interfaces.RealOutput u3[3] annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput u5[5] annotation(Placement(transformation(origin={100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid3[3] annotation(Placement(transformation(origin={100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid5[5] annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
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
    Documentation(info="<html><p><b>Purpose</b> Supply three and five channel examples with declining validity.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealOutput u3[3]; Modelica.Blocks.Interfaces.RealOutput u5[5]; Modelica.Blocks.Interfaces.BooleanOutput valid3[3]; Modelica.Blocks.Interfaces.BooleanOutput valid5[5]</p><p><b>Parameters</b> No tuning parameters; use the declared input contract.</p><p><b>Behavior</b> Supply three and five channel examples with declining validity</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> u3, u5, valid3, valid5</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.AnalogVoting\">ProtectionLibrary.Examples.AnalogVoting</a></p></html>"));
end AnalogPattern;
