# Changelog

## 0.3.0

- Rename `ProtectionMeasuresLibrary` to `ProtectionLibrary`.
- Reorganize criteria, qualified votes, coordination and physical measures.
- Specify trip priority, explicit reset and independent feedback, and retain meaningful unavailable states.
- Consolidate repeated logic patterns and replace the old examples.

### Migration

- For HighLimit, map tripThreshold to tripLevel and clearThreshold to resetLevel. Persistence uses holdTime in place of dwell.
- RateOfChange retains sampleStart and samplePeriod. Its finite-difference output is rate. Select Rising for a positive-only criterion.
