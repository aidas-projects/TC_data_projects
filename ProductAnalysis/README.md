## Product Analysis - Daily Visit to Purchase Duration

#### :small_orange_diamond: Task Description:
Identify how much time it takes for a user to make a purchase on your website. Your Product Manager would like to see the users' duration from first arriving on the website on any given day until their first purchase on that same day. Your final result should show the duration dynamic daily. Explore the data. See whether there are interesting data points that can give more insights. Provide analytical insights. Create effective visualizations.


#### :small_orange_diamond: Result:

[Interactive Google Looker Studio Dashboard](https://lookerstudio.google.com/reporting/c6a6dd59-7e54-470f-ae5f-0868b97eb35f)

#### :pushpin: Preview:
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/ProductAnalysis/visit_to_purchase_dashboard_preview.png" width="895" height="1974" /> 

#### :small_orange_diamond: Insights:

:white_check_mark: **Daily/Weekly Averages**

**Average website visit to purchase is 1h 7min** (1h:07min:39s)
**Median visit to purchase time is 18min** (18min:43s)

**Visit to Purchase duration substantially increase with average order size:**
Average VtP duration for order **$1-$100 - 1h 3min**
Median VtP duration for order **$1-$100 - 17min**

Average VtP duration for order **$101-$200 - 1h 26min**
Median VtP duration for order **$101-$200 - 33min**

Average VtP duration for order **$201-$400 - 1h 48min**
Median VtP duration for order **$201-$400 - 1h 07min**

This could be explained by customers not needing a lot of time to think if the order is relatively cheap, while for more expensive orders customers most likely spending more time evaluating if they actually need the purchase and/or most likely comparison shopping.

**Temporary dip for average visit to purchase duration was recorded during December 26th to January 18th.**
Why this happened needs further investigation. It might be that while we had NewYear_V1 and NewYear_V2 ad campaigns during January of 2021 there were substantial amount of very well targeted potential customers who ended up buying substantially quicker after landing on our website. Unfortunately at this point in database there is no ad campaign info assigned to customer purchases. So this is just speculation at this point.

**Weekday Visit to Purchase Duration**
Initial assumption was that customers will spend more time during the weekend from visit to purchase because they have substantially more time. But indicial assumption was wrong as data shows that customers on average spend less time between visit and purchase during weekend.

:white_check_mark: **Customers segments overview**

From additional data analysis we can see that:

**Customers who use tablets to place orders on average spend less time from visit to purchase - 1h:06min.**
While **mobile device and PC users** usually spend around **1h:14min** from visit to purchase. 

**Microsoft Edge web browser users** on average spent less time (**1h:00min**) from visit to purchase than other browser users. While other browser users on average spent around  **1h:14min** from visit to purchase.

**Google Pixel smartphone users** on average spent only **44min** from visit to purchase while **Samsung** smartphone users **spent 1h:19min**.

:white_check_mark: **Revenue ($) per Minute KPI**

**Created a new KPI Revenue ($) per Minute in the context of visit to purchase duration.**
**Revenue ($) per Minute KPI** is how much revenue customer generates during the time spent between website visit and purchase.
**Revenue ($) per Minute calculation** - Order size in $ / Minutes spent between visit to purchase.
If **Revenue ($) per Minute** is high, that means that specific customers segment is either very quick to purchase (visit to purchase duration is short) or has larger $ order size while take longer to purchase. 

While **tablet device users on average were quickest** from visit to purchase, **tablet device users Revenue per Minute was lowest among all the devices. $3.18 for tablets**, $4.19 desktop, $4.23 mobile.

Revenue per minute is highest among users of **Android devices made by Xiaomi - $8.84 per minute. Other smartphone device users bring only ~$4 revenue per minute.**

:white_check_mark: **Countries**

**Japan, Germany, United States, United Kingdom**, countries with large market spend less than average time from visit to purchase. That could be related to substantially higher competition in these countries, so potential customers more often comparison shopping and once they decided to purchase, they do that quickly.

**South East Asia market**
**Thailand, Indonesia and Malaysia** not only place order quickly (short duration between visit and purchase), but also order size is higher than average order size in $. 
**Philippines** has slightly lower than average order size $, but places orders very quickly. 
We should do more analysis into SE Asia market as advertising cost there is substantially lower than in Europe or North America. If average SE Asian customer orders quickly and average order size ($) is larger than average, it might be worth it to invest more into expansion in this region.

#### :pushpin: SQL Queries for data extraction:

https://github.com/aidas-projects/TC_data_projects/blob/f7447a1f60948ab7d3fc4b59bf47f700781f5157/ProductAnalysis/time_from_visit_to_purchase.sql#L1-L95

:floppy_disk: **Checking if values in my final table are correct.**

This specific ID has 2 purchases on the same day 2020-11-01. And only earliest purchase with correct first_event_timestamp and first_purchase_timestamp should be in my final table.

first_event_timestamp = 1604242428392090 first_purchase_timestamp = 1604243533156551

Checking my main query final table... These should be only 1 row of user_pseudo_id = '29640692.9507522627' with first_event_timestamp and first_purchase_timestamp mentioned above.

**VERIFIED! It's CORRECT.**
https://github.com/aidas-projects/TC_data_projects/blob/d7c522e23f8328f4acff2eed8e3a3d765bbb276a/ProductAnalysis/sqlquery_validation.sql#L1-L6
