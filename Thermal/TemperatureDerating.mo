within ProtectionLibrary.Thermal;
block TemperatureDerating "Derate by a linear factor between two absolute temperatures"
parameter Modelica.Units.SI.Temperature Tstart=310;
  parameter Modelica.Units.SI.Temperature Tstop=330;
  parameter Real minFactor(min=0,max=1)=0.5;
    Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput factor annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
initial equation
  assert(Tstart<Tstop and minFactor>=0 and minFactor<=1,"Invalid thermal derating thresholds.");
equation
  factor=1-(1-minFactor)*min(1,max(0,(T-Tstart)/(Tstop-Tstart)));
  y=factor*u;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-62,55},{-62,-40},{65,-40}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-57,38},{-25,38},{27,-18},{61,-18}}, color={0,0,127}, thickness=1.15, pattern=LinePattern.Solid),
        Text(extent={{22,72},{65,48}}, textString="T", textColor={64,64,64}, fontSize=0),
        Line(points={{-25,-39},{-25,48}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{27,-39},{27,48}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Derate by a linear factor between two absolute temperatures.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.RealInput T(unit=\"K\"); Modelica.Blocks.Interfaces.RealInput u; Modelica.Blocks.Interfaces.RealOutput y; Modelica.Blocks.Interfaces.RealOutput factor</p><p><b>Parameters</b> parameter Modelica.Units.SI.Temperature Tstart=310; parameter Modelica.Units.SI.Temperature Tstop=330; parameter Real minFactor(min=0,max=1)=0.5</p><p><b>Behavior</b> Derate by a linear factor between two absolute temperatures</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> y, factor</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThermalCooling\">ProtectionLibrary.Examples.ThermalCooling</a></p></html>"));
end TemperatureDerating;
