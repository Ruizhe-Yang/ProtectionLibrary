within ProtectionLibrary.Criteria;
block Watchdog "Timeout since a count increase or heartbeat edge"
parameter Boolean useValidInput=false "Enable the external validity input";
  parameter Boolean failSafe=true "Request value used when input validity is false";
  Modelica.Blocks.Interfaces.BooleanInput valid if useValidInput  "External qualification of the supplied signal" annotation(Placement(transformation(origin={70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={70,100},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput inputValid  "True when the criterion has accepted its required inputs" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput condition  "Evaluated cause before the invalid-input policy" annotation(Placement(transformation(origin={100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput request  "Protection request after the invalid-input policy" annotation(Placement(transformation(origin={-70,100},extent={{-10,-10},{10,10}}),iconTransformation(origin={-70,100},extent={{-10,-10},{10,10}})));

  parameter Boolean useCount=true "Select a count input instead of a Boolean heartbeat";
  parameter Modelica.Units.SI.Time timeout(min=0)=0.5 "Allowed time since initialisation or the latest activity";
  parameter Modelica.Units.SI.Time graceTime(min=0)=1 "Initial interval before timeout qualification is allowed";
    Modelica.Blocks.Interfaces.IntegerInput count if useCount  "Count whose strict increases indicate new activity" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput heartbeat if not useCount  "Heartbeat whose rising edges indicate new activity" annotation(Placement(transformation(origin={-100,35},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,35},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput lastSeen(unit="s",start=0,fixed=true)  "Time of initialisation or the latest accepted activity" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput trusted  "Bound external validity, or true when the input is disabled" annotation(Placement(transformation(origin={-100,0},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,0},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerInput updates  "Bound activity count" annotation(Placement(transformation(origin={-100,-35},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-35},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput pulse  "Bound Boolean heartbeat" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  discrete Modelica.Units.SI.Time began(start=0,fixed=true) "Simulation initialisation time";
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
    Documentation(info="<html><p>Select either an integer count or a Boolean heartbeat. Refresh <code>lastSeen</code> on a strict count increase or a heartbeat rising edge. Initialisation sets the initial reference time; a held heartbeat or a decreasing count does not refresh it.</p><p>Condition becomes true once both the initial <code>graceTime</code> and the timeout since the latest refresh have elapsed. The optional validity flag selects the request policy but does not gate refresh events. A later refresh clears the timeout condition until its next deadline.</p></html>"));
end Watchdog;
