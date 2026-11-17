within ProtectionLibrary.Coordination;
block PrioritySelector "Fixed-priority selection of real commands"
Modelica.Blocks.Interfaces.RealInput normalValue  "Nominal command with the lowest priority" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput degradedValue  "Command selected by the degraded request" annotation(Placement(transformation(origin={-100,46.66667},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,46.66667},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput protectionValue  "Command selected by the protection request" annotation(Placement(transformation(origin={-100,23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput emergencyValue  "Command with the highest priority" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput degraded  "Request the degraded command" annotation(Placement(transformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-23.33333},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput protection  "Request the protective command" annotation(Placement(transformation(origin={-100,-46.66667},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-46.66667},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput emergency  "Request the emergency command" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y  "Selected real command" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput selectedSource  "Selected source: normal 1, degraded 2, protection 3, emergency 4" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
equation
  selectedSource=if emergency then 4 elseif protection then 3 elseif degraded then 2 else 1;
  y=if emergency then emergencyValue elseif protection then protectionValue elseif degraded then degradedValue else normalValue;
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
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Select emergency, protection, degraded or normal values in that order. <code>selectedSource</code> reports 4, 3, 2 or 1 respectively. All values must use a consistent application unit.</p><p>The selection is combinational; changes in source or command can produce immediate output jumps.</p></html>"));
end PrioritySelector;
