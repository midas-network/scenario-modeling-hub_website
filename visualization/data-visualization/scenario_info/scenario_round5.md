## Round 5 Scenarios    


### Scenario Differences

![](https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/previous-rounds/Round5_table.png)


\* **Vaccine-eligible population.** The eligible population for vaccination is presumed to be individuals aged 16 years or older until June 1, 2021. On June 1, the eligible population is presumed to extend to individuals aged 12 years and older.
\* **Vaccine hesitancy** is expected to cause vaccination coverage to slow and eventually saturate at some level below 100%. The saturation levels provided in these scenarios are National reference points to guide defining hesitancy, though the speed of that saturation and heterogeneity between states (or other geospatial scales) and/or age groups are at the discretion of the modeling team. The high vaccination 83% saturation is defined using the current estimates from the Delphi group ([link](https://delphi.cmu.edu/covidcast/indicator/?date=20210313&sensor=fb-survey-smoothed_covid_vaccinated_or_accept)) from March 13, 2021 data. The low saturation estimate of 68% is the lowest county-level estimate from the U.S. Census Bureau’s Pulse Survey from March 15, 2021 data ([link](https://data.cdc.gov/stories/s/Vaccine-Hesitancy-for-COVID-19/cnd2-a6zw)). Both of these saturation levels are assumed to be among the population eligible for vaccination, not the full population. 


### Common Specifications

**Vaccination**
*	<ins>Doses available</ins>: 
    *	50M Moderna/Pfizer 1st doses, 15M J&J doses available monthly
    *	Supply has likely eclipsed demand at this stage. Number of doses are for reference and as a reminder to account for different VE by manufacturer, but no longer indicate number of doses administered. Distribution of doses by manufacturer and associated vaccine efficacy should fit within these dose bounds.
*	<ins>VE</ins>: 
    *	75% and 95% against symptoms (Moderna/Pfizer 1st and 2nd dose)
    *	70% against symptoms (J&J)
    *	VE is defined here as vaccine effectiveness against symptomatic disease. Teams should make their own informed assumptions about effectiveness and impacts on other outcomes (e.g., infection, hospitalization, death). Data on VE studies of infection and symptomatic disease are included below.


### Vaccination Hesitancy
Vaccine hesitancy is expected to cause vaccination coverage to slow and eventually saturate at some level below 100%. The saturation levels provided in these scenarios are illustrative National reference points to guide defining hesitancy. The high vaccination scenario (low hesitancy) saturates at approximately 83% vaccination coverage nationally among the eligible population, as defined by current estimates from the Delphi group (link) from March 13, 2021 data (red line in figure). The low vaccination scenario (high hesitancy) saturates at approximately 68% vaccination coverage nationally among the eligible population, defined by the lowest county-level estimate from the U.S. Census Bureau’s Pulse Survey (link) from March 15, 2021 data. The speed of vaccination saturation should be defined by the modeling team, and can be defined as a logistic function (red and blue lines in figure below) or at different speeds (green line below). State or smaller geospatial unit and/or age group hesitancy limits should be defined by the modeling team using their best judgement. Overall national hesitancy should be similar to the illustrative levels defined in the scenarios, though is not expected to be exact. The eligible population for vaccination is presumed to be individuals aged 16 years or older until June 1, 2021. On June 1, the eligible population is presumed to extend to individuals aged 12 years and older.

![](https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/round5_hesitancycurves.png)


### Submission Information
| Scenario                                   | Scenario name for submission file | Scenario ID for submission file |
| ------------------------------------------ |:---------------------------------:|:-------------------------------:|
| Scenario A. High Vaccination, Moderate NPI | highVac_modNPI                    | A-2021-05-02                    |
| Scenario B. High Vaccination, Low NPI	     | highVac_lowNPI                    | B-2021-05-02                    |
| Scenario C. Low Vaccination, Moderate NPI	 | lowVac_modNPI                     | C-2021-05-02                    |
| Scenario D. Low Vaccination & Low NPI	     | lowVac_lowNPI                     | D-2021-05-02                    | 
*   **Submission date**: May 4, 2021 
*   **End date for fitting data**: May 1, 2021 - no fitting should be done to data from after this date
*   **Start date for fifth-round scenarios**: May 2, 2021 (week ending May 8) - first date of simulated outcomes
*   **Simulation end date**: October 30, 2021 (26-week horizon)


### Scenario and Simulation Details
*	**Social Distancing Measures:**
    *	Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.
    *	Declines over a period of 6 months starting at the start of May 2021 and ending in October 2021 at **designated level of control effectiveness** observed for April 2021. 
    *	Decline can be implemented at teams’ discretion (e.g., daily or monthly stepdowns).
    *	Decline can be gradual or sudden, and can differ in speed between states.
    *	The effectiveness of control in April 2021 should be based on the last two weeks of the month. 
    *	Reduction should be implemented based on each team’s best judgment, but should be done in such a way that a 100% reduction (0% of April 2021 effectiveness) would approximate an epidemic without NPIs (e.g., no masks, no social distancing) in place, but still including immunity, vaccination, etc. We recognize there is uncertainty about what transmission would be without NPIs; this uncertainty should be incorporated into the scenario projections.
*	**Testing-Trace-Isolate:** constant at baseline levels
*	**Masking:** Included as part of “Social Distancing Measures” above.
*	**Vaccination:**
    *	**Pfizer / Moderna**
        *	**Vaccine efficacy (2-dose vaccines):**
            *	First dose: 75% against symptoms, 14 days after 1st dose
            *	Second dose: 95% against symptoms, 14 days after 2nd dose
            *	Effectiveness and impact on infection and other outcomes (hospitalizations, deaths) is at team’s discretion and should be clearly documented in team’s metadata.
            *	Doses 3.5 weeks apart
        *	**Vaccine availability:**
            *	December-April: based on data on administered doses
            *	May-October: 50 million available first doses/month, with the intention of protocols being followed (100M doses/mo)
    *	**Johnson & Johnson**
        *	**Vaccine efficacy (1-dose vaccine):**
            *	Single dose: 70% against symptoms, 14 days after dose
            *	Effectiveness and impact on infection and other outcomes (hospitalizations, deaths) is at team’s discretion and should be clearly documented in team’s metadata.
        *	**Vaccine availability:**
            *	March-April: based on data on administered doses, with continuing at rate current on date of projection for remainder of month.
            *	April-September: 15M doses/month available May-October 2021
*	**Vaccine Hesitancy:** Vaccine hesitancy expected to cause vaccination coverage to slow and saturate below 100%. National vaccination saturation levels designated for each scenario serve as illustrative reference points to guide defining hesitancy, though the speed of that saturation and heterogeneity between states (or other geospatial scale) and/or age groups are at the discretion of the team. 
*	**B.1.1.7 Variant strain:** Teams should model the B.1.1.7 variant as appropriate to their model. Any assumptions (e.g., differences in severity/mortality, VE, or natural immunity) should be clearly defined in the metadata. The default assumptions are that the variant is 1.5x more transmissible than current strains and reaches 50% dominance by March 15 and 100% dominance by May 1 [(see MMWR report)](https://www.cdc.gov/mmwr/volumes/70/wr/mm7003e2.htm); here a 1.5x increase in transmissibility is defined as the increase in the expected number of infections by a single infected individual over their entire course of infection when there are no interventions or immunity in the population (e.g., a 1.5x increase in R0 in a classic epidemic model). No differences between B.1.1.7 and current strains in severity, mortality, or VE are assumed in default.
*   **Transmission assumptions**: models fit to US state-specific dynamic up until End date for fitting data specified above – no proscribed R<sub>0</sub>, interventions, etc.
*   **Pathogenicity assumptions**: no exogenous fluctuations in pathogenicity/transmissibility beyond seasonality effects
*   **Vaccine effectiveness**: level of effectiveness and available doses are specified for each scenario; assumptions regarding time required to develop immunity, age-related variation in effectiveness, duration of immunity, and additional effects of the vaccine on transmission are left to the discretion of each team
*   **Vaccine allocation**: between-state allocation is based on population per the CDC/NAS [guidelines](https://www.nap.edu/catalog/25917/framework-for-equitable-allocation-of-covid-19-vaccine#resources) (proportional allocation); within-state allocation and the impact of vaccine hesitancy are left to the discretion of each team
*   **Vaccine immunity delay:** There is approximately a 14 day delay according to the Pfizer data; because we suspect the post first dose and post second dose delays may be of similar length, we do not believe there is any need to explicitly model a delay, instead groups can delay vaccine receipt by 14 days to account for it
*   **Vaccine uptake:** See specific details.
*   **Vaccine rollout**: rollout to follow [ACIP recommendations](https://www.cdc.gov/vaccines/acip/meetings/downloads/slides-2020-12/slides-12-20/02-COVID-Dooling.pdf) unless known to be contradicted by state recommendations
    *   Phase 1a: health care workers, long-term care facilities
    *   Phase 1b: frontline essential workers, adults 75+
    *   Phase 1c: other essential workers, adults with high-risk conditions, adults 65-74
*   **NPI assumptions**: phased reductions of NPIs in 2021 that align with patterns observed at different times in the course of the epidemic in 2020-21 (see scenario-specific guidance); teams have some liberty on how to implement these reductions within the guidelines
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
*   **Uncertainty**: aligned with the Forecasting Hub we ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99 quantiles
*   **Ensemble Inclusion**: at present time, in order to be included in the ensemble models need to provide a full set of quantiles




