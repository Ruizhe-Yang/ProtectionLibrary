within ProtectionLibrary.Criteria;
block Watchdog "Watch for a genuinely new count or heartbeat edge"
parameter Boolean useValidInput=false;
  parameter Boolean failSafe=true;
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Boolean useCount=true;
  parameter Modelica.Units.SI.Time timeout(min=0)=0.5;
  parameter Modelica.Units.SI.Time graceTime(min=0)=1;
    Modelica.Blocks.Interfaces.IntegerInput count if useCount annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput heartbeat if not useCount annotation(Placement(transformation(origin={-100,35},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,35},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput lastSeen(unit="s",start=0,fixed=true) annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerInput updates annotation(Placement(transformation(origin={-100,-35},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-35},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput pulse annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  discrete Modelica.Units.SI.Time began(start=0,fixed=true);
initial equation
  assert(timeout>=0 and graceTime>=0,"Invalid watchdog timing.");
equation
  connect(valid,trusted);
  if not useValidInput then trusted=true; end if;

  connect(count,updates);
  connect(heartbeat,pulse);
  if useCount then pulse=false; else updates=0; end if;
  when {initial(),updates>pre(updates),pulse} then lastSeen=time; end when;
  when initial() then began=time; end when;
  condition=time>=began+graceTime and time>=lastSeen+timeout;
  inputValid=trusted;
  request=if inputValid then condition else failSafe;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,15},{-58,15},{-58,43},{-48,43},{-48,15},{-31,15},{-31,43},{-21,43},{-21,15},{53,15}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-21,-16},{54,-16}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Line(points={{54,43},{54,-30}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-2,-28},{61,-52}}, textString="t >", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Watch for a genuinely new count or heartbeat edge.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput; Modelica.Blocks.Interfaces.BooleanOutput inputValid; Modelica.Blocks.Interfaces.BooleanOutput condition; Modelica.Blocks.Interfaces.BooleanOutput request; Modelica.Blocks.Interfaces.IntegerInput count if useCount; Modelica.Blocks.Interfaces.BooleanInput heartbeat if not useCount; Modelica.Blocks.Interfaces.RealOutput lastSeen(unit=\"s\",start=0,fixed=true)</p><p><b>Parameters</b> parameter Boolean useValidInput=false; parameter Boolean failSafe=true; parameter Boolean useCount=true; parameter Modelica.Units.SI.Time timeout(min=0)=0.5; parameter Modelica.Units.SI.Time graceTime(min=0)=1</p><p><b>Behavior</b> Watch for a genuinely new count or heartbeat edge</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The protection request may be a fail-safe response to invalid data. inputValid and condition expose that distinction.</p><p><b>Observables</b> inputValid, condition, request, lastSeen</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.ThresholdLatchReset\">ProtectionLibrary.Examples.ThresholdLatchReset</a></p></html>"));
end Watchdog;
