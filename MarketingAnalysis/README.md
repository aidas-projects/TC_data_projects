## Marketing Analysis - Marketing Campaign Trends - Sessions Duration 

#### :small_orange_diamond: Task Description:
Identify overall trends of all marketing campaigns on your ecommerce site. Marketing manager is particularly interested in finding out if users tend to spend more time on your website on certain weekdays and how that behavior differs across campaigns. Explore the data. See whether there are interesting data points that can give more insights. Provide analytical insights


#### :small_orange_diamond: Result:

[Interactive Google Looker Studio Dashboard](https://lookerstudio.google.com/reporting/cb653ea9-05ba-4c89-a463-9da062fc7da4)

#### :pushpin: Preview:
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/MarketingAnalysis/session_duration_dashboard_preview.png"/> 

#### :small_orange_diamond: Insights:

:white_check_mark:  **Outliers elimination**

All sessions with duration of 8h and longer were eliminated. 
That excluded ~750 events 
3 events for Data Share Promo
1 event for Holiday_V1

All sessions with duration of 10 seconds and shorted were eliminated.
That excluded ~163 400 events
326 events for Data Share Promo
24 events for BlackFriday_V2
13 events for NewYear_V1
7 events for NewYear_V2
3 events for Holiday_V2
2 events for Holiday_V1
1 event for BlackFriday_V1

:white_check_mark: **Day of the Week Sessions**

Shortest sessions are on Sunday 5:39 min on average. Saturday and Monday sessions are around 30 sec longer at around 6min 8 sec.
Tuesday, Wednesday, Thursday and Friday sessions length is very similar at around 6 min 30 sec.

Browsing events per minute are a bit higher on weekend, that means that while weekend browsing sessions typically are a little bit shorter, users on weekends tend to engage with the content 4-5% more.

According to analytics company databox.com average session duration for B2B companies is 77.61 seconds, For B2C companies, the median value is higher – 92.33 seconds (2022 data).
Taking that into account I consider our average session length of over 6min is superb. Our website is engaging our users enough to browse for longer period of time than industry standard. 

Additional research is needed to figure out if different target audience is visiting our website on weekends. Checking different user segments might be helpful too. 

:white_check_mark: **Campaign Sessions**

Campaign analysis at this point has a major flaw. There are not that many Campaign sessions. 
For instance event before eliminating outliers BlackFriday_V1 campaign had only 9 sessions.  Holiday_V1 campaign had 18 sessions. This is not a sufficient amount of sessions to make any kind of short term or long term decision.

Upon specific marketing manager request I created a table with weekly campaigns sessions duration comparison.
But I advice against coming to some specific conclusions and creating strategic decisions because of this data. Ideally we would like to have at least 1000 sessions for campaign (like for example Data Share Promo campaign) to be able to compare campaign session


#### :floppy_disk: SQL Queries for data extraction:

My logic of website session follows these rules:
1. Session starts when unique user id has event_name = 'session_start'. If there is no 'session_start' event, then session start is earliest event timestamp for unique user id.
2. Session ends with the last event timestamp for unique user id. In case same user id has multiple sessions, session ends 1 event timestamp before next session_start event timestamp.

**Added additional column 'events_count'** to see how many events happened during session. 
Higher amount of events means higher activity on webpage. Will be interesting to check not only average session lengh, but compare it to how active user were during those sessions. 

**Added additional column 'events_per_min'**. It calculates how many events happened during 1 minute of session. The higher this KPI is, the more engaged user is during session.

https://github.com/aidas-projects/TC_data_projects/blob/36187bce59a791dd9c5d84996f7b73642c943712/MarketingAnalysis/session_duration_calculation.sql#L1-L44



:floppy_disk: **Verifying Query Results**

If wee look at the details of this specific user id - 4493164.4370079942. We will notice that this user has 2 sessions on 2021-01-06 and 2021-01-28.
1st session has '(referral)' campaign value as this is the campaign value with the earliest timestamp for this session.
2nd session has 'NewYear_V1' campaign value as this is the campaign value with the earliest timestamp for this session.
```sql
SELECT *  
  FROM
    turing_data_analytics.raw_events
  WHERE user_pseudo_id = '4493164.4370079942'

  ORDER BY event_timestamp
```
So this is ideal scenario to verify if sessions are split correctly (with correct timestamps) and if campaign names are assigned correctly. 


This is my SQL query filtered by user_pseudo_id = '4493164.4370079942'

https://github.com/aidas-projects/TC_data_projects/blob/906a6d7ab5456556f6a0c2fb924fd719b593740d/MarketingAnalysis/verifying_query_results.sql#L1-L32

**VERIFIED - RESULTS ARE CORRECT**
| event_date  | user_pseudo_id | session_start | session_end | session_duration_in_sec | campaign | events_count |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 2021-01-06  | 4493164.4370079942  | 1609925798703416  | 1609926112213797  | 313.510381  | (referral)  | 17  |
| 2021-01-28  | 4493164.4370079942  | 1611802231926754  | 1611802586762827  | 354.836073  | NewYear_V1  | 21  |


