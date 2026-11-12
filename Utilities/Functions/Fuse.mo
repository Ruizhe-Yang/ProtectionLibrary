within ProtectionLibrary.Utilities.Functions;
function Fuse "Evaluate one finite analog fusion from qualified inputs"
  extends Modelica.Icons.Function;
input Real u[:];
  input Boolean valid[size(u,1)];
  input Real weights[size(u,1)];
  input Integer minValid;
  input Integer trimEachSide;
  input ProtectionLibrary.Utilities.Types.AnalogMethod method;
  output Real value;
  output Integer nValid;
  output Boolean available;
protected
  Real ordered[size(u,1)];
  Real sumValue;
  Real weightTotal;
  Real weighted;
  Real selected;
  Integer k;
algorithm
  nValid:=0; ordered:=fill(0,size(u,1));
  sumValue:=0; weightTotal:=0; weighted:=0;
  for i in 1:size(u,1) loop
    if valid[i] and abs(u[i])<Modelica.Constants.inf then
      nValid:=nValid+1;
      ordered[nValid]:=u[i];
      sumValue:=sumValue+u[i];
      weightTotal:=weightTotal+weights[i];
      weighted:=weighted+weights[i]*u[i];
    end if;
  end for;
  available:=nValid>=minValid;
  value:=0;
  if available then
    if method==ProtectionLibrary.Utilities.Types.AnalogMethod.Mean then value:=sumValue/nValid;
    elseif method==ProtectionLibrary.Utilities.Types.AnalogMethod.WeightedMean then
      available:=weightTotal>0;
      if available then value:=weighted/weightTotal; end if;
    else
      for i in 2:nValid loop
        selected:=ordered[i]; k:=i-1;
        while k>0 loop
          if ordered[k]<=selected then break; end if;
          ordered[k+1]:=ordered[k]; k:=k-1;
        end while;
        ordered[k+1]:=selected;
      end for;
      if method==ProtectionLibrary.Utilities.Types.AnalogMethod.Median then
        value:=if mod(nValid,2)==0 then 0.5*(ordered[div(nValid,2)]+ordered[div(nValid,2)+1]) else ordered[div(nValid,2)+1];
      else
        available:=nValid-2*trimEachSide>=minValid;
        if available then value:=sum(ordered[j] for j in trimEachSide+1:nValid-trimEachSide)/(nValid-2*trimEachSide); end if;
      end if;
    end if;
  end if;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(extent={{-100,-100},{100,100}}, lineColor={108,88,49}, fillColor={255,215,136}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-18,79},{18,47}}, textString="f", textColor={108,88,49}, fontSize=0),
        Line(points={{-48.84,-32.2},{48.84,-32.2}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-41.44,-32.2},{-41.44,-27.76}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-44.4,-30.72},{-38.48,-24.8}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-20.72,-32.2},{-20.72,-12.22}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-23.68,-15.18},{-17.76,-9.26}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-32.2},{0,-3.34}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-2.96,-6.3},{2.96,-0.38}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{20.72,-32.2},{20.72,10.72}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{17.76,7.76},{23.68,13.68}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{41.44,-32.2},{41.44,19.6}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{38.48,16.64},{44.4,22.56}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{29.97,-37.38},{34.188,-41.82},{42.402,-31.164}}, color={75,138,73}, thickness=1.5, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(info="<html><p><b>Purpose</b> Evaluate one finite analog fusion from qualified inputs.</p><p><b>Interfaces</b> input Real u[:]; input Boolean valid[size(u,1)]; input Real weights[size(u,1)]; input Integer minValid; input Integer trimEachSide; input ProtectionLibrary.Utilities.Types.AnalogMethod method; output Real value; output Integer nValid; output Boolean available</p><p><b>Parameters</b> No tuning parameters; use the declared input contract.</p><p><b>Behavior</b> Evaluate one finite analog fusion from qualified inputs</p><p><b>Initialization</b> Evaluated from the current inputs and parameter bindings.</p><p><b>Activation and recovery</b> Not applicable.</p><p><b>Limitations</b> Outputs retain the units declared at the interface. Numerical values depend on the supplied input and parameter range.</p><p><b>Observables</b> value, nValid, available</p></html>"));
end Fuse;
