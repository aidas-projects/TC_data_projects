## Credit Risk Analysis - Probability of Default model creation

#### :small_orange_diamond: Task Description:
The final Basel III framework will be implemented on 1 of January, 2024. Your manager asks you to calculate credit risk RWA and capital requirement for the bank's portfolio. You have to use data from the file Loan_default which contains loans with a status indicator: defaulted(bad) or non-defaulted. Here is short description of data columns:

* **Now you have to calculate credit risk RWA for the given data under both: standardized(follow the regulation, as in the hands on task) and IRB approach and compare the results.**
* For the Probability of Default model, the **model's goodness of fit will not be evaluated**.
* All given loans in the dataset are mortgage loans.
* For the lines with missing collateral values, use default LTV = 0.45.

* **Create effective visualizations and briefly comment your findings.**

[Link to dataset and my analysis on Google Sheets](https://docs.google.com/spreadsheets/d/1P_XpGCcXvTAYoGnay2steL0WmbVZkFLJITDtKQ1s2Zo/edit?usp=sharing)

P.S. Instead of suggested free software **GRETL**, I tried to use the professional statistical model creation software called [**JMP Pro 17**](https://www.jmp.com/en_us/software/predictive-analytics-software.html) (developed by JMP, a subsidiary of SAS Institute). It took a while to understand how to use it, but many youtube videos later I am happy I did it. 

**Few notes:**

I consider rows with missing **MORTDUE (Amount due on existing mortgage)** values as morgage already fully paid, so for these rows there is no EAD (Exposure at Default) and there is no RWA (Risk Weighted Assets). I consulted about this specific issue with my STL during standup call and also joined JTL open-session. I did not receive clear answer how to handle these very important missing values. And was told that it is up to my interpretation how to solve this. My decision is that "I pretend that I consulted with my manager and was told that these missing MORTDUE values are in fact fully paid mortgages" :)

**modified_hmeq sheet** - This is my initial data table cleaning sheet which includes formulas. And my final table which I used for model creation is in final_table_with_model sheet. It just happened that I imported my modified_hmeq sheet table into JMP Pro software, tested some variable modifications, calculated odds and probabilities and just copy pasted that data back to new google sheet. So you will not find any new variables or values in modified_hmeq sheet.

And all model parameters, variables, confusion matrix you will find in final_table_with_model sheet. Just scroll to the right. It starst with AC column.

**IRB_approach_RWA sheet is where all IRB RWA calculations were done.** Also here you will find my charts and notes about comparing 2 different approaches.

### :white_check_mark: Standardized approach RWA calculation

:pushpin: **Standardized mortgage porfolio RWA (Risk Weighted Assets) and Capital Requirements calculation**

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/CreditRiskAnalysis/standardized_rwa.png"/> 

### :white_check_mark: IRB approach RWA calculatin

:pushpin: **Cleaning data and handling missing values (preparing dataset for Logistic Regression model building)**
	
	
1.	Variable **REASON** had 2 different values **HomeImp** and **Debtcon**
	Changed **REASON** column to column HomeImp with varaibles 1 and 0. Removed **Debtcon** dummy variable to avoid collinearity.
	243 values were missing (~4.07%). I converted these values to 0. Basically equivalent to these rows having **Debtcon** which was removed and was most common value (68.81% of whole dataset).
	
2.	Variable **JOB** had 6 variables: **Mgr, Office, Other, ProfExe, Sales, Self**
	Changed JOB column to seperate columns with each job type with variables 1 and 0. Removed **Other** (variable with highest frequency) dummy variable to avoid collinearity.
	268 values were missing (~4.49%). I converted these values to 0. Basically equivalent to these rows having JOB as **Other** which was removed and was most common value (42.03% of whole dataset).
	
3.	If **MORTDUE** variable had value and **VALUE** variable had missing value, I used LTV 0.45 to calculate VALUE (MORTDUE/0.45).  
	This is due to Graded Task description stating, that **"For the lines with missing collateral values, use default LTV = 0.45."** Therefore if know MORTDUE and LTV values, I can calculate VALUE variable.
	Total of 84 VALUE variable missing values were filled in this way.
	
4.	Because rows with no **MORTDUE** value were not used in **standardized risk calculation approach** (Assumption is that these are mortgages which are already fully paid up).
	Therefore I also decided to not use these rows for **IRB approach** (logistic regression)
	
5.	Variable **YOJ (Years at present job)** I binned into buckets of 0, 1-2, 3-5, 6-10, 11-20 and 21ormore.
	I took out the bucket 6-10 column to avoid collinearity.
	506 values were missing (~8.49%). I saw that there is a little bit of correlation between **YOJ** (Years at present job) and **CLAGE** (Age of oldest credit line in months). **Correlation of 0.2017**.
	It makes sense that the longer person worked at the present job, the older their oldest credit line is.
	So I decided to fill missing **YOJ (Years at present job)** the following way:
	* if YOJ value is missing, I take a note of **CLAGE** value for this particular row.
	* try to find at least 100 rows with very similar **CLAGE** value. (I slowly expanded range until there were at least 100 rows for this particular **CLAGE** value). Also I make sure this rows have **YOJ** value present.
	* Once I have 100 or more rows withing range of my interest, I check at which **YOJ** bucket there are the most occurancies (1). And input the missing **YOJ** value as 1 at this particular bucket. 
	
	For instance I had a row with **YOJ** missing value which had **CLAGE** values as 300.86.
	I had to expand my range to ~295-305 for **CLAGE** column to find 101 rows in total.
	In the end I had **YOJ_6-10** with most occurancies.
	So in the end I chose to fill missing values **1** in the bucket **YOJ_6-10**.
	
	515 values were missing in **YOJ**.
	381 values were filled by method mentioned above.
	The rest 134 were filled with most frequent value **YOJ_6-10 = 1**
	
6.	**DEROG: Number of major derogatory reports.** Had 708 missing values (11.88% of whole dataset).
	But DEROG value 0 is the most frequent value (75.96%). So I filled 708 missing values with 0.
	
7.	Very similar situation with **DELINQ: Number of delinquent credit lines**. 580 missing values (9.73% of whole dataset).
	But **DELINQ** value 0 is the most frequent value (70.11%). So I filled 508 missing values with 0.
	
8.	**CLAGE: Age of oldest credit line in months**. As mentioned before **CLAGE** a little bit correlated with **YOJ** (Years at present job). **Correlation of 0.2017**.
	So I used similar method to fill 308 missing values for **CLAGE** variable.
	If missing **CLAGE** values had **YOJ** values as 1, I took all all non missing **CLAGE** values where **YOJ** had values as 1 and checked the evarage **CLAGE** value for these rows. 
	And I filled all **CLAGE** missing values (where **YOJ** was 1) with that average.
	Those missing values which left unfilled (did not have YOJ value), were filled with median value of 173.46667 
	
9.	**NINQ: Number of recent credit inquiries.** Had 510 missing values (8.56% of whole dataset). 
	But **NINQ** value 0 is the most frequent value (42.47%). So I filled 510 missing values with 0.
	
10.	**CLNO: Number of credit lines.** Had 222 missing values (3.72% of whole dataset).
	Median values is 20. Average value is 21.29. Decided to fill missin values with median value 20.
	
11.	**DEBTINC: Debt-to-income ratio.** Had 1267 missing values (21.25% of whole dataset).
	Checked median values - 34.81 and average value -  33.78. Decided to fill missing values with median - 34.81.
	
12.	Added **LTV** variable.

:pushpin: **Creating Probability of Default model - Logistic Regression**

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/CreditRiskAnalysis/pd_model.png"/> 

:pushpin: **IRB approach calculatin mortgage porfolio RWA (Risk Weighted Assets) and Capital Requirements calculation**

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/CreditRiskAnalysis/irb_approach_formulas.png"/> 

### :white_check_mark: Standardized and IRB approach comparison

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/CreditRiskAnalysis/approach_comparison.png"/> 

**Standardized credit risk RWA** calculation has substancially lower **RWA** in comparison to **Foundation IRB (F-IRB) approach**.
While expose at Default is the same, then it comes to RWA calculation, there is a huge difference.
**RWA** calculation via **Foundation IRB (F-IRB)** approach has 574% higher **RWA** than **Standardized** approach. 609mil VS 106mil

It means that **Standardized** approach calculation for credit risk **RWA** is substancially less capital intensive as this approach assumes that our portfolio has less risk to default.

Advising to use **Standardized** Approach for **RWA** calculation, because this will free up more capital which we can use for other investments.
We should use Foundation IRB (F-IRB) approach only if we see that we can predict portfolio defaults to substancially higher degree than **Standaradized** Approach.

Also by using **Standardized** Approach we avoiding risk of being blamed by regulators for not managing risk properly with our customized risk calculation model. 

