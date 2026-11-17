within ProtectionLibrary.Utilities.Internal;
block PriorityPattern "Prescribed command levels, requests and permissions"
Modelica.Blocks.Interfaces.RealOutput normalValue  "Prescribed normal command" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput degradedValue  "Prescribed degraded command" annotation(Placement(transformation(origin={100,52.5},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,52.5},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput protectionValue  "Prescribed protection command" annotation(Placement(transformation(origin={100,35},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,35},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput emergencyValue  "Prescribed emergency command" annotation(Placement(transformation(origin={100,17.5},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,17.5},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput degraded  "Scheduled degraded-operation request" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput protection  "Scheduled protection request" annotation(Placement(transformation(origin={100,-17.5},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-17.5},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput emergency  "Scheduled emergency request" annotation(Placement(transformation(origin={100,-35},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-35},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput start  "Scheduled start request" annotation(Placement(transformation(origin={100,-52.5},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-52.5},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput permissions[2]  "Two scheduled start permissions" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
equation
  normalValue=1;
  degradedValue=0.6;
  protectionValue=0;
  emergencyValue=-1;
  degraded=time>=1;
  protection=time>=2 and time<4;
  emergency=time>=3 and time<3.5;
  start=time>=0.5;
  permissions={time>=0.6,time<2 or time>=4};
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-68,63},{-45,39}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,51},{-9,51},{27,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-68,29},{-45,5}}, textString="2", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,17},{-9,17},{27,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-68,-5},{-45,-29}}, textString="3", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,-17},{-9,-17},{27,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-68,-39},{-45,-63}}, textString="4", textColor={64,64,64}, fontSize=0),
        Line(points={{-39,-51},{-9,-51},{27,0}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{27,0},{67,0}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-56,-72},{-20,-72},{-20,-62},{18,-62},{18,-72},{53,-72}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Supply normal, degraded, protection and emergency command values of 1, 0.6, 0 and -1. The degraded request starts at 1 s, protection applies on <code>[2,4)</code> s, and emergency on <code>[3,3.5)</code> s.</p><p>The start request rises at 0.5 s. The first permission becomes true at 0.6 s; the second is false on <code>[2,4)</code> s. The pattern supplies requests only; the receiving coordinator applies priority and interlock logic.</p></html>"));
end PriorityPattern;
