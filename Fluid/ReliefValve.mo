within ProtectionLibrary.Fluid;
model ReliefValve "Open a finite relief path at a hysteretic pressure threshold"
replaceable package Medium=Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  parameter Real Gopen(unit="kg/(s.Pa)",min=0)=1e-5;
  parameter Real Gleak(unit="kg/(s.Pa)",min=0)=1e-10;
  parameter Modelica.Units.SI.Time openingTime(min=0)=0.05;
  parameter Real initialOpening(min=0,max=1)=0;
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealOutput opening(min=0,max=1) annotation(Placement(transformation(origin={0,-100},extent={{-10,-10},{10,10}}),iconTransformation(origin={0,-100},extent={{-10,-10},{10,10}})));
  Modelica.Units.SI.MassFlowRate massFlow;
  Modelica.Units.SI.PressureDifference dp;
  parameter Modelica.Units.SI.PressureDifference openPressure=100000;
  parameter Modelica.Units.SI.PressureDifference closePressure=80000;
  output Boolean reliefRequest(start=false,fixed=true);
protected
  Real actuator(start=initialOpening,fixed=true);
  Real target;
initial equation
  assert(Gopen>0 and Gleak>=0 and Gleak<=Gopen and openingTime>=0 and openPressure>closePressure and closePressure>=0,"Invalid valve settings.");
equation
  when {initial(),dp>=openPressure,dp<=closePressure} then
    reliefRequest=if dp>=openPressure then true elseif initial() or dp<=closePressure then false else pre(reliefRequest);
  end when;
  target=if reliefRequest then 1 else 0;
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
        Line(points={{0,30},{-12,37},{12,44},{-12,51},{12,58},{0,65}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-20,66},{20,66}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-34,-37},{34,-64}}, textString="dp", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Open a finite relief path at a hysteretic pressure threshold.</p><p><b>Interfaces</b> Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium=Medium); Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium=Medium); Modelica.Blocks.Interfaces.RealOutput opening(min=0,max=1); output Boolean reliefRequest(start=false,fixed=true)</p><p><b>Parameters</b> replaceable package Medium=Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby Modelica.Media.Interfaces.PartialMedium; parameter Real Gopen(unit=\"kg/(s.Pa)\",min=0)=1e-5; parameter Real Gleak(unit=\"kg/(s.Pa)\",min=0)=1e-10; parameter Modelica.Units.SI.Time openingTime(min=0)=0.05; parameter Real initialOpening(min=0,max=1)=0; parameter Modelica.Units.SI.PressureDifference openPressure=100000; parameter Modelica.Units.SI.PressureDifference closePressure=80000</p><p><b>Behavior</b> Open a finite relief path at a hysteretic pressure threshold</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> A linear no-storage valve approximation. Connect the intended environment explicitly. Mass, enthalpy and composition follow either flow direction.</p><p><b>Observables</b> opening, reliefRequest</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.FluidIsolationAndRelief\">ProtectionLibrary.Examples.FluidIsolationAndRelief</a></p></html>"));
end ReliefValve;
