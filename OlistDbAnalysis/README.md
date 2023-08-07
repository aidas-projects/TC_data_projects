## Olist Database Analysis

#### :small_orange_diamond: Task Description:
Your manager is very happy with the data you provided him the week before, but now he is interested in how you can handle analysis on your own. He does not give you concrete questions to be answered, just asks you to use any data in the company databases and come up with a useful analysis on your own. It can be from different aspects of the business, but he expects you to provide him with at least 3-5 insights about business.

You should use tables from olist_db to come up with an analysis on your own. You will have to write SQL queries to extract needed data, then analyze and visualize this data either with Google Sheets or other data visualization tools. After all this, you will have to come up with a presentation oriented to executives from your company. Have in mind your audience for the presentation, these will be business oriented people who are not data analysts and may not have studied statistics before.

* Provide your analysis in Google Sheets or any other data visualization tool, have in mind that this file should contain all the things you tried to look at even if they did not bring any useful insights.

* Provide presentation with around 10 slides which would be business focused and would present only the most interesting 3-5 insights

#### :small_orange_diamond: Result:

[Google Sheets Link with analysis, calculations](https://docs.google.com/spreadsheets/d/1PnMO2s_RZ2QfIoSoawfZny68J9_Q3u0UvnrAz2yxVaw/edit?usp=sharing)

Sheet tabs market with red underline were not used in final presentation.

[Link to Powerpoint presentation (*.pptx format)](https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/olist_db_analysis.pptx)

**Powerpoint presentation** contains animated interactive elements. I suggest using View -> Reading View or fullscreen mode.

P.S. I used Google Looker Studio for chart creation where query had ~100k rows or more. This is due to Google Looker Studio being much more stable with bigger tables. If query had final table with few thousand rows, I simply used google sheets.


#### :pushpin: Presentation Preview:
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide2.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide3.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide4.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide5.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide6.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide7.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide8.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide9.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide10.PNG"/> 
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/OlistDbAnalysis/Slide11.PNG"/> 
 

#### :floppy_disk: SQL Queries for data extraction:

**Review Comment Lengh analysis**

https://github.com/aidas-projects/TC_data_projects/blob/382b259f6168a373bcc8b970aeed5bf31882279e/OlistDbAnalysis/review_comment_lengh.sql#L1-L6

**Purchase to Delivery analysis**
https://github.com/aidas-projects/TC_data_projects/blob/6077533ba94ce51ffa8a4ceb0ae566d7794829ab/OlistDbAnalysis/purchase_to_delivery_time.sql#L1-L8

**Estimated delivery time analysis**
https://github.com/aidas-projects/TC_data_projects/blob/9700c538e0d445d75ee4d5869b5a1a286d7d734e/OlistDbAnalysis/estimated_delivery_time.sql#L1-L8

**Items count per order analysis**
https://github.com/aidas-projects/TC_data_projects/blob/f3ae0c91e13cf0aa10c4bb67f43a33d961cb251d/OlistDbAnalysis/items_count_per_order.sql#L1-L17

**Product Category analysis**
https://github.com/aidas-projects/TC_data_projects/blob/e4f49b76f468c70e09a13ce100aee2b7c1b4b470/OlistDbAnalysis/product_category_analysis.sql#L1-L20

**TOP - BOTTOM sellers by revenue analysis**
https://github.com/aidas-projects/TC_data_projects/blob/d0da7cd30d72ae51cad08092fde259038d7aa3c4/OlistDbAnalysis/seller_by_revenue.sql#L1-L7

**Regions of Brazil analysis**
https://github.com/aidas-projects/TC_data_projects/blob/ebf67b4a93cb77ab014f3e4c867cc5edb450e5cc/OlistDbAnalysis/regions_of_brazil_analysis.sql#L1-L50

**Top Sellers by review rating analysis**
https://github.com/aidas-projects/TC_data_projects/blob/e9c3636755983135b3535816745e23152075f37e/OlistDbAnalysis/sellers_review_rating.sql#L1-L22
