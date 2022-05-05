# UNCC

## Summary

We observed a sharp increase in reported cases, hospitalization, and death since week 1 of simulation, regardless of scenario. There are about 200k cases per day for almost a month before decreasing.

## Methods

#### How much of the pandemic data was fit, and what this means for estimates of R0?

 - We used data from June 2021 when the Delta variant became dominant in the U.S. This would also help fit the asymptotic curve without interfering with the original variant. We did not estimate R0. We used what was provided (1.66x higher transmissibility, assuming the same recovery rate).

#### Determining the distribution of susceptibility

 - We used what was provided in the scenario guideline (rates of breakthrough), and current prevalence to estimate potential susceptible population.

#### Whether or not waning immunity was modeled explicitly over the projection period and if so, what assumptions were made?

 - Waning immunity was not modeled explicitly in this round. However, breakthrough infections were considered as a form of “waning” or “leaking”.

#### Implementation of seasonality

 - Seasonality was adjusted from 2020-2021 data as the baseline scenario.

#### Implementation of NPIs

 - Not modeled explicitly in this round.

#### Baseline conditions for Delta prevalence

 - 20-50% depending on state, but this probably needs to be re-calibrated.

#### Assumptions about vaccine/booster uptake during the projection period

 - Same as current vaccine/booster uptake rate, modeled implicitly.

#### Assumptions of changing severity and other differences between Omicron and prior variants

 - We used what was provided in the scenario guideline (same severity or 50% reduction in severity).
 
#### Assumptions about any decline in quality of care offered as public health systems reach capacity

 - Not modeled explicitly in this round.

## Results

#### Observed timing and magnitude of peak cases, hospitalizations, deaths

 - At national level, >1.4M cases per week for almost 4 weeks since the beginning of simulation. Case number drops down slightly before rebouncing again in mid-February. Similar patterns were observed for hospitalization and death, though more heterogeneity than cases.

#### Notable points of state-level heterogeneity

 - Most states follow similar patterns as national level, but quite a few states may have later surges in cases. 

## Discussion

#### Explanation of results in light of model assumptions. 

 - See below. Also the model used a mixture (weighted average) of short-term prediction (using 30d data) and long-term prediction (using >150d data).

#### If a peak was not observed, which components of model explain this result? 

 - The peak was more like a plateau in our model projection. The reason was the interaction between decline of originally projected cases and increased transmissibility of Omicron. 

## Conclusion

#### Key takeaway(s) from your team-level projections

 - Omicron definitely increased cases similar to or even larger than Delta last year. Under optimistic conditions (reduced severity), Omicron seemed to have lesser impact on the healthcare system. However, precautions need to be taken because severity could change given the large number of mutations of Omicron.

