within ProtectionLibrary.Fluid;
model BypassValve "Commanded opening of a linear fluid bypass"
replaceable package Medium=Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Real Gopen(unit="kg/(s.Pa)",min=0)=1e-5 "Mass-flow conductance at full opening";
  parameter Real Gleak(unit="kg/(s.Pa)",min=0)=1e-10 "Residual mass-flow conductance at zero opening";
  parameter Modelica.Units.SI.Time openingTime(min=0)=0.05 "First-order actuator time constant; zero selects an immediate response";
  parameter Real initialOpening(min=0,max=1)=0 "Initial actuator state for a nonzero time constant";
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium=Medium)  "First fluid port; positive mass flow enters here" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium=Medium)  "Second fluid port" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealOutput opening(min=0,max=1)  "Valve opening fraction used in the conductance law" annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.MassFlowRate massFlow "Signed mass flow from port_a to port_b";
  Modelica.Units.SI.PressureDifference dp "Pressure at port_a minus pressure at port_b";
  Modelica.Blocks.Interfaces.BooleanInput command  "Request the valve to open" annotation(Placement(transformation(origin={0,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,100},extent={{-10,-10},{10,10}})));
protected
  Real actuator(start=initialOpening,fixed=true) "Actuator state with the declared initial opening";
  Real target "Requested valve opening fraction";
initial equation
  assert(Gopen>0 and Gleak>=0 and Gleak<=Gopen and openingTime>=0,"Invalid valve settings.");
equation

  target=if command then 1 else 0;
  der(actuator)=if openingTime>0 then (target-actuator)/max(openingTime,Modelica.Constants.small) else 0;
  opening=if openingTime>0 then min(1,max(0,actuator)) else target;
  dp=port_a.p-port_b.p;
  massFlow=(Gleak+(Gopen-Gleak)*opening)*dp;
  port_a.m_flow=massFlow;
  port_b.m_flow=-massFlow;
  port_a.h_outflow=inStream(port_b.h_outflow);
  port_b.h_outflow=inStream(port_a.h_outflow);
  port_a.Xi_outflow=inStream(port_b.Xi_outflow);
  port_b.Xi_outflow=inStream(port_a.Xi_outflow);
  port_a.C_outflow=inStream(port_b.C_outflow);
  port_b.C_outflow=inStream(port_a.C_outflow);
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-100,0},{-32,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{32,0},{100,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Polygon(points={{-32,24},{-32,-24},{32,24},{32,-24},{-32,24}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,0},{0,30}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Rectangle(extent={{-20,32},{20,56}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-15,44},{15,44}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-24,-44},{24,-44}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p>Set the target opening to one while command=true and zero otherwise. With openingTime&gt;0, the actuator approaches the target exponentially; openingTime is a time constant, not a full-stroke duration. With openingTime=0, opening follows the target immediately.</p><p>Mass flow is <code>(Gleak+(Gopen-Gleak)*opening)*dp</code>, positive from port_a to port_b. Redeclare a compatible Medium at both connections. The linear, isenthalpic flow path transports composition and trace substances in either direction and has no fluid storage; a positive Gleak permits leakage.</p></html>"));
end BypassValve;
