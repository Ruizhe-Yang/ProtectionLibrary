within ProtectionLibrary.Utilities.Internal;
block VotePattern "Fixed Boolean vote and qualification schedule"
Modelica.Blocks.Interfaces.BooleanOutput votes[5]  "Five prescribed Boolean channel requests" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid[5]  "Qualification flags for the prescribed requests" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
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
    Documentation(info="<html><p>Supply five votes: <code>{true,false,true,false,false}</code> before 1 s, all false from 1 to 2 s, then <code>{false,false,true,true,false}</code>. All channels qualify before 2 s; the first becomes unqualified from 2 to 3 s, then every channel becomes unqualified.</p><p>Use the pattern to compare vote thresholds and invalid-channel substitution.</p></html>"));
end VotePattern;
