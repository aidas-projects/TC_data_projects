## RFM (Recency, Frequency, Monetary value) Segmentation Dashboard

#### :small_orange_diamond: Task Description:
Do RFM analysis with a given data set. Your tasks are: Calculate recency, frequency and money value and convert those values into R, F and M scores. Segment customers into Best Customers, Loyal Customers, Big Spenders, Lost Customers, etc. Create dashboard.

#### :small_orange_diamond: Result:

[Interactive Google Looker Studio Dashboard](https://lookerstudio.google.com/reporting/a65dbab8-1731-4612-b6f0-b0e25b03b67a)

P.S.
Decided to create custom RFM score (r_score * 7.3 + f_score * 8.3 + m_score * 9.3) Assigned weighted averages as Monetary > Frequency > Recency. I think monetary value is substantially more important than frequency and frequency is more important than recency. Chose those weighted averages because I wanted to create rounded max score of 100. In this case lowest rounded RFM score is 25.

#### :pushpin: Preview:
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/RFM_Segmentation/rfm_dashboard_preview.png" width="912" height="1075" /> 


#### :pushpin: SQL Queries for data extraction:
:floppy_disk:  **SQL query for Recency, Frequency and Monetary values calculation + custom RFM score +customers segmentation.**
https://github.com/aidas-projects/TC_data_projects/blob/d199de73097ccc2da4b6fbdd19871d9733a1e608/RFM_Segmentation/rfm_segmentation.sql#L1-L109
