# UVA-EpiHiper

## Summary

Significant difference between the best scenario (A) and the worst (D) with cases/hospitalizations/deaths doubled or even more.

## Methods

#### How much of the pandemic data was fit, and what this means for estimates of R0.
 - We use data up to 2021-12-11 to initialize disease state of each individual. We use data up to 2021-12-18 to estimate R_effective right before the projection period. We do not explicitly estimate R0.

#### Determining the distribution of susceptibility.
 - We initialize each individual of the population to one of (i) naively susceptible, (ii) vaccinated, (iii) recovered, (iv) partially susceptible, and (v) infeced states, based on county level confirmed cases data. We use vaccine administration data to determine people vaccinated with different vaccines and divide them between (ii) and (iv). We estimate prior infections from cumulative cases and divide them between (iii) and (iv) based on waning. We estimate (v) (infected but not yet recovered) from recent confirmed cases. The rest of the population are seet to (i).

#### Whether or not waning immunity was modeled explicitly over the projection period and if so, what assumptions were made?
 - We explicitly model waning immunity. The immune waning has an exponential distribution with mean of 0.5 year for the time to transition to a partially susceptible state; the age-specific protection on nodes in the partially susceptible state is as specified in the scenario description. The protection against infection is 60% (<65yo) or 40% (>=65yo); the protection against severe disease is 90% (<65yo) or 80% (>=65yo).

#### Implementation of seasonality.
 - N/A.

#### Implementation of NPIs.
 - We have modeled the following NPIs: (i) A fraction (15%) of the population chooses to reduce non-essential activities. (ii) All K-12 schools are closed during winter break; and face masks are used in school while schools are open. (iii) A fraction (75%) of symptomatic people choose to self-isolate themselves at home.

#### Baseline conditions for Delta prevalence.
 - We have about 65% infections being Delta at the beginning of the projection period.

#### Assumptions about vaccine/booster uptake during the projection period.
 - For each state, we determine an upper bound on vaccine uptake based on state level vaccine acceptable data; prior vaccinations based on vaccine administration data; and a vaccination schedule (age stratified) subject to the upper bound. Child vaccination (5-11yo) follows the specifications. Booster coverage is 50% of fully vaccinated.

#### Assumptions of changing severity and other differences between Omicron and prior variants.
 - We follow the scenario specifications.

#### Assumptions about any decline in quality of care offered as public health systems reach capacity.
 - We do not explicitly model PH system capacity.

## Results

#### Observed timing and magnitude of peak cases, hospitalizations, deaths.
 - At national level, cases peak in early Feb. 2022 with about 3M (scenario A) to 6.5M (scenario D) cases weekly; hospitalizations peak in early-mid Feb. with about 170K (scenario A) to 560K (scenario D) hospitalizations weekly; deaths peak in mid-late Feb. with about 25K (scenario A) to over 75K (scenario D) deaths weekly.

#### Notable points of state-level heterogeneity.
 - Cases peak in Feb. 2022 in most states, except for a few that peak as early as in mid-Jan.

## Discussion

#### Explanation of results in light of model assumptions.
 - With Omicron, the overall R_effective becomes larger than 1 in most states for all scenarios. Most of the projected infections are Omicron. From Feb. remaining nodes susceptible to Omicron are not enough to keep Rt>1.

#### If a peak was not observed, which components of model explain this result?
 - N/A.

## Conclusion

#### Key takeaway(s) from your team-level projections.
 - Significant difference between the best scenario (A) and the worst (D) with cases/hospitalizations/deaths doubled or even more.


