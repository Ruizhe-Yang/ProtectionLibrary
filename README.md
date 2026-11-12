# ProtectionLibrary

## Name and purpose

Protection criteria, voting, coordination, physical measures and independent action feedback.

## Scope and non-goals

Online criteria, qualified voting, command arbitration, physical actions and independent action feedback.

## Requirements

- Modelica Standard Library 4.0.0.
- Tested with OpenModelica 1.25.5 (64-bit), DASSL and relative tolerance 1e-6. 9/9 default examples completed in the recorded runs.
- Other Modelica tools are compatibility targets pending separate verification.

## Installation

Extract the source tree, load Modelica 4.0.0, then open `ProtectionLibrary/package.mo`. Confirm the Modelica version in your tool. Open an example from the package tree and use its declared experiment settings.

## Package structure

```text
ProtectionLibrary/
    UsersGuide/
    Criteria/
    Voting/
    Coordination/
    Electrical/
    Thermal/
    Mechanics/
    Fluid/
    Utilities/
    Examples/
```

The model catalog lists each class, its interfaces, an example and its recorded validation level.

## Core concepts and usage

- Feed measured conditions into the criteria. When using validity connectors, select the intended missing-channel policy. Read available and nValid alongside fallback values.
- Send requests to a latch or arbiter. Qualify reset with an independent permissive and the clear dwell.
- Connect the measure to a complete host circuit or network. Drive feedback monitors with measured actions, separately from command.

## Examples

| Example | Stop time (s) | Purpose | Suggested observables |
|---|---:|---|---|
| ThresholdLatchReset | 6 | Qualify a threshold then latch until a safe reset edge | limit.request, persist.request, safeDwell.resetAllowed and protectedState. |
| BooleanVoting | 4 | Exercise all fixed Boolean votes with two invalid-channel policies | twoOutOfThreeRequest, mOutOfNRequest and each nValid, degraded and enoughValid. |
| AnalogVoting | 4 | Compare median and mean with changing input qualification | median3Value, mean3Value and each available and nValid. |
| CommandPriorityAndInterlock | 6 | Select ordered authority and delay the return of start permission | selectedCommand, selectCommand.selectedSource, interlock.startPermitted and startAllowed. |
| ElectricalTripAndDump | 5 | Open a resistive circuit and dissipate inductive energy in a separate circuit | resistiveLoad.i, inductiveSwitch.isOpen, coil.i and dump.lossPower. |
| MechanicalBraking | 5 | Apply finite viscous braking to moving rotational and translational bodies | rotationBody.w, translationBody.v and both braking losses. |
| ThermalCooling | 60 | Compare increased physical cooling with the same unprotected thermal load | protectedBody.T, referenceBody.T, protectedCooling.heatFlow and limitCommand.y. |
| FluidIsolationAndRelief | 10 | Vent an independently connected relief branch from a compressible vessel | protectedVolume.medium.p, referenceVolume.medium.p, relief.massFlow and isolation.opening. |
| ActionFeedbackAndFailure | 4 | Distinguish two identical requests using independent measured action | goodMonitor.actionTime, goodMonitor.acknowledged, refusedMonitor.failed and both actuator outputs. |

## Limitations and numerical assumptions

- Finite flow and mechanical limits apply to the declared operating region. Viscous brakes dissipate while moving.
- The hydraulic example uses a lumped compressible vessel with finite flow paths.
- Apply independent physical evidence and suitable host thresholds when assessing action success.

## Version and license

Version 0.3.0. See LICENSE for the terms supplied with the original source.
