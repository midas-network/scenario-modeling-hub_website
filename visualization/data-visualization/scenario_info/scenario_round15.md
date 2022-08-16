<p>&nbsp;</p>
Round 15 is an update of Round 14 that considers the timing of the fall booster campaign (first dimension) with the epidemiology of circulating strains (2nd dimension) over a **40**-week period. We follow the usual 2 * 2 table structure. We consider that reformulated boosters will be made available for all adults on Sep 11 or Nov 13, and that booster uptake will be indexed on the flu campaign.

<img src= https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/Round15_scenarios_table.PNG>
The VE of reformulated boosters available in the fall should be set to **80% against symptomatic disease** with all Omicron lineages (including BA.4/5) and pre-Omicron variants. However the VE of reformulated boosters should be decreased for variant X. Variant X partially escapes immunity conferred by all available vaccines and prior infection with Omicron and pre-Omicron lineages.
There may be an expansion of the 2nd booster recommendations to all adult age groups, sometime between the start of the projection period and the time when reformulated vaccines become available. Consideration of this expansion is left at teams’ discretion.
### **Waning Immunity:**
1. Waning of immunity against infection
Models should include waning against infection. 
The median waning time of protection against infection should range between **3-8** months. Teams can sample this range, or use any value within this range as a point estimate. Teams can consider differences in waning of natural and vaccine-induced immunity, or in waning after Omicron infection vs waning from other types of SARS-CoV-2 exposures; however the median waning time should remain within the **3-8** month range. 

We recommend that in the waned classes, teams consider a reduction from baseline levels of protection ranging between 40 and 60%, corresponding to x0.60 and x0.40 of the baseline levels reported immediately after exposure (vaccination or infection). This follows the same scheme as in round 13-14. Teams can sample the recommended range of protection reductions, which is 40-60%, or use any value within this range as a point estimate. 

These guidelines should not preclude teams from considering longer waning times, especially if they would like to integrate detailed waning data. A recent study suggests that vaccine-induced immunity [wanes](https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(22)00089-7/fulltext) on long time scales and has not stabilized at 9 months. Accordingly, teams can choose to model longer time scales of waning, with a lower set point than prescribed above. If they do so, teams should ensure that in their formulation, 50% of their population has a 40-60% reduced protection 3-8 months after (re-)exposure, aligned with the above guidelines.  
2. Waning of immunity against severe disease
Absent a new variant, the risk of severe disease conditional on infection remains unchanged. This is the same assumption as in rd 13-14, which considers that while there is fast waning of immunity against infection, there is no waning in the risk of severe disease conditional on infection.  
### **New variant X:**
In scenarios B and D, we model the emergence of a new variant X, with moderate immune escape, set at 40%, and moderately increased risk of severe disease given infection, set at 20%.  
*Infection with variant X (immune escape).*  Let’s consider an individual who is currently in a state of immunity to infection, gained from past exposure to SARS-CoV-2 antigens (ie, infection with the wild type, Alpha, Delta, Omicron…) or vaccination (any number of doses). This individual, upon exposure to variant X, will have a 40% probability of infection with X, or a 40% increased probability of infection in a leaky model. 
Infection with variant X provides immunity to previously observed variants (e.g., Delta, Omicron). After infection with variant X, immune waning should progress as specified by the scenarios.  
*Severe disease with new variant X, given infection.* In the new variant scenarios B and D, the risk of severe disease, conditional on infection and an individual’s immune class, increases by 20% relative to Omicron. In other words, the risk of severe disease given a new variant infection is x1.20 the risk of severe disease with Omicron infection, for a comparable individual in the same immune class. The factor by which the risk of severe disease, conditional on infection, increases with the new variant is the same for hospitalization and death. As a result, the new variant CFR is x1.20 Omicron CFR, for a given immune class. 
By increasing the severity of variant X, conditional on infection, we implicitly consider the impact of two potential mechanisms that are non mutually exclusive: (i) variant X can partially evade a broad range of immune mediators that may have prevented progression to severe disease, and (ii) variant X may be intrinsically more severe, irrespective of immune escape and infectivity features (as seen with Delta).  
*Transmissibility.* The intrinsic transmissibility of the new variant should be the same as that of the strains circulating at the start of the projection period (same R0 as Omicron variants and subvariants = same effective transmissibility in a fully naive population, with the R0 value of Omicron left at teams discretion)  
*Variant introduction and ramp up.* Variant X is to be seeded in **the first full week of September 2022 (Sep 4-10, 2022), with 50 active infections of variant X** to be introduced during this week in the US (illustrating incoming variants from abroad). There will be a continuous influx of 50 weekly infections of variant X for a total of 16 weeks, **until the week of December 18-24, 2022, inclusive.** Geographic dispersion of these infections is left at teams discretion. The ramp up of the new variant due to local transmission is also left at the teams’ discretion.
### **Variant BA.2.75:**
Because there is little data on variant BA.2.75’s prevalence and fitness in the US, BA.2.75 should not be explicitly taken into account in the models.
### **VE of existing and reformulated vaccines:**
In June 2022, FDA recommended that vaccines be reformulated and include two components, an original Wuhan-like strain and an Omicron BA4/BA5 strain. Reformulated bivalent boosters are expected to become available in fall 2022, although the exact timing is uncertain. We assume that reformulated bivalent boosters will provide a moderately improved protection above existing boosters; yet the exact VE will depend on circulating strains this fall. Teams should set the VE of reformulated vaccines at  80% against symptomatic disease with the variants circulating at the start of the projection period (including all Omicron variants). For scenarios C and D in which variant X emerges on Sep 1, a reduction of VE against (infection and) symptomatic disease should be implemented over the theoretical 80%, in line with the 40% immune escape parameter.
The VE of a primary vaccine course and a non-reformulated booster are left at teams’ discretion. Note that as soon as reformulated boosters become available on Sep 11 or Nov 13, previously available vaccines will no longer be used. 

Relevant references for VE of non reformulated vaccines include:
*   Effect of 4th dose/2nd booster on infection and severe disease in Isreal https://www.nejm.org/doi/full/10.1056/NEJMoa2201570
*   UK data on VE against symptomatic disease, hospitalization and deaths, by dose, time since vaccination and sublineage of Omicron (including BA4/%) https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1083443/Vaccine-surveillance-report-week-24.pdf  
*   US data on waning of VE against ED and hospitalization with Delta and Omicron, after 2nd and 3rd doses https://www.cdc.gov/mmwr/volumes/71/wr/mm7107e2.htm
*   [Long term vaccine strategy](https://jamanetwork.com/journals/jama/fullarticle/2792030?resultClick=1) for COVID
### **Vaccine coverage data and dose spacing:**
*Vaccine coverage among adults:* Vaccine coverage is the same in all scenarios (booster recommended for all adults 18+), and teams should use 90% of the state-specific flu coverage reported for the 2021-2022 fall-winter season among adults (x0.90 of the flu coverage in 18+).  Teams should use the same file as in round 14 scenarios C and D ([here](https://github.com/midas-network/covid19-scenario-modeling-hub/blob/master/round14_resources/Adult_Coverage_RD14_Sc_C_D.csv))
[COVID-19 coverage](https://github.com/HopkinsIDD/uscovid19vacc) for data by state (1, 2 and 3rd doses) and age group (1 and 2nd doses).  The distribution of who gets a booster among those for whom it is the 1st, 2nd or 3rd booster, and age differences in coverage within the 50+, is at the teams’ discretion. 

For scenarios C and D, teams should use the file [here](https://github.com/midas-network/covid19-scenario-modeling-hub/blob/master/round14_resources/Adult_Coverage_RD14_Sc_C_D.csv) to simulate the coverage of reformulated boosters in fall-winter 2022-2023, and shift the start of the fall campaign according to rd 15 scenarios (Sep 11, 2022 or Nov 13, 2022). The data in this file provides weekly cumulative coverage by state and adult age groups to apply. Estimates are based on the reported coverage of the flu vaccine in the 2020-2021 season by month, state and age. We applied the rise in coverage reported during Aug-Oct 2020 to Oct 2022, used a Piecewise Cubic Hermite Interpolating Polynomial to generate weekly coverage estimates, and applied a discounting factor of 0.9 to account for fatigue from repeat COVID vaccination. 
The distribution of who gets a booster among those for whom it is the 1st, 2nd or 3rd booster, and age differences in coverage within the 18+, is at the teams’ discretion.
Note that a 2nd booster recommendation for 50+ is [already in place](https://www.cdc.gov/media/releases/2022/s0328-covid-19-boosters.html) since March 29, 2022 and will proceed from projection start t to the start of the fall campaign with reformulated vaccines, irrespective of the scenarios. Teams should use their best scientific judgment to model the impact of this recent recommendation, and possible expansions to all adults. 
*Vaccine coverage among children:*
*   5-11yr and 12-17yr: continue as previous rounds, with rates and saturation at teams’ discretion.
*   6m-4yr: no vaccination.
*Dose spacing:* Accounting for dose spacing is not required. 
### **Seasonality:**
Teams should include their best estimate of COVID-19 seasonality in their model but we do not prescribe  a specific level of seasonal forcing.
### **NPI:**
Round 15 should NOT include reactive changes in NPIs imposed by health authorities  to curb transmission, e.g., reinstatement of mask mandates, or closure of schools and businesses. However, teams can incorporate inherent changes in population behavior in response to increasing or decreasing incidences (eg, changes in contacts or masking), if these changes were inferred from earlier phases of the pandemic and are already part of the model. 
Database tracking of NPIs: teams may use their own data if desired, otherwise we recommend the following sources as a common starting point:
* [Coronavirus Government Response Tracker | Blavatnik School of Government (ox.ac.uk)](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker)
* [Coronavirus State Actions - National Governors Association (nga.org)](https://www.nga.org/coronavirus-state-actions-all/)
### **Initial Conditions:**
The mix of circulating strains at the start of the projection period (July 31, 2022) is at the discretion of the teams based on their interpretation/analysis of the available data and estimates at the the time of projection. Variation in initial prevalence between states is left at teams’ discretion. BA.2.75 should not be included.  
### **Targets and case ascertainment:**
Ascertainment of cases, hospitalizations and deaths will proceed at the same level as they were at the start of the projection period.
We will continue to collect the same targets (cases, hospitalizations, deaths) but note that VRBPAC and ACIP are talking about a focus on severe disease moving forward.

**All of the teams’ specific assumptions should be documented in meta-data and abstract.** 

**Projection time horizon:** We consider a **40-week projection period.**


## Submission Information    
| Scenario                             | Scenario name for submission file | Scenario ID for submission file |
| ----------------------------------------------------- |:----------------------------:|:----------------------------:|
| Scenario A. Early boosters, No new variant            | earlyBoo_noVar  | A-2022-07-19    |
| Scenario B. Early boosters, New immune escape variant | earlyBoo_Var    | B-2022-07-19    |
| Scenario C. Late boosters, No new variant             | lateBoo_noVar   | C-2022-07-19    |
| Scenario D. Late boosters, New immune escape variant  | lateBoo_Var     | D-2022-07-19    | 
*   **Due date**: Aug 2, 2022
*   **End date for fitting data**: July 30, 2022 (no later than July 30, no earlier than July 23)
*   **Start date for scenarios**: July 31, 2022 (first date of simulated transmission/outcomes)
*   **Simulation end date:** May 6, 2023 (40-week horizon)
*   We aim to release results by Aug 9, 2022

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


