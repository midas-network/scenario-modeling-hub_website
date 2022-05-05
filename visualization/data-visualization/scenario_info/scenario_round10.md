<p>&nbsp;</p>
Round 10 of SMH will concentrate on evaluating the impact of boosters and waning immunity on COVID-19 dynamics. We have designed a 2\*2 scenario structure where booster coverage is represented in one axis and the characteristics of waning immunity are on the other axis.


### Scenario Differences

<img src= https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/previous-rounds/Round10_scenarios_table.PNG>


#### Interpretation and structure of waning:

**Interpretation:** These scenarios are intended to illustrate a gradual decay of immune protection with time, rather than the impact of an immune escape variant. 

**Model structure:** Teams are encouraged to model waning immunity as a partial loss of immune protection, where individuals go back to a partially immune state after a period prescribed in the scenarios (mean of 6 month or 1 year depending on the scenario). Individuals who have reached a partially immune state have reduced probabilities of reinfection and severe disease compared to naive individuals. <br>

**The same parameters should be used for waning immunity from natural infection and vaccination.**
 

**Model parameters defined in scenarios:** <br>
Interpretation of waning parameters is similar to that of round 8. <br>
Specifically, in the optimistic waning scenario, protection from infection is 60% for individuals < 65yrs in the partially immune state. This means that, for these individuals, the transition out of the partially immune state and into infection is 0.4\*force of infection applied to naive individuals of the same age. If we apply this waning parameter to vaccinated people, this corresponds to a VE of 60% against **infection**. <br/>
Further, in this scenario, protection against hospitalization is 90% for those under 65 yrs. This estimate is similar to VE against hospitalization and death, so it is **not a conditional probability**. This means that if we follow two individuals over time, one with partial immunity and one completely naive, the probability that the partially immune individual will be hospitalized from COVID19 is 0.1 times the probability that a naive individual will be hospitalized. Hence this probability combines protection against infection and protection against hospitalization given infection. If we apply this parameter to vaccinated individuals for whom immunity has partially waned, their VE against **hospitalization** becomes 90%. 

**Unconstrained model parameters:** <br>
Teams can choose different distributions of waning immunity (exponential, gamma); we only prescribe the mean. <br>
Teams should use their own judgments to parametrize protection against **symptoms** in the partially immune state, and any reduction in **transmission** that partially immune individuals may have. <br>
Teams can choose to treat individuals who have immunity from natural infection and vaccination differently from individuals who had a single exposure to the pathogen/antigen. <br>
We do not specify any waning for J&J (for which the starting point VE is much lower): teams can choose to ignore J&J, which represents a small fraction of all vaccinated in the US, or apply a different waning for J&J. <br>
We do not specify any waning for those who only get a 1st dose of Pfizer or Moderna and hence never acquire full vaccine immunity. We believe this represents a small fraction of all vaccinated. Teams can choose to apply a different waning to these individuals, or ignore them. <br>
All of these assumptions (especially the distribution of waning times) should be documented in meta-data.
#### Initial VE (before waning) and boosters:

**Initial VE (before waning):** We suggest that teams use a **VE of 80% against symptomatic COVID-19 in those over 65 yrs**, and **VE of 90% in those under 65 years**, while protection against infection and severe outcomes remains at teams’ discretion. This is based on data from [US](https://pubmed.ncbi.nlm.nih.gov/34619098/), [UK](https://khub.net/documents/135939561/338928724/Vaccine+effectiveness+and+duration+of+protection+of+covid+vaccines+against+mild+and+severe+COVID-19+in+the+UK.pdf/10dcd99c-0441-0403-dfd8-11ba2c6f5801), [CDC](https://www.cdc.gov/vaccines/acip/meetings/downloads/slides-2021-09-22/04-COVID-Link-Gelles-508.pdf), [NY](https://pubmed.ncbi.nlm.nih.gov/34529645/) and [CDC MMWR](https://www.cdc.gov/mmwr/volumes/70/wr/mm7034e2.htm?s_cid=mm7034e2_w).

**Impact of boosters on VE:** Boosters should be implemented in a way that individuals who have received a booster shot will revert to the same level of protection that they had before any waning occurred. 

**Booster coverage:** <br/> 
*  Past booster data until start of simulations should be based on state-specific booster uptakes for the period up to present.  Data on vaccine boosters coverage is available from [CDC](https://covid.cdc.gov/covid-data-tracker/#vaccinations_vacc-total-admin-rate-total) (13% coverage in 65+, 5% in 18+ on 10/14/2021). 
*  In high booster scenarios, we recommend a saturation level of 70% for booster coverage, which is **70%** of adults who have already received a full vaccine course. The timing and pace of getting to saturation is left at teams discretion; note that a 6-month interval between the initial vaccine course and boosters is recommended. We recommend that 70% be applied to the state-specific coverage of 2nd dose in adults. 70% is based on the upper bound of a September survey of [Kaiser Permanente](https://www.kff.org/coronavirus-covid-19/dashboard/kff-covid-19-vaccine-monitor-dashboard/) that monitors propensity to get a booster shot among those who have already been vaccinated.
*  In low booster scenarios, we recommend a saturation level of 40% for booster coverage, which is **40%** of adults who have already received a full vaccine course. The timing and pace of getting to saturation is left at teams discretion. We recommend that 40% be applied to the state-specific coverage of 2nd dose in adults. 40% is based on the lower bound of the [Kaiser Permanente survey](https://www.kff.org/coronavirus-covid-19/dashboard/kff-covid-19-vaccine-monitor-dashboard/) (full range of survey responses, 40-70%, across various socio-demographic groups and political affiliations).
*  We do not specify different parameters for different combinations of vaccines available (eg, initial vaccination with Pfizer followed by Moderna booster, etc). 

**Booster timing:** <br/> 
*  A recommendation for boosters targeted at older and high-risk adults was issued on [September 24, 2021](https://www.cdc.gov/media/releases/2021/p0924-booster-recommendations-.html). These recommendations are very inclusive and include multiple groups prone to high-risk exposures, representing a large fraction of all US adults. Accordingly, we do not consider a formal extension of ACIP recommendations to all adults. Instead we consider two saturation levels for boosters.
 
### Common Specifications
<br/>

**Vaccination** <br/> 
<br/> 
Coverage of initial vaccine courses (pre-boosters): Vaccine hesitancy is expected to cause vaccination coverage to slow and eventually saturate at some level below 100%. The coverage saturation, the speed of that saturation, and heterogeneity between states (or other geospatial scales) and/or age groups are at the discretion of the modeling teams. We suggest that the teams use estimates from the Delphi group, adjusted for potential bias in respondents ([link](https://delphi.cmu.edu/covidcast/indicator/?date=20210313&sensor=fb-survey-smoothed_covid_vaccinated_or_accept)) and the Pulse Survey overall estimates, adjusted for survey participant vaccination coverage ([link](https://data.cdc.gov/stories/s/Vaccine-Hesitancy-for-COVID-19/cnd2-a6zw)).
Vaccine-eligible population. The eligible population for 1st/2nd dose vaccination is presumed **to be individuals aged 12 years and older until November 15, and 5 years and older from November 15** through the end of the projection period. 

**For vaccine coverage in the 5-11 yo, starting on November 15, 2021, we recommend the same strategy as in round 9. Specifically, state-specific vaccine coverage in 12-17 yrs from May 2021 onwards should be applied to the 5-11 yo.**
*   <ins>VE</ins>: 
    *	We recommend that teams use the following for VE against symptoms: **VE=35% (first dose), VE=80% (2nd dose, > 65 yrs), VE= 90% (2nd dose, < 65 yrs)** for Moderna/Pfizer, against Delta. **This is the initial VE, before any waning**. VE is defined here as vaccine effectiveness against symptomatic disease. Teams should make their own informed assumptions about effectiveness and impacts on other outcomes (e.g., infection, hospitalization, death). <br/>
<br/>
*   <ins>Dose Available</ins>:
    * J&J no longer available (after May 2021) 
    *	Supply has eclipsed demand at this stage. 
    *	We do not anticipate any constraint in booster supply

**Variant progression and transmissibility:**  <br/>
Teams should use their own judgment to project the continued progress and transmissibility of the Delta variant, and related lineages, across US states. In this round, there is no new variant  that arrives in the US between now and the end of the projections. \
Teams can implement increases in transmissibility or severity of the Delta variant, but these should fit within the scenario specifications and  should be fully documented in meta-data.

**NPI:** <br/>
We don’t specify different levels of non-pharmaceutical interventions (NPI) use; however, teams should consider that most schools have returned to in-person education in fall 2021 and high level health officials have noted that “people should feel safe to mingle at Thanksgiving and Christmas”. The future level of NPIs are left at the discretion of the modeling teams and should be specified in the teams’ metadata. Teams should also note the change in CDC [mask recommendations](https://www.cdc.gov/coronavirus/2019-ncov/vaccines/fully-vaccinated.html) for vaccinated people in high-transmission areas on 07/27/2021.


### Submission Information
| Scenario                                                               | Scenario name for submission file | Scenario ID for submission file |
| ---------------------------------------------------------------------- |:---------------------------------:|:-------------------------------:|
| Scenario A. Optimistic waning, widespread boosters                     | optWan_highBoo                    | A-2021-11-09                    |
| Scenario B. Optimistic waning, restricted boosters                     | optWan_lowBoo                     | B-2021-11-09                    |
| Scenario C. Pessimistic waning, widespread boosters                    | pessWan_highBoo                   | C-2021-11-09                    |
| Scenario D. Pessimistic waning, restricted boosters                    | pessWan_lowBoo                    | D-2021-11-09                    | 
*   **Due date**: December 3, 2021 (desired); December 6, 2021 (hard deadline) 
*   **End date for fitting data**: No earlier than Nov 13, 2021 and no later than Nov 20, 2021 (cut-off date at the discretion of individual teams; no fitting should be done to data after Nov 20)
*   **Start date for scenarios**: Nov 14, 2021 (first date of simulated transmission/outcomes). The week ending Nov 20th is week 1 of projection (week from 2021-11-14 to 2021-11-20).  Note that if you used data until Nov 20th for calibration, your first week of projections (Nov 14- Nov 20) will be your model-fitted incidences for 1 wk ahead and the first target_end_date will be Nov 20, 2021.
*   **Simulation end date: Nov 12, 2022 (52-week horizon)**; Projections with horizon between 26 week and 52 week are also accepted.


### Scenario and Simulation Details
*	**Social Distancing Measures:**
    *	Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.
    * Current and future levels of social distancing are to be defined by the teams based on their understanding of current and planned control and behavior and expectations. Teams should consider that most jurisdictions are opening fairly quickly, and most schools intend to return to in-person education in the fall. No reactive interventions should be planned.
*	**Testing-Trace-Isolate:** constant at baseline levels
*	**Masking:** Included as part of “Social Distancing Measures” above.
* **Immune waning and Immune escape:** Immune waning as described above; immune escape as defined by the modeling team.
*	**Vaccination:**
    *	**Pfizer / Moderna**
        *	**Vaccine efficacy (2-dose vaccines):**
            * VE against symptoms: see above
            *	Effectiveness and impact on infection and other outcomes (hospitalizations, deaths) is at team’s discretion and should be clearly documented in team’s metadata.
            *	Doses 3.5 weeks apart
        *	**Vaccine availability:**
            *	No constraint in supply.
    *	**Johnson & Johnson**
        *	**Vaccine efficacy (1-dose):**
            *   70% VE against previous strains; 60% VE against B.1.1.7/B.1.617.2
        *	**Vaccine availability:**
            *	March-May 2021: based on data on administered doses, with continuing at rate current on date of projection for remainder of month (~10M total administered).
            *	June 2021-Nov 2022: No longer available; only 10M of 20M doses administered, supply, safety, and demand issues.
            * Manner for accounting for protection provided in the 10M vaccinated during March-May 2021 at team's discretion.
*	**Vaccine Hesitancy:** Vaccine hesitancy expected to cause vaccination coverage to slow and saturate below 100%. Speed and level of saturation and heterogeneity between states (or other geospatial scale) and/or age groups are at the discretion of the team.
*	**Delta (B.1.617.2) variant strain:** At teams’ discretion. No immune escape feature for Delta variant.
*   **Transmission assumptions**: models fit to US state-specific dynamic up until End date for fitting data specified above – no proscribed R<sub>0</sub>, interventions, etc.
*   **Pathogenicity assumptions**: no exogenous fluctuations in pathogenicity/transmissibility beyond seasonality effects.
*   **Vaccine effectiveness**: see recommendations (same VE in all scenarios); assumptions regarding time required to develop immunity, age-related variation in effectiveness, duration of immunity, and additional effects of the vaccine on transmission are left to the discretion of each team
*   **Vaccine immunity delay:** There is approximately a 14 day delay according to the Pfizer data; because we suspect the post first dose and post second dose delays may be of similar length, we do not believe there is any need to explicitly model a delay, instead groups can delay vaccine receipt by 14 days to account for it.
*   **Vaccine uptake:** See specific details.
*   **NPI assumptions**: NPI estimates should be based on current trends and reported planned changes.
*   **Database tracking of NPIs**: teams may use their own data if desired, otherwise we recommend the following sources as a common starting point:
    *   [Coronavirus Government Response Tracker | Blavatnik School of Government (ox.ac.uk)](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker)
    *   [Coronavirus State Actions - National Governors Association (nga.org)](https://www.nga.org/coronavirus-state-actions-all/)
*   **Geographic scope**: state-level and national projections
*   **Results**: some subset of the following
    *   Weekly incident deaths
    *   Weekly cumulative deaths since start of pandemic (use JHU CSSE for baseline)
    *   Weekly incident reported cases
    *   Weekly cumulative reported cases since start of pandemic (use JHU CSSE for baseline)
    *   Weekly incident hospitalizations
    *   Weekly cumulative hospitalizations since simulation start
    *   **Weeks will follow epi-weeks (Sun-Sat) dated by the last day of the week**
*   **“Ground Truth”**: The same data sources as the forecast hub will be used to represent “true” cases, deaths and hospitalizations. Specifically, JHU CSSE data for cases and deaths and HHS data for hospitalization. 
*   **Metadata:** We will require a brief meta-data form, TBD, from all teams. 
*   **Uncertainty**: aligned with the Forecasting Hub we ask for **0 (min)**, 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99, **1 (max)** quantiles. 
*   **Ensemble Inclusion**: at present time, in order to be included in the ensemble models need to provide a full set of quantiles




