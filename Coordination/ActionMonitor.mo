within ProtectionLibrary.Coordination;
block ActionMonitor "Compare each command with measured action before deciding timeout"
parameter Modelica.Units.SI.Time timeout(min=0)=0.2;
    Modelica.Blocks.Interfaces.BooleanInput command annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput measuredAction annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput acknowledged(start=false,fixed=true) annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput failed(start=false,fixed=true) annotation(Placement(transformation(origin={100,42},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,42},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput late(start=false,fixed=true) annotation(Placement(transformation(origin={100,14},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,14},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput unexpectedAction(start=false,fixed=true) annotation(Placement(transformation(origin={100,-14},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-14},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput requestTime(unit="s",start=0,fixed=true) annotation(Placement(transformation(origin={100,-42},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-42},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput actionTime(unit="s",start=0,fixed=true) annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
  output Integer failureCount(start=0,fixed=true);
protected
  discrete Boolean observed(start=false,fixed=true);
  Boolean due;
  discrete Modelica.Units.SI.Time recordedTime(start=0,fixed=true);
initial equation
  assert(timeout>=0,"Negative action timeout.");
equation
  when {initial(),command} then requestTime=if command then time else 0; end when;
  due=command and time>=requestTime+timeout;
  actionTime=if observed then recordedTime else 0;
algorithm
  when {initial(),command,not command,measuredAction,due} then
    if not command then
      unexpectedAction:=pre(unexpectedAction) or measuredAction;
    elseif initial() or time<=requestTime then
      observed:=measuredAction;
      recordedTime:=if measuredAction then time else 0;
      acknowledged:=measuredAction;
      failed:=not measuredAction and timeout<=0;
      late:=false;
      failureCount:=pre(failureCount)+(if failed then 1 else 0);
    else
      observed:=pre(observed) or measuredAction;
      if measuredAction and not pre(observed) then
        recordedTime:=time;
        acknowledged:=not pre(failed) and time<=requestTime+timeout+1e-8;
        late:=not acknowledged;
      end if;
      failed:=pre(failed) or ((due or late) and not acknowledged);
      failureCount:=pre(failureCount)+(if failed and not pre(failed) then 1 else 0);
    end if;
  end when;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,38},{-43,38},{-43,57},{61,57}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-8},{12,-8},{12,12},{61,12}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{35,66},{35,-40}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Dash),
        Line(points={{-43,-30},{12,-30}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-62,27},{-15,9}}, textString="cmd", textColor={64,64,64}, fontSize=0),
        Text(extent={{-62,-42},{-18,-67}}, textString="fb", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Compare each command with measured action before deciding timeout.</p><p><b>Interfaces</b> Modelica.Blocks.Interfaces.BooleanInput command; Modelica.Blocks.Interfaces.BooleanInput measuredAction; Modelica.Blocks.Interfaces.BooleanOutput acknowledged(start=false,fixed=true); Modelica.Blocks.Interfaces.BooleanOutput failed(start=false,fixed=true); Modelica.Blocks.Interfaces.BooleanOutput late(start=false,fixed=true); Modelica.Blocks.Interfaces.BooleanOutput unexpectedAction(start=false,fixed=true); Modelica.Blocks.Interfaces.RealOutput requestTime(unit=\"s\",start=0,fixed=true); Modelica.Blocks.Interfaces.RealOutput actionTime(unit=\"s\",start=0,fixed=true); output Integer failureCount(start=0,fixed=true)</p><p><b>Parameters</b> parameter Modelica.Units.SI.Time timeout(min=0)=0.2</p><p><b>Behavior</b> A qualifying feedback edge at the deadline is accepted before timeout. A withdrawn command ends that request and leaves the observed evidence intact.</p><p><b>Initialization</b> The declared start values and initialization equations apply.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> The measured input must be independent of command. This component reports evidence and does not assert physical completion.</p><p><b>Observables</b> acknowledged, failed, late, unexpectedAction, requestTime, actionTime, failureCount</p><p><b>Example</b> <a href=\"modelica://ProtectionLibrary.Examples.CommandPriorityAndInterlock\">ProtectionLibrary.Examples.CommandPriorityAndInterlock</a></p></html>"));
end ActionMonitor;
