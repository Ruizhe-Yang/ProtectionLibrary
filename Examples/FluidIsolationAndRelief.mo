within ProtectionLibrary.Examples;
model FluidIsolationAndRelief "Vent an independently connected relief branch from a compressible vessel"
  extends Modelica.Icons.Example;
  replaceable package Medium=Modelica.Media.Air.DryAirNasa;
  inner Modelica.Fluid.System system annotation(Placement(transformation(origin={-305,200},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.RealExpression openValve(y=1) annotation(Placement(transformation(origin={-239,209},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression isolate(y=time>=8) annotation(Placement(transformation(origin={-84,206},extent={{-12,-12},{12,12}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT protectedSource(redeclare package Medium=Medium,nPorts=1,p=300000,T=293.15) annotation(Placement(transformation(origin={-288,108},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Fluid.Valves.ValveLinear protectedInlet(redeclare package Medium=Medium,dp_nominal=100000,m_flow_nominal=0.01) annotation(Placement(transformation(origin={-191,108},extent={{-14,-14},{14,14}},rotation=0)));
  ProtectionLibrary.Fluid.IsolationValve isolation(redeclare package Medium=Medium,Gopen=1e-5,openingTime=0.02) annotation(Placement(transformation(origin={-98,108},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume protectedVolume(redeclare package Medium=Medium,V=0.005,nPorts=3,use_portsData=false,p_start=100000,T_start=293.15,massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(Placement(transformation(origin={10,138},extent={{-20,-20},{20,20}},rotation=0)));
  Modelica.Fluid.Valves.ValveLinear protectedOutlet(redeclare package Medium=Medium,dp_nominal=100000,m_flow_nominal=0.004) annotation(Placement(transformation(origin={143,108},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT protectedAmbient(redeclare package Medium=Medium,nPorts=2,p=100000,T=293.15) annotation(Placement(transformation(origin={277,108},extent={{-14,-14},{14,14}},rotation=180)));
  ProtectionLibrary.Fluid.ReliefValve relief(redeclare package Medium=Medium,openPressure=100000,closePressure=80000,Gopen=3e-7,openingTime=0.015) annotation(Placement(transformation(origin={150,25},extent={{-16,-16},{16,16}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT referenceSource(redeclare package Medium=Medium,nPorts=1,p=300000,T=293.15) annotation(Placement(transformation(origin={-288,-115},extent={{-13,-13},{13,13}},rotation=0)));
  Modelica.Fluid.Valves.ValveLinear referenceInlet(redeclare package Medium=Medium,dp_nominal=100000,m_flow_nominal=0.01) annotation(Placement(transformation(origin={-191,-115},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Fluid.Vessels.ClosedVolume referenceVolume(redeclare package Medium=Medium,V=0.005,nPorts=3,use_portsData=false,p_start=100000,T_start=293.15,massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(Placement(transformation(origin={10,-85},extent={{-20,-20},{20,20}},rotation=0)));
  Modelica.Fluid.Valves.ValveLinear referenceOutlet(redeclare package Medium=Medium,dp_nominal=100000,m_flow_nominal=0.004) annotation(Placement(transformation(origin={143,-115},extent={{-14,-14},{14,14}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT referenceAmbient(redeclare package Medium=Medium,nPorts=2,p=100000,T=293.15) annotation(Placement(transformation(origin={277,-115},extent={{-14,-14},{14,14}},rotation=180)));
equation
  connect(protectedSource.ports[1],protectedInlet.port_a) annotation(Line(points={{-275,108},{-205,108}},color={0,127,255}));
  connect(openValve.y,protectedInlet.opening) annotation(Line(points={{-225.8,209},{-191,209},{-191,119.2}},color={0,0,127}));
  connect(openValve.y,protectedOutlet.opening) annotation(Line(points={{-225.8,209},{-220.8,209},{-220.8,166.6},{143,166.6},{143,119.2}},color={0,0,127}));
  connect(protectedInlet.port_b,isolation.port_a) annotation(Line(points={{-177,108},{-112,108}},color={0,127,255}));
  connect(isolation.port_b,protectedVolume.ports[1]) annotation(Line(points={{-84,108},{10,108},{10,118}},color={0,127,255}));
  connect(isolate.y,isolation.command) annotation(Line(points={{-70.8,206},{-65.8,206},{-98,206},{-98,122}},color={255,0,255}));
  connect(protectedVolume.ports[2],protectedOutlet.port_a) annotation(Line(points={{10,118},{10,108},{129,108}},color={0,127,255}));
  connect(protectedOutlet.port_b,protectedAmbient.ports[1]) annotation(Line(points={{157,108},{263,108}},color={0,127,255}));
  connect(protectedVolume.ports[3],relief.port_a) annotation(Line(points={{10,118},{10,25},{134,25}},color={0,127,255}));
  connect(relief.port_b,protectedAmbient.ports[2]) annotation(Line(points={{166,25},{214.5,25},{214.5,108},{263,108}},color={0,127,255}));
  connect(referenceSource.ports[1],referenceInlet.port_a) annotation(Line(points={{-275,-115},{-205,-115}},color={0,127,255}));
  connect(openValve.y,referenceInlet.opening) annotation(Line(points={{-225.8,209},{-220.8,209},{-220.8,-98.8},{-191,-98.8},{-191,-103.8}},color={0,0,127}));
  connect(openValve.y,referenceOutlet.opening) annotation(Line(points={{-225.8,209},{-220.8,209},{-220.8,6},{143,6},{143,-103.8}},color={0,0,127}));
  connect(referenceInlet.port_b,referenceVolume.ports[1]) annotation(Line(points={{-177,-115},{10,-115},{10,-105}},color={0,127,255}));
  connect(referenceVolume.ports[2],referenceOutlet.port_a) annotation(Line(points={{10,-105},{10,-115},{129,-115}},color={0,127,255}));
  connect(referenceOutlet.port_b,referenceAmbient.ports[1]) annotation(Line(points={{157,-115},{263,-115}},color={0,127,255}));
  annotation(experiment(StartTime=0,StopTime=10,Interval=0.01,Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-360,-240},{360,240}},preserveAspectRatio=true),graphics={Text(extent={{-33,203},{267,189}},textString="Protection with isolation and a relief branch",textColor={34,61,73}),Text(extent={{-32.5,-50},{232.5,-64}},textString="Matched reference pressure network",textColor={34,61,73})}),
    Documentation(info="<html><p><b>Purpose</b> Vent an independently connected relief branch from a compressible vessel</p><p><b>Interfaces</b> Instances and connections are shown in the Diagram layer.</p><p><b>Parameters</b> Default values are shown in the component modifiers.</p><p><b>Behavior</b> Each vessel starts at 100000 Pa. The relief threshold is 200000 Pa absolute for the specified environment. The inlet isolation command begins at 8 s.</p><p><b>Initialization</b> All initial conditions are explicit in the source and component modifiers.</p><p><b>Activation and recovery</b> The given time windows follow the simulation time axis.</p><p><b>Limitations</b> This demonstration uses the declared inputs, initial conditions and idealized components.</p><p><b>Observables</b> protectedVolume.medium.p, referenceVolume.medium.p, relief.massFlow and isolation.opening.</p></html>"));
end FluidIsolationAndRelief;
