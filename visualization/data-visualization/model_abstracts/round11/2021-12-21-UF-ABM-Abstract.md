# University of Florida

## Summary

 - Using an agent-based model with demographics, vaccination coverage, and pandemic history for the state of Florida, we projected the cases, hospitalizations, and deaths caused by the SARS-CoV-2 omicron variant. 
 - Our model ranks the proposed scenarios, from most to least optimistic, in the following order: A, C, B, D.  This ranking held for all outcomes (reported cases, hospitalizations, and deaths), as well as for infections (not reported).
 - In terms of reported cases, Scenarios A and C (immune escape = 0.8, transmissibility = 1x delta) had roughly similar outcomes, with an omicron wave predicted to be milder than delta; and scenarios B and D (immune escape = 0.5, transmissibility = 1.66 x delta) had roughly similar outcomes, with an omicron wave predicted to be more severe than delta.
 - Only Scenario D resulted in more deaths due to omicron than occured due to delta.

#### Explanation of observed dynamics given model assumptions
 - One important assumption in our model is that fully vaccinated individuals are less infectious compared to partially vaccinated and unvaccinated individuals. Given that approximately 60% of the population is fully vaccinated prior to the omicron wave, those with breakthrough omicron infections will experience less onward transmission. Thus, in scenarios A and C, given a higher immune escape assumption but lower overall transmission advantage, even though many breakthrough omicron infections may occur, these will result in fewer secondary infections than in infections in unvaccinated people, partially explaining the more optimistic projections for these scenarios.

## Methods

#### How did you identify the initial distribution of susceptibility?
 - Initial distribution of susceptibility is constant across all replicates up until December 1, 2021, when we assume omicron first started to be introduced to the state.  We explicitly model all previous waves of the pandemic, and a vaccine-roll out based on what has occurred in Florida (i.e., health care workers first, followed age-eligibility changes as they occurred in the state).

#### How did you model waning immunity during the projection period and if so how?
 - In past work, we determined that assuming leaky immunity and changes in VOC transmissibility and immune escape ability were better at predicting apparent loss of vaccine protection than immunity that intrinsically wanes.  Our model therefore does not assume intrinsic waning of immunity from prior infection or vaccination.  Our assumptions result in estimated vaccine direct effectiveness against infection that is ~0.8 early in 2021, down to ~0.2 against delta and ~0.1 against omicron.  

#### How did you specify seasonality?
 - Seasonality is modeled using a sine model with a 6 month period, with transmission probability peaking in July and January.

#### How did you implement NPIs?
 - Closure of non-essential businesses and schools occur in our model early in the pandemic, but not during the omicron wave.
 - Individuals in the model have time-varying personal-protective behaviors, namely avoiding social contacts and high-risk businesses like bars and restaurants.

#### What were your baseline conditions for Delta prevalence?
 - We assume that when omicron is first introduced in our model (December 1, 2021), infections are very low, but all are caused by delta.  This is consistent with Florida data.

#### What were your assumptions of changing severity with variants?
 - We interpret severity as the probability that a symptomatic infection will result in a severe (i.e., hospitalizable) infection.  We assume alpha severity is similar to wildtype infections, whereas delta severity is 2.5x higher.  Omicron severity was defined relative to delta, according to the specified scenarios.

## Results

## Discussion

## Conclusion

