<p>&nbsp;</p>
Round 13 of the COVID-19 Scenario Modeling Hub (SMH) considers the interaction of waning immunity against infection (first dimension) and the emergence of a new variant (2nd dimension) over a 52-week period. We follow the usual 2*2 table structure. 

<img src= https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/Round13_scenarios_table.PNG>

**Risk of severe disease, conditional on infection, does not wane with time and does not change with variant X** (see protection against severe disease section below). 
#### **Waning Immunity**

**Protection against infection:** Waning is defined as a transition to a partially immune state, where individuals retain a long-lasting yet partial level of protection against (re)infection. This can be considered an asymptotic plateau for immunity, where the trajectory of antibodies and other immune components stabilizes on a timescale of 4 or 10 months, depending on the scenario.

We prescribe the relative reduction in protection against infection after the waning period, where comparison is to the levels observed immediately after natural infection or vaccination. For example in the optimistic waning scenarios, a 40% reduction from baseline levels corresponds to the case where **protection from infection is 60% of** the baseline levels reported immediately after exposure (vaccination or infection). In the pessimistic scenarios, 60% reduction corresponds to the case where **protection from infection is 40% of** the baseline levels reported immediately after exposure. 

We leave the baseline levels of protection at teams’ discretion (eg, VE immediately after a 3rd vaccine dose), and only prescribe the relative reduction that applies after the waning period.

We assume that the timescale of waning does not depend on the number and type of exposures. For example, in scenario A, transition to a partially immune state would occur after a median of 10 mo after 2 vaccine doses, and so would the transition after 3 vaccine doses, or the transition after infection or re-infection. 

Teams can choose to bump individuals to a higher level of protection after repeat exposures (where exposure is vaccination or infection), but waning would still occur on a 4 to 10 mo timescale after each new exposure. If repeat exposures raise immunity to a high level, then after 4 or 10 mo of waning, an individual could reach an asymptotic plateau that is higher than where the individual would be 4 or 10mo after a single exposure. 

Natural immunity can be treated differently from vaccine-induced immunity, although the characteristics of decay of protection against infection should follow the parameters prescribed in the scenarios. 

Teams can choose different distributions of waning immunity (exponential, gamma) as long as the median is as specified in the scenarios.


**For scenarios B and D that consider new variant X, the risks of infection will need to be increased by the immune escape parameter provided in the second dimension of the table. **
Examples: For instance, let’s assume that VE against Omicron infection is 50% immediately after a booster shot in an individual <65 yrs. Then, per scenario A,  protection should decline to 60% of the initial value after 10 mo of waning (40% reduction, cf table), so that protection should be 0.50\*0.60=30% against Omicron infection 10 mo after boosting. This means VE is 30% against Omicron infection after 10 mo of waning for a boosted individual, or equivalently that their infection risk is 0.7\*risk of infection of an unvaccinated individual.

The second example illustrates how a repeat exposure could bump individuals to a higher protection level. Let’s consider the same person from before, who was in a plateau of 30% protection against infection after 10 mo, relative to an unvaccinated individual. Let’s assume that this individual gets infected, immunity is boosted, resulting in a protection of 70% immediately after this new infection. After 10 mo, per scenario A, the residual protection against infection would be 0.7*0.6= 42% in this individual, relative to an unvaccinated individual.

References for VE by variant, number of doses, and time since vaccination, can be found here:
*  https://www.medrxiv.org/content/10.1101/2022.01.07.22268919v2.full.pdf
*  https://www.cdc.gov/mmwr/volumes/71/wr/pdfs/mm7107e2-H.pdf
*  https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1054071/vaccine-surveillance-report-week-6.pdf

**Protection against severe disease:** We expect that at this stage of the pandemic, close to 100% of the US population has been naturally infected, vaccinated, or both, so that the entire population has long-lasting protection against severe disease upon (re)infection. **The probabilities of hospitalization and death given (re)infection are left at teams’ discretion**, with the understanding that this parameter can be calibrated against data during the Omicron wave, or defined based on (recent) literature (see below). **It is assumed that the probabilities of hospitalization and death given (re)infection do not wane over the timescale of the projections and apply to all circulating variants, including new variant X**. The probability of severe disease given (re)infection can vary by age and/or risk factors however. In other words, these conditional probabilities do not vary with time nor variants, but they can vary based on clinical and demographic host factors.

References on probability of hospitalization, conditional on (re)infection:
*  https://www.imperial.ac.uk/media/imperial-college/medicine/mrc-gida/2021-12-22-COVID19-Report-50.pdf
*  https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1054071/vaccine-surveillance-report-week-6.pdf
### **New variant X trajectory and immune escape:**

**Immune escape.** In scenarios B and D, we model the emergence of a new variant X, with moderate immune escape characteristics, taken to be 30%. Let’s consider an individual who is currently in a state of immunity to infection, gained from past exposure to SARS-CoV-2 antigens circulating before March 2022 (ie, infection with the wild type, Alpha, Delta, Omicron…) or vaccination (any number of doses). This individual, upon exposure to variant X, will have a 30% probability of infection with X, or a 30% increased probability of infection in a leaky model.

Immune escape only applies to risk of infection with X. Risk of severe disease given infection with variant X is a constant and is the same as that observed with Omicron, per the previous section.

**Transmissibility, severity.** The intrinsic transmissibility of the new variant should be the same as that of Omicron (same R0 as Omicron, with the R0 value of Omicron left at teams discretion).  Similarly, the intrinsic severity of X should be the same as Omicron.

**Introduction and ramp up.** Variant X is to be seeded in the first week of **May 2022 (May 1-7, 2022), with 50** active infections of variant X to be introduced during this week in the US (illustrating incoming variants from abroad). **There will be a continuous influx of 50 weekly infections of variant X for the next 16 weeks (weeks starting May 1, 2022 and ending August 20, 2022)**. Geographic dispersion of these infections is left at teams discretion. The ramp up of the new variant due to local transmission is also left at the teams’ discretion.

**Immunity after infection with variant X.** Infection with variant X provides immunity to previously observed variants (e.g., Delta, Omicron). After infection with variant X, immune waning should progress as specified by the scenarios.
### **Case projections and testing propensity:**
Scenarios in the 2\*2 table specify the risks of infection, while the risks of hospitalization and death conditional on (re)infection are left at teams discretion but remain constant. We do not address case projections in the scenarios, and do not make particular assumptions on case ascertainment. At this point of the pandemic, reported cases include a mix of symptomatic infections reported to local authorities via active and passive surveillance testing, along with an unknown amount of asymptomatic infections. At home testing is not captured in case observations. **We assume that over the 1 year projection period, testing propensity will remain constant at the level estimated at the start of the projection period.** In other words, the infection to case ratio should be calibrated to observations in the weeks leading to the start of the projection period and be kept constant for the following year.
### **Vaccine policy:**
We assume that vaccine policy is set at the start of the projection period in March 2022 and remains constant for the duration of simulations. As of Feb 2022, vaccination is recommended for all individuals over 5 yrs, (one round of) boosters are recommended for all individuals over 12 yrs, there is no  vaccine for children under 5yrs, there is no Omicron-specific vaccine, and two rounds of boosters (4 doses of mRNA vaccines) are not recommended for the general population. If new measures were to be announced before the start of round 13, we would include these measures in the scenarios. 
### **Unconstrained model parameters:**
*  **VACCINE EFFECTIVENESS**: VE is left at teams’ discretion (recent refs below)
    * https://www.medrxiv.org/content/10.1101/2022.01.07.22268919v2.full.pdf 
    * https://www.cdc.gov/mmwr/volumes/71/wr/pdfs/mm7107e2-H.pdf 
    * https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1054071/vaccine-surveillance-report-week-6.pdf 
*  **The effect of boosters do not need to be explicitly incorporated in the model** as long as reasonable assumptions about VE, averaged over different number of doses, can be made 
*  **Booster coverage recommendations (for teams incorporating explicitly):**
    * Past booster data until start of simulations should be based on state-specific booster uptakes for the period up to present. Data on vaccine boosters coverage is available on [CDC Covid Data Tracker](https://covid.cdc.gov/covid-data-tracker/#vaccinations_vacc-total-admin-rate-total).
    * We recommend a **saturation level of 40-70% for booster coverage**, which is 40-70% of individuals who have already received a full vaccine course. The timing and pace of getting to saturation is left at teams discretion; note that a 6-month interval between the initial vaccine course and boosters is recommended. We recommend that 40-70% be applied to the state-specific coverage of 2nd dose in adults. 40% and 70% are based on the lower and upper bounds of a [September 2021 survey of Kaiser Permanente]( https://www.kff.org/coronavirus-covid-19/dashboard/kff-covid-19-vaccine-monitor-dashboard/) that monitors propensity to get a booster shot among those who have already been vaccinated. 
    * We do not specify different parameters for different combinations of vaccines available (eg, initial vaccination with Pfizer followed by Moderna booster, etc). 
    * Booster timing: Current booster eligibility is 6 months after an individual’s 2nd dose.
*  **Child vaccine coverage:**
    * <ins>5-11yr:</ins> continue as previous rounds, with rates and saturation at teams’ discretion.
    * <ins>6m-4yr:</ins> no vaccination.
*  **Updated vaccines:** Manufacturers are working on updated vaccines formulated for Omicron, though the timeframe and rollout of these are unknown. <ins>*For R13 we will not include these.*</ins>
*  **Initial Conditions:** Prevalence of Omicron at the start of the projection period (March 13, 2022) is at the discretion of the teams based on their interpretation/analysis of the available data and estimates at the the time of projection. Variation in initial prevalence between states is left at teams’ discretion. 
*  **NPIs, control, behavior change:** Seasonal changes in transmission are left to each group’s discretion. However, <ins>*R13 should NOT include responsive changes in NPIs or behavior*</ins> (i.e., increased control due to Omicron or variant X concerns). 
    * Database tracking of NPIs: teams may use their own data if desired, otherwise we recommend the following sources as a common starting point:
        * [Coronavirus Government Response Tracker | Blavatnik School of Government (ox.ac.uk)](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker)
        * [Coronavirus State Actions - National Governors Association (nga.org)](https://www.nga.org/coronavirus-state-actions-all/)
*  Teams should use their own judgments to parametrize protection against symptoms in the partially immune state, and any reduction in transmission that partially immune individuals may have.
*  Teams can choose to treat individuals who have immunity from natural infection and vaccination differently from individuals who had a single exposure to the pathogen/antigen. 
*  We do not provide any suggested waning parameters for J&J (for which the starting point VE is much lower): teams can choose to ignore J&J, which represents a small fraction of all vaccinated in the US, or apply a different waning for J&J.
*  We do not provide any suggested waning parameters for those who only get a 1st dose of Pfizer or Moderna and hence never acquire full vaccine immunity. We believe this represents a small fraction of all vaccinated. Teams can choose to apply a different waning to these individuals, or ignore them.
All of these assumptions should be documented in meta-data and abstract.

**Projection time horizon:** We consider a 52-week projection period


## Submission Information    
| Scenario                                                     | Scenario name for submission file | Scenario ID for submission file |
| ------------------------------------------------------------ |:---------------------------------:|:-------------------------------:|
| Scenario A. Optimistic waning, No immune escape variant      | optWan_noVar     | A-2022-02-25    |
| Scenario B. Optimistic waning, New immune escape variant     | optWan_Var       | B-2022-02-25    |
| Scenario C. Pessimistic waning, No immune escape variant     | pessWan_noVar    | C-2022-02-25    |
| Scenario D. Pessimistic waning, New immune escape variant    | pessWan_Var      | D-2022-02-25    | 
*   **Due date**: March 15, 2022
*   **End date for fitting data**: March 12, 2022 (no later than March 12, no earlier than March 5)
*   **Start date for scenarios**: March 13, 2022 (first date of simulated transmission/outcomes)
*   **Simulation end date: March 11, 2023 (52-week horizon)**

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
## Control Measures
We don’t specify different levels of non-pharmaceutical interventions (NPI) use; however, teams should consider that most schools have returned to in-person education in fall 2021 and high level health officials have noted that “people should feel safe to mingle at Thanksgiving and Christmas”. The future level of NPIs are left at the discretion of the modeling teams and should be specified in the teams’ metadata. Teams should also note the change in CDC mask recommendations for vaccinated people in high-transmission areas on 07/27/2021.
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


