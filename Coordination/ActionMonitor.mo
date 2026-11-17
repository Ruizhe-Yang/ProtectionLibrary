within ProtectionLibrary.Coordination;
block ActionMonitor "Acknowledgement and timeout of commanded actions"
parameter Modelica.Units.SI.Time timeout(min=0)=0.2 "Allowed delay from a command to its first acknowledgement";
    Modelica.Blocks.Interfaces.BooleanInput command  "Sustained request for the monitored action" annotation(Placement(transformation(origin={-100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanInput measuredAction  "Independently obtained indication that the action has occurred" annotation(Placement(transformation(origin={-100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={-100,-70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput acknowledged(start=false,fixed=true)  "First action accepted within the current request deadline" annotation(Placement(transformation(origin={100,70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,70},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput failed(start=false,fixed=true)  "Retained failure of the current or latest request" annotation(Placement(transformation(origin={100,42},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,42},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput late(start=false,fixed=true)  "First action arrived after the request had failed" annotation(Placement(transformation(origin={100,14},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,14},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput unexpectedAction(start=false,fixed=true)  "Retained occurrence of action without an active command" annotation(Placement(transformation(origin={100,-14},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-14},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput requestTime(unit="s",start=0,fixed=true)  "Time of the latest active command rising edge" annotation(Placement(transformation(origin={100,-42},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-42},extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput actionTime(unit="s",start=0,fixed=true)  "Time of the first observed action for the current or latest request" annotation(Placement(transformation(origin={100,-70},extent={{-10,-10},{10,10}}),iconTransformation(origin={100,-70},extent={{-10,-10},{10,10}})));
  output Integer failureCount(start=0,fixed=true) "Number of requests that have entered failure";
protected
  discrete Boolean observed(start=false,fixed=true) "First action has been observed for this request";
  Boolean due "Active request has reached its acknowledgement deadline";
  discrete Modelica.Units.SI.Time recordedTime(start=0,fixed=true) "Stored time of the first observed action";
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
    Documentation(info="<html><p>Start a new observation on each rising command. An action already true at that instant is accepted immediately. Otherwise, record the first rising measured action and classify it as acknowledged or late. Feedback at the timeout is accepted before failure is declared; the timestamp comparison includes a 1e-8 s numerical allowance.</p><p>Failure is retained within the request and increments <code>failureCount</code> once. New commands reset acknowledgement, failure and lateness for the new request. Removing a command retains the recorded result; a later loss of measured action does not revoke acknowledgement.</p><p><code>unexpectedAction</code> latches whenever action is observed without a command, including when an active action remains at command removal. It has no reset input. Connect measuredAction to an independently obtained action indication.</p></html>"));
end ActionMonitor;
