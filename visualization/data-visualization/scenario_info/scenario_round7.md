## Round 7 Scenarios    


*Round 7 is an update of Round 6 with updated data and understanding of both the Delta variant and Vaccination hesitancy.*


### Scenario Differences

![](https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/previous-rounds/Round7_table.png)


\* **Vaccine-eligible population.** The eligible population for vaccination is presumed to be individuals aged 12 years and older through the end of the projection period.
\** **Vaccine hesitancy** is expected to cause vaccination coverage to slow and eventually saturate at some level below 100%. The saturation levels provided in these scenarios are National reference points to guide defining hesitancy, though the speed of that saturation and heterogeneity between states (or other geospatial scales) and/or age groups are at the discretion of the modeling team. The high vaccination 80% saturation is defined crudely as using the current estimates from the Delphi group, adjusted for potential bias in respondents, who tend to be more highly vaccinated that the general US population ([link](https://delphi.cmu.edu/covidcast/indicator/?date=20210313&sensor=fb-survey-smoothed_covid_vaccinated_or_accept), updated from Round 6). The low saturation estimate of 70% is based on an adjustment of the Pulse Survey overall estimate, adjusted for survey participant vaccination coverage. This number also mirrors the lowest county-level estimate (73.3%) from the U.S. Census Bureau’s Pulse Survey from May 26-June 7, 2021 ([link](https://data.cdc.gov/stories/s/Vaccine-Hesitancy-for-COVID-19/cnd2-a6zw)), which is updated from Round 6. 


### Common Specifications

**NPI:** In contrast to past scenarios, we don’t specify different levels of non-pharmaceutical interventions (NPI) use; **however, teams should consider that most schools intend to return to in-person education in the fall**. The future level of NPIs are left at the discretion of the modeling teams and should be specified in the teams’ metadata.

**Vaccination**
*   <ins>Doses available</ins>: 
    *	50M Moderna/Pfizer 1st doses available monthly, June 2021-January 2022
    *   J&J no longer available (after May 2021)
    *	Supply has likely eclipsed demand at this stage. Number of doses are for reference and as a reminder to account for different VE by manufacturer, but no longer indicate number of doses administered. Distribution of doses by manufacturer and associated vaccine efficacy should fit within these dose bounds.
*	<ins>VE</ins>: 
    *	Optimistic (**50% and 90%** against symptoms (Moderna/Pfizer 1st and 2nd dose) vs. Delta) is based on reports from the UK and the manufacturers indicating decreased protection against new variants such as Alpha and Delta after 1st dose, and no substantial decrease after 2nd dose. 
    *   Pessimistic (**35% and 85%** against symptoms (Moderna/Pfizer 1st and 2nd dose) vs. Delta) is based on reports from the UK and Israel indicating further decreased protection against the Delta variant after 1st dose, and notable decrease after 2nd dose. 
    *	VE is defined here as vaccine effectiveness against symptomatic disease. Teams should make their own informed assumptions about effectiveness and impacts on other outcomes (e.g., infection, hospitalization, death).

**Delta variant strain with increased transmissibility:** The scenarios define the Delta (B.1.617.2) variant as <ins>**40% and 60%**</ins> more transmissible than Alpha (B.1.1.7.) **Initial prevalence should be estimated or defined by the teams based on sequencing and other relevant data, preferably at the state level.**  Timeframe of the increase in variant prevalence is up to each team, but it should be assumed the variant(s) become dominant due to increased transmissibility. The variant is more transmissible but it is not an immune escape variant; further, no decline of immunity from vaccination (other than VE) or natural infection should be modeled for Delta or other circulating variants. Other assumptions are at the discretion of each team, but should be documented in metadata. More info on next page.


### Vaccination Hesitancy
Vaccine hesitancy is expected to cause vaccination coverage to slow and eventually saturate at some level below 100%. The saturation levels provided in these scenarios are illustrative National reference points to guide defining hesitancy. The high vaccination scenario (low hesitancy) saturates at 86% vaccination coverage nationally among the vaccine-eligible population (updated from 83% in Round 5), as defined by current estimates from the Delphi group ([link](https://delphi.cmu.edu/covidcast/indicator/?date=20210313&sensor=fb-survey-smoothed_covid_vaccinated_or_accept)) (red line in figure, borrowed from round 5, but the same spirit applies to round 6). The low vaccination scenario (high hesitancy) saturates at 75% vaccination coverage nationally among the vaccine-eligible population, defined by the lowest county-level estimate from the U.S. Census Bureau’s Pulse Survey ([link](https://data.cdc.gov/stories/s/Vaccine-Hesitancy-for-COVID-19/cnd2-a6zw)) from April 24, 2021 data. The speed of vaccination saturation should be defined by the modeling teams, and can be defined as a logistic function (red and blue lines in figure below) or at different speeds (green line below). State or smaller geospatial unit hesitancy limits should be defined by the modeling team using their best judgment. Overall national hesitancy should be similar to the illustrative levels defined in the scenarios, though is not expected to be exact. The eligible population for vaccination is presumed to be individuals aged 12 years and older.

![](https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/master/round5_hesitancycurves.png)


### Submission Information
| Scenario                                                               | Scenario name for submission file | Scenario ID for submission file |
| ---------------------------------------------------------------------- |:---------------------------------:|:-------------------------------:|
| Scenario A. High Vaccination, Low Variant Transmissibility Increase    | highVac_lowVar                    | A-2021-07-13                    |
| Scenario B. High Vaccination, High Variant Transmissibility Increase   | highVac_highVar                   | B-2021-07-13                    |
| Scenario C. Low Vaccination, Low Variant Transmissibility Increase	 | lowVac_lowVar                     | C-2021-07-13                    |
| Scenario D. Low Vaccination, High Variant Transmissibility Increase    | lowVac_highVar                    | D-2021-07-13                    | 
*   **Due date**: July 13, 2021 
*   **End date for fitting data**: July 03, 2021 (no fitting should be done to data from after this date)
*   **Start date for scenarios**: July 04, 2021  (first date of simulated transmission/outcomes)
*   **Simulation end date**: January 01, 2022  (26-week horizon)


### Scenario and Simulation Details
*	**Social Distancing Measures:**
    *	Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.
    *   Current and future levels of social distancing are to be defined by the teams based on their understanding of current and planned control and behavior and expectations. Teams should consider that most jurisdictions are opening fairly quickly, and most schools intend to return to in-person education in the fall. No reactive interventions should be planned.
*	**Testing-Trace-Isolate:** constant at baseline levels
*	**Masking:** Included as part of “Social Distancing Measures” above.
*   **Immune waning and Immune escape:** As defined by the modeling team.
*	**Vaccination:**
    *	**Pfizer / Moderna**
        *	**Vaccine efficacy (2-dose vaccines):**
            *   B.1.1.7
                *	<ins>First dose: **50% against symptoms**</ins>, 14 days after 1st dose
                *	<ins>Second dose: **90% against symptoms**</ins>, 14 days after 2nd dose
            *   B.1.617.2
                *	<ins>First dose: **35% vs 50% against symptoms**</ins>, 14 days after 1st dose
                *	<ins>Second dose: **85% vs 90% against symptoms**</ins>, 14 days after 2nd dose
            *	Effectiveness and impact on infection and other outcomes (hospitalizations, deaths) is at team’s discretion and should be clearly documented in team’s metadata.
            *	Doses 3.5 weeks apart
        *	**Vaccine availability:**
            *	December-June: based on data on administered doses
            *	July-January: 50 million available first doses/month, with the intention of protocols being followed (100M doses/mo)
    *	**Johnson & Johnson**
        *	**Vaccine efficacy (1-dose):**
            *   70% VE against previous strains; 60% VE against B.1.1.7/B.1.617.2
        *	**Vaccine availability:**
            *	March-May: based on data on administered doses, with continuing at rate current on date of projection for remainder of month (~10M total administered).
            *	June-January: No longer available; only 10M of 20M doses administered, supply, safety, and demand issues.
            *   Manner for accounting for protection provided in the 10M vaccinated during March-May at team's discretion.
*	**Vaccine Hesitancy:** Vaccine hesitancy expected to cause vaccination coverage to slow and saturate below 100%. National vaccination saturation levels designated for each scenario serve as illustrative reference points to guide defining hesitancy, though the speed of that saturation and heterogeneity between states (or other geospatial scale) and/or age groups are at the discretion of the team. 
*	**Alpha (B.1.1.7) variant strain:** Teams should model the B.1.1.7 variant as appropriate to their model. Any assumptions (e.g., differences in severity/mortality, VE, or natural immunity) should be clearly defined in the metadata. The default assumptions are that the variant is 1.5x more transmissible than wild-type strains and followed the trajectory outlined here [(see MMWR report)](https://www.cdc.gov/mmwr/volumes/70/wr/mm7003e2.htm); here a 1.5x increase in transmissibility is defined as the increase in the expected number of infections by a single infected individual over their entire course of infection when there are no interventions or immunity in the population (e.g., a 1.5x increase in R0 in a classic epidemic model). No differences between B.1.1.7 and wild strains in severity, mortality, or VE are assumed in default.
*	**Delta (B.1.617.2) variant strain:** Transmission advantage of Delta should follow the scenario guidelines; additional features are at the discretion of the team. Any additional assumptions (e.g., differences in severity/mortality, VE) should be clearly defined in the metadata. The scenarios define the Delta variant as <ins>**40% or 60%**</ins> more transmissible than Alpha and other strains circulating in the US. Prevalence is not pre-specified – teams are expected to define this on their own. Here a 40%/60% increase in transmissibility is defined as the increase in the expected number of infections by a single infected individual over their entire course of infection when there are no interventions or immunity in the population (e.g., a 40/60% increase in R0 in a classic epidemic model). Timeframe of the increase in variant prevalence is up to each team, but it should be assumed the variant(s) become dominant due to increased transmissibility. No immune escape feature for Delta variant.
*   **Transmission assumptions**: models fit to US state-specific dynamic up until End date for fitting data specified above – no proscribed R<sub>0</sub>, interventions, etc.
*   **Pathogenicity assumptions**: no exogenous fluctuations in pathogenicity/transmissibility beyond seasonality effects
*   **Vaccine effectiveness**: level of effectiveness and available doses are specified for each scenario; assumptions regarding time required to develop immunity, age-related variation in effectiveness, duration of immunity, and additional effects of the vaccine on transmission are left to the discretion of each team
*   **Vaccine allocation**: between-state allocation is based on population per the CDC/NAS [guidelines](https://www.nap.edu/catalog/25917/framework-for-equitable-allocation-of-covid-19-vaccine#resources) (proportional allocation); within-state allocation and the impact of vaccine hesitancy are left to the discretion of each team
*   **Vaccine immunity delay:** There is approximately a 14 day delay according to the Pfizer data; because we suspect the post first dose and post second dose delays may be of similar length, we do not believe there is any need to explicitly model a delay, instead groups can delay vaccine receipt by 14 days to account for it
*   **Vaccine uptake:** See specific details.
*   **Vaccine roll-out**: roll-out to follow [ACIP recommendations](https://www.cdc.gov/vaccines/acip/meetings/downloads/slides-2020-12/slides-12-20/02-COVID-Dooling.pdf) unless known to be contradicted by state recommendations
    *   Phase 1a: health care workers, long-term care facilities
    *   Phase 1b: frontline essential workers, adults 75+
    *   Phase 1c: other essential workers, adults with high-risk conditions, adults 65-74
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
*   **Uncertainty**: aligned with the Forecasting Hub we ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99 quantiles
*   **Ensemble Inclusion**: at present time, in order to be included in the ensemble models need to provide a full set of quantiles




