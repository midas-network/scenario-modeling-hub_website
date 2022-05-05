# USC-SIkJalpha

## Summary

In Round 11, the updated model projects upcoming peaks in all outcomes in all scenarios, although, with large intervals. Scenario A with high immune escape and low severity is the most favorable.

## Methods

Due to the high transmissibility and immune escape nature of Omicron, we made significant changes to the model to explicitly account for various paths to partial immunity and time at which it was acquired. These include (1) 1st time infections, (2) 2nd+ time infections, (3) infection after 2-doses, (4) infections after a booster, (5) 2-doses with no prior infection, (6) booster with no prior infection, (7) 2-doses with prior infection(s), and (8) booster with prior infection(s). Having these states over time, age-groups, and variants allows for precise computation of immunity in the population at a given time. As a result, we can track new infections among the observed data that have protection from a prior immunity (from vaccine/booster/infection), while accounting for waning immunity. We considered two circulating “variants”: (i) Omicron and (ii) Other. The reason for switching from multi-strain model was to avoid uncertainties that arise due to low-prevalence variants with noise data. A logistic regression model was fit to estimate the prevalence of the two variants over time which is then used to disaggregate the reported cases into time-series of each variant. Transmission rates are estimated using recent data with an exponential forgetting factor to favor more recently seen trends. However, it requires estimation of immunity, which is measured starting from the beginning of the pandemic. Due to combining of all non-Omicron variants as “Other”, the model assumes that they have identical waning and no immune-escape. To focus on the uncertainty around Omicron, we did not consider any changes in NPI, and no seasonality was introduced. The same vaccination adoption model was used for 2-dose vaccination and boosters. The adoption model assumes that the behavior is contagious, where the eligible population adopts the vaccine at a rate determined by the recent population who adopt it. Uncertainty in the future of boosters is employed by assuming that they will eventually saturate between 40% to 70% of the coverage of 2-dose vaccine.


## Results

Based on the projections, high immune escape results in significantly smaller peaks in cases than low immune escape scenarios. For hospitalizations and deaths, optimistic severity with high immune escape produced the most favorable outcomes with the peak point projections within 1.5x of prior largest peak for most states. At the national level, cases peak in mid (Scenarios B/D) to late January (Scenarios A/C), hospitalizations peak in late January to early February, while deaths peak in mid-February.

## Discussion

The key modeling choice that affected the projections was the residual protection from infection due to waning. Counter-intuitively, higher protection leads to larger peaks. This is because if protection (and hence, immunity) is high, then Delta must have a very high R0 to be able to produce cases at the rate seen recently. As a result, Omicron will have a high(er) R0 with reduced immunity in the population. We also observe that majority of the new cases are first-time infections with no prior immunity. Therefore, despite having residual protection against severe outcomes from prior immunity, the large peaks in cases produce significant peaks in hospitalizations and deaths.

## Conclusion

While peaks higher than the prior ones are projected for all scenarios, significant uncertainties remain attributed to modeling choices, as presented by the large intervals. Particularly, waning of immunity needs to be accurate estimated for better projections.

 - USC-SIkJalpha: Round 11
 - Ajitesh Srivastava
 - University of Southern California
 
