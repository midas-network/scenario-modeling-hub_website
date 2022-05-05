<p>&nbsp;</p>
Round 11 of the COVID-19 Scenario Modeling Hub will concentrate on evaluating the impact of Omicron on COVID-19 dynamics. We have designed a 2\*2 scenario structure where Omicron transmissibility and immune escape are represented in one axis and severity of Omicron are on the other axis. We will consider a **3-month horizon**.

<img src= https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/previous-rounds/Round11_scenarios_table.PNG>
#### **Assumption synopsis and model requirements:**
* **The effect of boosters and waning do not need to be explicitly incorporated in the model** as long as reasonable assumptions about the proportion of fully susceptible and immune individuals (with recommended breakdown by partial and fully immune status) can be made at the start of simulations
* **Booster coverage (for teams incorporating explicitly):** At teams’ discretion, suggested between 40-70% of those previously vaccinated
* **Waning (for teams incorporating explicitly):** At teams’ discretion, recommended timescale 6-12month. We provide recommendations for age-specific protection parameters below.
* **Child vaccination:** 
   * <ins>5-11yr:</ins> continue as previous rounds, with rates and saturation at teams’ discretion.
   * <ins>6m-4yr:</ins> no vaccination 
* **Updated vaccines:** Manufacturers are working on updated vaccines formulated for Omicron, though the timeframe and rollout of these are unknown. For R11 we will not include these.
* **Initial conditions:** Prevalence of Omicron at the start of the projection period (December 19, 2021) is at the discretion of the teams based on their interpretation/analysis of the available data and estimates at the the time of projection.). Variation in initial prevalence between states is left at teams’ discretion. 
* **NPIs, control, behavior change:** Reduction in transmission resulting from non-susceptibility or virus characteristics is left to each group’s discretion. However, R11 should not include responsive changes in NPIs or behavior (i.e., increased control due to Omicron concerns). We may explore these impacts in the follow-up round, however, for now there remains too much uncertainty about the potential transmission and this is the focus.


### Interpretation and structure of immune escape:    
Immune escape represents an increase in risk of infection among those with immunity from prior exposure to SARS-CoV-2 (of any kind, vaccination or natural infection), due to changes in the genetic makeup of Omicron. As an illustration, an immune escape of 60% indicates that among those with prior immunity to past variants, 60% will be susceptible to Omicron infection, and 40% will be protected against Omicron infection. Among those infected with Omicron who had previous immunity due to vaccination or prior infection, a reduction in the probability of severe disease may occur. This is specified in the severity axis of the scenarios.
### Interpretation and structure of transmissibility:    
We provide both absolute R0 for Omicron and a fold increase over Delta. Assumptions are based on a ratio of Rt_Omicron to Rt_Delta of 2.8. Here Rt=S(t)\*R0\*alpha(t), where alpha represents the impact of NPI and seasonal forcing on transmission. We can assume that NPI and seasonal forcing is the same for both variants, so the ratio of 2.8 can be explained as differences in S(t) (immune differences, e.g., [link](https://www.documentcloud.org/documents/21150195-medrxiv-2021-267417v1-sigal)) and R0 (intrinsic transmissibility differences). The parameters chosen for these scenarios cover a possible range of immunity and transmissibility differences between variants that would contribute to an observed Rt ratio of 2.8. We have used intermediate estimates based on results from the MOBS and Bedford labs.  
### Interpretation and structure of waning:    
    
The presence, duration, and extent of waning is left to the team’s discretion. For teams including waning explicitly, we recommend the following:
  * <ins>Speed</ins>: Average transition time to partially immune state between 6-12 months
  * <ins>Residual protection among waned individuals</ins>:
    *  Less than 65 years of age: Protection from infection: 60%, hospitalization: 90%, death: 95%
    *  65 years and older: Protection from infection: 40%, hospitalization: 80%, death: 90%

**Model structure:** For teams explicitly modeling waning, teams are encouraged to consider immunity as a partial loss of immune protection, where individuals go back to a partially immune state after a period of time which is left to the teams’ discretion (suggested 6 months to 1 year). Individuals who have reached a partially immune state have reduced probabilities of reinfection and severe disease compared to naive individuals. **The same parameters can be used for waning immunity from natural infection and vaccination**. 

**Suggested waning parameters:** Interpretation of waning parameters is similar to that of Round 8. Specifically, protection from infection is 60% for individuals <65yrs in the partially immune state. This means that, for these individuals, the transition out of the partially immune state and into infection is 0.4\*force of infection applied to naive individuals of the same age. If we apply this waning parameter to vaccinated people, this corresponds to a VE of 60% against infection. Further, suggested protection against hospitalization is 90% for those under 65 yrs. This estimate is similar to VE against hospitalization and death, so it is **not a conditional probability**. This means that if we follow two individuals over time, one with partial immunity and one completely naive, the probability that the partially immune individual will be hospitalized from COVID-19 is 0.1 times the probability that a naive individual will be hospitalized. Hence this probability combines protection against infection and protection against hospitalization given infection. If we apply this parameter to vaccinated individuals for whom immunity has partially waned, their VE against hospitalization becomes 90%. 

**Unconstrained model parameters:** 
*  Teams can choose different distributions of waning immunity (exponential, gamma)
*  Teams should use their own judgments to parametrize protection against symptoms in the partially immune state, and any reduction in transmission that partially immune individuals may have.
*  Teams can choose to treat individuals who have immunity from natural infection and vaccination differently from individuals who had a single exposure to the pathogen/antigen. 
*  We do not provide any suggested waning parameters for J&J (for which the starting point VE is much lower): teams can choose to ignore J&J, which represents a small fraction of all vaccinated in the US, or apply a different waning for J&J.
*  We do not provide any suggested waning parameters for those who only get a 1st dose of Pfizer or Moderna and hence never acquire full vaccine immunity. We     believe this represents a small fraction of all vaccinated. Teams can choose to apply a different waning to these individuals, or ignore them.
All of these assumptions (especially the distribution of waning times) should be documented in meta-data.


## Submission Information    
| Scenario                                                               | Scenario name for submission file | Scenario ID for submission file |
| ---------------------------------------------------------------------- |:---------------------------------:|:-------------------------------:|
| Scenario A. Optimistic severity, High immune escape/Low transmissibility increase     | optSev_highIE    | A-2021-12-21    |
| Scenario B. Optimistic severity, Low immune escape/High transmissibility increase     | optSev_lowIE     | B-2021-12-21    |
| Scenario C. Pessimistic severity, High immune escape/Low transmissibility increase    | pessSev_highIE   | C-2021-12-21    |
| Scenario D. Pessimistic severity, Low immune escape/High transmissibility increase    | pessSev_lowIE    | D-2021-12-21    | 
*   **Due date**: December 21, 2021
*   **End date for fitting data**: Dec 18, 2021
*   **Start date for scenarios**: Dec 19, 2021 (first date of simulated transmission/outcomes)
*   **Simulation end date**: Mar 12, 2022 (12-week horizon)

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
*   **Uncertainty:** aligned with the Forecasting Hub we ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99,. Teams are also encouraged to submit 0 (min value) and 1 (max) quantiles if possible. At present time, inclusion in ensemble models requires a full set of quantiles from 0.01 to 0.99.


## Common Specifications    
### Vaccination     

**Vaccine coverage:** Coverage of initial vaccine courses (pre-boosters): Vaccine hesitancy is expected to cause vaccination coverage to slow and eventually saturate at some level below 100%. The coverage saturation, the speed of that saturation, and heterogeneity between states (or other geospatial scales) and/or age groups are at the discretion of the modeling teams. We suggest that the teams use estimates from the Delphi group, adjusted for potential bias in respondents ([link](https://delphi.cmu.edu/covidcast/indicator/?date=20210313&sensor=fb-survey-smoothed_covid_vaccinated_or_accept)) and the Pulse Survey overall estimates, adjusted for survey participant vaccination coverage ([link](https://data.cdc.gov/stories/s/Vaccine-Hesitancy-for-COVID-19/cnd2-a6zw)).

**Vaccine-eligible population:** The eligible population for 1st/2nd dose vaccination is presumed **to be individuals aged 5 years and older** through the end of the projection period. 

**Vaccine coverage in the 5-11yo:** At team’s discretion.

**Vaccine effectiveness:** We recommend that teams use the following for VE against symptoms: **VE=35% (first dose), VE=80% (2nd dose, > 65 yrs), VE= 90% (2nd dose, < 65 yrs)** for Moderna/Pfizer, against Delta. **This is the initial VE, before any waning or Omicron.** VE is defined here as vaccine effectiveness against symptomatic disease. Teams should make their own informed assumptions about effectiveness and impacts on other outcomes (e.g., infection, hospitalization, death)
*  https://pubmed.ncbi.nlm.nih.gov/34619098/ (US) 
*  https://khub.net/documents/135939561/338928724/Vaccine+effectiveness+and+duration+of+protection+of+covid+vaccines+against+mild+and+severe+COVID-19+in+the+UK.pdf/10dcd99c-0441-0403-dfd8-11ba2c6f5801 (UK)
*  https://www.cdc.gov/vaccines/acip/meetings/downloads/slides-2021-09-22/04-COVID-Link-Gelles-508.pdf (US) 
*  https://pubmed.ncbi.nlm.nih.gov/34529645/ (US)
*  https://www.cdc.gov/mmwr/volumes/70/wr/mm7034e2.htm?s_cid=mm7034e2_w (US)

**Impact of boosters on VE against Omicron:** Boosters should be implemented in a way that individuals who have received a booster shot will revert to the same level of protection that they had before any waning occurred. Early data suggests that boosters of mRNA vaccine revert neutralization titers to Omicron to their base levels (the expectation would be that protection against all outcomes would revert to the levels seen with Delta, although there is considerable uncertainty) https://www.pfizer.com/news/press-release/press-release-detail/pfizer-and-biontech-provide-update-omicron-variant

**Booster doses:**
*  **Booster coverage:** With the emergence of the Omicron variant, we expect boosters to reach the higher end of coverage previously expected. However, multiple factors could complicate this, including loss of trust in the vaccine with immune escape from it. We will leave it to the teams.
    *  Past booster data until start of simulations should be based on state-specific booster uptakes for the period up to present. Data on vaccine boosters coverage is available at: https://covid.cdc.gov/covid-data-tracker/#vaccinations_vacc-total-admin-rate-total
    *  We recommend a saturation level of 40-70% for booster coverage, which is 40-70% of individuals who have already received a full vaccine course. The timing and pace of getting to saturation is left at teams discretion; note that a 6-month interval between the initial vaccine course and boosters is recommended. We recommend that 40-70% be applied to the state-specific coverage of 2nd dose in adults. 40% and 70% are based on the lower and upper bounds of a September survey of Kaiser Permanente that monitors propensity to get a booster shot among those who have already been vaccinated.  https://www.kff.org/coronavirus-covid-19/dashboard/kff-covid-19-vaccine-monitor-dashboard/  
    *  We do not specify different parameters for different combinations of vaccines available (eg, initial vaccination with Pfizer followed by Moderna booster, etc). 

**Booster timing:** Current booster eligibility is 6 months after an individual’s 2nd dose.
## Control Measures
We don’t specify different levels of non-pharmaceutical interventions (NPI) use; however, teams should consider that most schools have returned to in-person education in fall 2021 and high level health officials have noted that “people should feel safe to mingle at Thanksgiving and Christmas”. The future level of NPIs are left at the discretion of the modeling teams and should be specified in the teams’ metadata. Teams should also note the change in CDC mask recommendations for vaccinated people in high-transmission areas on 07/27/2021.
Additional scenario and simulation details
## Additional scenario and simulation details    
*	Vaccination:
    *	Pfizer / Moderna
        *	Vaccine efficacy (2-dose vaccines):
            *   B.1.1.7
                *   First dose: 50% against symptoms, 14 days after 1st dose
                *   Second dose: 90% against symptoms, 14 days after 2nd dose
            *   B.1.617.2
                *   First dose: 35% against symptoms, 14 days after 1st dose
                *   Second dose: 80/90% against symptoms, 14 days after 2nd dose, >< 65 yrs
            *   Effectiveness and impact on infection and other outcomes (hospitalizations, deaths) is at team’s discretion and should be clearly documented in team’s metadata.
            *   Doses 3.5 weeks apart
        *   Vaccine availability: No constraint in supply.
    *	Johnson & Johnson
        *	Vaccine efficacy (1-dose):
            *   70% VE against previous strains; 60% VE against B.1.1.7/B.1.617.2
        *	Vaccine availability:
            *	March-May 2021: based on data on administered doses, with continuing at rate current on date of projection for remainder of month (~10M total administered).
            *	June 2021-Nov 2022: No longer available; only 10M of 20M doses administered, supply, safety, and demand issues.
            *   Manner for accounting for protection provided in the 10M vaccinated during March-May 2021 at team's discretion.
*	Vaccine Hesitancy: Vaccine hesitancy expected to cause vaccination coverage to slow and saturate below 100%. Speed and level of saturation and heterogeneity between states (or other geospatial scale) and/or age groups are at the discretion of the team.
*	Delta (B.1.617.2) variant strain: At teams’ discretion. No immune escape feature for Delta variant.
*   **Transmission assumptions**: models fit to US state-specific dynamic up until End date for fitting data specified above – no proscribed R<sub>0</sub>, interventions, etc.
*   Pathogenicity assumptions: no exogenous fluctuations in pathogenicity/transmissibility beyond seasonality effects.
*   Vaccine effectiveness: see recommendations (same VE in all scenarios); assumptions regarding time required to develop immunity, age-related variation in effectiveness, duration of immunity, and additional effects of the vaccine on transmission are left to the discretion of each team
*   Vaccine immunity delay: There is approximately a 14 day delay according to the Pfizer data; because we suspect the post first dose and post second dose delays may be of similar length, we do not believe there is any need to explicitly model a delay, instead groups can delay vaccine receipt by 14 days to account for it.
*   Vaccine uptake: See specific details.
*   NPI assumptions: NPI estimates should be based on current trends and reported planned changes.
*   Database tracking of NPIs: teams may use their own data if desired, otherwise we recommend the following sources as a common starting point:
    *   [Coronavirus Government Response Tracker | Blavatnik School of Government (ox.ac.uk)](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker)
    *   [Coronavirus State Actions - National Governors Association (nga.org)](https://www.nga.org/coronavirus-state-actions-all/)


