within ProtectionLibrary.Utilities.Internal;
block VotePattern "Supply independent vote and qualification vectors"
Modelica.Blocks.Interfaces.BooleanOutput votes[5] annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid[5] annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
equation
  votes=if time<1 then {true,false,true,false,false} elseif time<2 then fill(false,5) else {false,false,true,true,false};
  valid=if time<2 then fill(true,5) elseif time<3 then {false,true,true,true,true} else fill(false,5);
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-63,40},{-36,40},{-36,59},{6,59},{6,40},{61,40}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-63,-2},{-15,-2},{-15,17},{33,17},{33,-2},{61,-2}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-63,-46},{19,-46},{19,-27},{61,-27}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Supply independent vote and qualification vectors.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanOutput votes[5]; Modelica.Blocks.Interfaces.BooleanOutput valid[5]</p><p><b>Parameters</b> No tuning parameters; use the declared input contract.</p><p><b>Behavior</b> Supply independent vote and qualification vectors</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> votes, valid</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.BooleanVoting\">ProtectionLibrary.Examples.BooleanVoting</a></p></html>"));
end VotePattern;
