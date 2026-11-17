within ProtectionLibrary.UsersGuide;
class Conventions "Signal validity, command priority and physical interfaces"
  extends Modelica.Icons.Information;
  annotation(Documentation(info="<html><p>Keep measured quantities, qualification flags, protection requests, actuator commands and measured action distinct. Enable and connect conditional validity inputs explicitly. Read inputValid, condition and request together where those outputs are provided.</p><p>Boolean voters use invalidVote as a substitute vote; enoughValid is a separate diagnostic. Analogue voters use availability and a configured fallback. A trip latch gives trip priority and accepts only a permitted reset edge.</p><p>Use the declared SI units and physical connector directions. Signal limiters change commands; physical devices impose their stated constitutive relations on connected networks.</p></html>"));
end Conventions;
