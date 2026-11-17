within ProtectionLibrary.Thermal;
block TemperatureDerating "Linear temperature-dependent command derating"
parameter Modelica.Units.SI.Temperature Tstart=310 "Temperature at or below which the multiplier is one";
  parameter Modelica.Units.SI.Temperature Tstop=330 "Temperature at or above which the multiplier is minFactor";
  parameter Real minFactor(min=0,max=1)=0.5 "Minimum nonnegative command multiplier";
    Modelica.Blocks.Interfaces.RealInput T(unit="K")  "Absolute temperature used for derating" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput u  "Command before derating" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput y  "Command multiplied by the derating factor" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput factor  "Temperature-dependent command multiplier" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
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
    Documentation(info="<html><p>Reduce factor linearly from one at <code>Tstart</code> to <code>minFactor</code> at <code>Tstop</code>, holding those factors outside the interval. Apply <code>y=factor*u</code> to the supplied command.</p><p>Use absolute temperature in kelvin. The command signal is untyped and retains its application-defined meaning. The block neither limits the input magnitude nor includes hysteresis, a thermal state or physical heat transfer.</p></html>"));
end TemperatureDerating;
