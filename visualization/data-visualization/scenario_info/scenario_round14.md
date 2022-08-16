<p>&nbsp;</p>
Round 14 of the COVID-19 Scenario Modeling Hub (SMH) considers the interaction of booster strategies (first dimension) with the epidemiology of circulating strains (2nd dimension) over a 52-week period. We follow the usual 2 x 2 table structure. 

<img src= https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/previous-rounds/Round14_scenarios_table.PNG>
In all scenarios, the VE of reformulated boosters available starting Oct 1st, 2022 should be set to **80% against symptomatic disease** with non-immune escape strains. 
### **Waning Immunity:**
1. Waning of immunity against infection
Models should include waning against infection. 
The median waning time of protection against infection should range between **4-6** months. Teams can sample this range, or use any value within this range as a point estimate. Teams can consider differences in waning of natural and vaccine-induced immunity, or in waning after Omicron infection vs waning from other types of SARS-CoV-2 exposures; however the median waning time should remain within the 4-6 month range. 

We recommend that in the waned classes, teams consider a reduction from baseline levels of protection ranging between **40 and 60%**, corresponding to **x0.60 and x0.40** of the baseline levels reported immediately after exposure (vaccination or infection). This follows the same scheme as in round 13. Teams can sample the recommended range of protection reductions, which is 40-60%, or use any value within this range as a point estimate. 

These guidelines should not preclude teams from considering longer waning times, especially if they would like to integrate detailed waning data. A recent study suggests that vaccine-induced immunity [wanes](https://www.thelancet.com/journals/lancet/article/PIIS0140-6736\(22\)00089-7/fulltext) on long time scales and has not stabilized at 9 months. Accordingly, teams can choose to model longer time scales of waning, with a lower set point than prescribed above. If they do so, teams should ensure that in their formulation, 50% of their population has a 40-60% reduced protection at 4-6 months after (re-)exposure, aligned with the above guidelines.  
2. Waning of immunity against severe disease

**Absent a new variant, the risk of severe disease conditional on infection remains unchanged.** This is the same assumption as in rd 13, which considers that while there is fast waning of immunity against infection, there is no waning in the risk of severe disease conditional on infection.  
### **New variant X:**
In scenarios B and D, we model the emergence of a new variant X, with moderate immune escape, set at **40%**, and moderately increased risk of severe disease given infection, set at **20%**.  
*Infection with variant X (immune escape):* Let’s consider an individual who is currently in a state of immunity to infection, gained from past exposure to SARS-CoV-2 antigens (ie, infection with the wild type, Alpha, Delta, Omicron…) or vaccination (any number of doses). This individual, upon exposure to variant X, has a **40%** probability of infection with this variant in an all-or-nothing model, or a **40%** increased probability of infection in a leaky model. 
Infection with variant X provides immunity to previously observed variants (e.g., Delta, Omicron). After infection with variant X, immune waning should progress as specified by the waning guidelines.
*Severe disease with new variant X, given infection.* In the new variant scenarios B and D, the risk of severe disease, conditional on infection and an individual’s immune class, increases by **20%** relative to Omicron. In other words, the risk of severe disease given a new variant infection is **x1.20** the risk of severe disease with Omicron infection, for a comparable individual in the same immune class. **The factor by which the risk of severe disease, conditional on infection, increases with the new variant is the same for hospitalization and death.** As a result, the new variant CFR is x1.20 Omicron CFR, for a given immune class. 

By increasing the severity of variant X, conditional on infection, we implicitly consider the impact of two potential mechanisms that are non mutually exclusive: (i) variant X can partially evade a broad range of immune mediators that prevent progression to severe disease, and (ii) variant X is intrinsically more severe than Omicron, irrespective of immune escape and infectivity features (as seen with Delta).
*Transmissibility.* The **intrinsic transmissibility of variant X should be the same** as that of the strains circulating at the start of the projection period (same R0 as Omicron variants and subvariants = same effective transmissibility in a fully naive population). The intrinsic transmissibility of strains circulating at the start of the projection period is left at teams discretion). 
*Variant introduction and ramp up.* Variant X is to be seeded in **the first full week of September 2022 (Sep 4-10, 2022), with 50 active infections of variant X** to be introduced during this week in the US (illustrating incoming variants from abroad). There will be a continuous influx of 50 weekly infections of variant X for a total of 16 weeks, **ending the week of December 18-24, 2022, inclusive.** Geographic dispersion of these infections is left at teams discretion. The ramp up of the new variant due to local transmission is also left at the teams’ discretion.
To address potential variation in the rise of variant X between models, and how variant X timing may interact with the timing of the vaccination campaign, we encourage teams to report the mean proportion of cases caused by variant X in each week and location, as `prop_X=cases_of_X/all_cases`. This should be reported in the same file as the other targets.
### **VE of existing and reformulated vaccines:**
There is [evidence](https://jamanetwork.com/journals/jama/fullarticle/2792030?resultClick=1) that vaccines will be reformulated in June 2022 and improved bivalent boosters will become available by October 2022. It is expected that the VE of reformulated bivalent boosters will provide a moderate improvement above existing boosters; yet the exact VE will depend on circulating strains this fall. Teams should set the **VE of reformulated vaccines at  80% against symptomatic disease with the variants circulating at the start of the projection period** (including all Omicron variants). **For scenarios C and D in which variant X is seeded starting the first week of Sep 2022, a reduction of VE against (infection and) symptomatic disease should be implemented over the theoretical 80%**, in line with the 40% immune escape parameter. 

The VE of primary vaccine courses and  non-reformulated boosters are left at teams’ discretion. Non-reformulated boosters will be discontinued after Oct 1st, 2022. 

Relevant references include to set VE for primary courses and non-reformulated boosters include:
*   Effect of 4th dose/2nd booster on infection and severe disease in Isreal https://www.nejm.org/doi/full/10.1056/NEJMoa2201570
*   UK data on VE against symptomatic disease, hospitalization and deaths, by dose, time since vaccination and sublineage of Omicron https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1072064/Vaccine-surveillance-report-week-17.pdf 
*   US data on waning of VE against ED and hospitalization with Delta and Omicron, after 2nd and 3rd doses https://www.cdc.gov/mmwr/volumes/71/wr/mm7107e2.htm
*   [Long term vaccine strategy](https://jamanetwork.com/journals/jama/fullarticle/2792030?resultClick=1) for COVID
### **Vaccine coverage data and dose spacing:**
*Vaccine coverage among adults:* In scenarios A and B (continuation of risk-based booster strategy), teams should use **85% of the state-specific coverage of the 1st booster in those 50 and over (x0.85 of first booster coverage)**. See [COVID-19 coverage](https://github.com/HopkinsIDD/uscovid19vacc) for data by state (1, 2 and 3rd doses) and age group (1 and 2nd doses).  The distribution of who gets a booster among those for whom it is the 1st, 2nd or 3rd booster, and age differences in coverage within the 50+, is at the teams’ discretion. 

For scenarios C and D, teams should use the file [here](https://github.com/midas-network/covid19-scenario-modeling-hub/blob/master/round14_resources/Adult_Coverage_RD14_Sc_C_D.csv) to simulate vaccine coverage in fall-winter 2022-2023. The data in this file provides weekly cumulative coverage by state and adult age groups to apply to scenario C and D. Estimates are based on the reported coverage of the flu vaccine in the 2020-2021 season by month, state and age. We applied the rise in coverage reported during Aug-Oct 2020 to Oct 2022, used a Piecewise Cubic Hermite Interpolating Polynomial to generate weekly coverage estimates, and applied a discounting factor of 0.9 to account for fatigue from repeat COVID vaccination. The distribution of who gets a booster among those for whom it is the 1st, 2nd or 3rd booster, and age differences in coverage within the 18+, is at the teams’ discretion.  

Note that a 2nd booster recommendation for 50+ is [already in place](https://www.cdc.gov/media/releases/2022/s0328-covid-19-boosters.html) since March 29, 2022 and will proceed from projection start to October 1st, irrespective of the scenarios. Teams should use their best scientific judgment to model the impact of this recent recommendation.  
More broadly, the booster coverage data provided for scenarios C, D are intended to represent the additive efforts of a new campaign with a reformulated vaccine starting in Oct 2022, over all of the (primary and booster) vaccination efforts that have already been undertaken up to that point.
*Vaccine coverage among children:*
*   5-11yr and 12-17yr: continue as previous rounds, with rates and saturation at teams’ discretion.
*   6m-4yr: no vaccination.
*Dose spacing:* **Accounting for dose spacing is not required.** However, for teams that model dose spacing explicitly, they should respect a strict 4+ month spacing between doses in the high-risk vaccine strategy (scenarios A and B), and no spacing restriction in the broad booster strategy (scenarios C and D). 
### **Seasonality:**
Teams should include their best estimate of COVID-19 seasonality in their model but we do not prescribe  a specific level of seasonal forcing.
### **NPI:**

**Round 14 should not  include reactive changes in NPIs** imposed by health authorities  to curb transmission, e.g., reinstatement of mask mandates, or closure of schools and businesses. However, teams can incorporate inherent changes in population behavior in response to increasing or decreasing incidences (eg, changes in contacts or masking), if these changes were inferred from earlier phases of the pandemic and are already part of the model. 
Database tracking of NPIs: teams may use their own data if desired, otherwise we recommend the following sources as a common starting point:
* [Coronavirus Government Response Tracker | Blavatnik School of Government (ox.ac.uk)](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker)
* [Coronavirus State Actions - National Governors Association (nga.org)](https://www.nga.org/coronavirus-state-actions-all/)
### **Initial Conditions:**
The mix of circulating strains at the start of the projection period (June 5, 2022) is at the discretion of the teams based on their interpretation/analysis of the available data and estimates at the the time of projection. Variation in initial prevalence between states is left at teams’ discretion. Recent data indicate that the BA.2 variant, and BA-2.12.2 sublineage, are rising in the US https://covariants.org/per-country?region=United+States and have increased transmissibility advantage over the Omicron BA1 variant.
### **Targets and case ascertainment:**

**Ascertainment** of cases, hospitalizations and deaths will **proceed at the same level** as they were at the start of the projection period.
We will continue to collect the same targets (cases, hospitalizations, deaths) as in prior rounds but suggest that teams provide **weekly incident infections (number of new infections each week)**, if they can. This is to facilitate comparisons between models, including outside of SMH, case ascertainment changes over time. A revised submission file template will be provided.
If possible, teams should report the mean proportion of cases caused by variant X in each week and location as a new target named **prop_X**.

**All of the teams’ specific assumptions should be documented in meta-data and abstract.** In this round, we ask that teams provide the **case ascertainment ratio (cases/infections)** used in projections, and a description of how this parameter has been estimated.

**Projection time horizon:** We consider a **52-week projection period.**


## Submission Information    
| Scenario                                                     | Scenario name for submission file | Scenario ID for submission file |
| ------------------------------------------------------------ |:---------------------------------:|:-------------------------------:|
| Scenario A. Age-restricted booster recommendations, No immune escape variant  | restBoo_noVar  | A-2022-05-09    |
| Scenario B. Age-restricted booster recommendations, New immune escape variant | restBoo_Var    | B-2022-05-09    |
| Scenario C. Broad booster recommendations, No immune escape variant           | broadBoo_noVar | C-2022-05-09    |
| Scenario D. Broad booster recommendations, New immune escape variant          | broadBoo_Var   | D-2022-05-09    | 
*   **Due date**: June 7, 2022
*   **End date for fitting data**: June 4, 2022 (no later than June 4, no earlier than May 28)
*   **Start date for scenarios**: June 5, 2022 (first date of simulated transmission/outcomes)
*   **Simulation end date:** June 3, 2023 (52-week horizon)
*   We aim to release results by ~June 15, 2022

**Other submission requirements**
*   **Geographic scope:** state-level and national projections
*   **Results:** some subset of the following
    *  Weekly incident deaths
    *  Weekly cumulative deaths since start of pandemic (use JHU CSSE for baseline)
    *  Weekly incident reported cases
    *  Weekly cumulative reported cases since start of pandemic (use JHU CSSE for baseline)
    *  Weekly incident hospitalizations
    *  Weekly cumulative hospitalizations since simulation start
    *  Weeks will follow epi-weeks (Sun-Sat) dated by the last day of the week
*   **Metadata:** We will require a brief meta-data form, from all teams.
*   **Uncertainty:** aligned with the Forecasting Hub we ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99,. Teams are also encouraged to submit 0 (min value) and 1 (max) quantiles if possible. At present time, *inclusion in ensemble models requires a full set of quantiles from 0.01 to 0.99.*


