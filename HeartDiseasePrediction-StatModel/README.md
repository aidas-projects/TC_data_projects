
## Heart Disease Prediction - Creating Logistic Regression Model

#### :small_orange_diamond: Task Description:
Create a logistic regression model and predict whether the patient has 10-year risk of future coronary heart disease (CHD). The data is given in the sheet Heart_desease. The dataset is from an ongoing cardiovascular study on residents of the town of Framingham, Massachusetts. The dataset provides the patients’ information. It includes over 4,000 records and 15 attributes. The data attributes are described in Heart_desease_desc sheet.

[Link to dataset and my analysis on Google Sheets](https://docs.google.com/spreadsheets/d/18JE2xCqDvnsO6K6EnUdzVCuLeQRicVuJoYmouXcUPWU/edit#gid=1699502288)

P.S. Instead of suggested free software **GRETL**, I tried to use the professional statistical model creation software called [**JMP Pro 17**](https://www.jmp.com/en_us/software/predictive-analytics-software.html) (developed by JMP, a subsidiary of SAS Institute). It took a while to understand how to use it, but many youtube videos later I am happy I did it. 

#### :small_orange_diamond: Process / Result:

:pushpin: **Cleaning data and handling missing values**

Education column was deleted (not related data to heart disease)	
	
**Missing values**

I removed all rows with 2 or more variables missing. In my opinion it's too much data missing and it is not a good idea to have people with a lot of filled missing values.	
	
**cigsPerDay**	Used smoking people (cigsPerdDay 1 or above) median value to fill mising data for cigsPerDay
	Median and average values are similar ~20cigs per day. Typical pack of cigs has 20cigs. Very predictable that typical person smokes whole pack of cigaretes.
	
**BPMeds**	Out of 329 rows with positive TenYearCHD only13 rows had BPMeds (4% with value 1). There is very high likelihood that rows with positive TenYearCHD did not take BPMeds. So 4 rows with missing BPMeds values were filled with 0.
	Later I've found out that there is not that many rows with actual positive BPMeds, only 124. Which is ~3% in whole dataset. 
	Upon this finding I decided to fill all missing BPMeds values with 0.
	
**totChol**	I've noticed that total cholesterol is a bit correlated with age 0.2625 correlation. So I decided to fill totChol missing values with median value of same age people. 
	For instance there are 3 totChol missing values for the age group of 67 year olds. I checke that typical 67years old had totChol Average  251.5, median 250.5
	I filled 67yo missing totChol values with 250.5
	I have done same steps for all missing totChol values.
	
**heartRate**	Only 1 value was missing. Inserted median value of 75
	
**BMI**	There were 14 missing values. I saw that BMI quite a bit correlated to sysBP (0.3273) and diaBP(0.3779). 
	If BMI value was missing, I checked what were sysBP and diaBP values for this person. 
	When I would filter dataset with similar sysBP and diaBP values until I get at least 40 results and take median of BMI. 
	For instance if there was person with BMI missing and had sysBP 100 and diaBP 60, I would filter whole data set for sysBP 98-102 and diaBP 58-62 (I expand my range if there are only few results). And once I get 40 or more results I measure the median BMI of those people.
	P.S. - 2 rows were deleted due to not sufficient rows needed (less than 40) to calculate BMI median. 
	
**glucose**	removed all rows with missing values because there were total 388 missing. Which is 9% of dataset. I think it would have been mistake to fill this with mean, median or most frequent value. Tried to fit multiple linear regression model to predict values, but did not find good enough model.

**Continious variables correlations**

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/HeartDiseasePrediction-StatModel/coninious_variables_correlations.png"/> 

:pushpin: **Splitting data into training / test**

80% training data. 20% test data. Made sure that positive TenYearCHD has equal percentage in training and test data.			

| | Rows count  | TenYearCHD positive | TenYearCHD positive % of row count |
| -------------| ------------- | ------------- | ------------- |
| Training Data  | 3020  | 444 | 14.70%  |
| Test Data  | 755  | 118  | 15.63%  |

**Variables and PValues after cleaning and filling missing data**

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/HeartDiseasePrediction-StatModel/logworth_pvalues_aftercleaning.png"/> 

* **diabetes - removed** - because PValue 0.97		
* **currentSmoker -	removed**	 - because PValue 0.81		
* **diaBP - transformed to log and removed high outliers (64 in total)** -  PValue improved from 0.74090 to 0.04715
* **BPMeds - removed** - because PValue 0.62460		
* **heartRate - removed** - because PValue 0.45298 and removing outliers or transforming values to Log or Sqroot did not help to reduce PValue
* **BMI -	transformed to Square and	removed high outliers (15 in total)** - PValue improved from 0.16835 to 0.04890
* **totChol**	- There were 34 high outliers and few very high outliers. Removing outliers would significantly increase PValue from 0.065 up to 0.25-0.27. So I left outliers in training data.				



**Outliers identified via interquartile range (IQR)**

1. Calculate the median, 25th, and 75th percentiles.
2. Calculate the interquartile range (IQR) as the difference between the 75th and 25th percentiles.
3. Calculate the maximum length of the whiskers by multiplying the IQR by 1.5.
4. Identify outliers.
5. Use the calculated statistics to plot the results and draw a box plot."
For example if 25% quantile is 100 and 75% is 120.  IQR = 120-100 = 20

IQR x 1.5 = 20 x 1.5 = 30
Outliers: 
Anything below 70 and above 150

:pushpin: **Created 2 models**

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/HeartDiseasePrediction-StatModel/logistic_regression_models_parameters.png"/> 

<p align="center">
<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/HeartDiseasePrediction-StatModel/model_comparison.png"/> 
</p>

 **Both models are quite similar.** I think 2nd model is better fit just because of lower combined values of AICc and BIC (indicating better balance between fit and complexity). And having 5 instead of 10 variables in 2nd model is a huge advantage because it means we can predict patient’s heart disease quicker in real life situation as we need to collect less data to do prediction.

* In the context of logistic regression, a better fit means that the model is effectively capturing the relationship between the independent variables and the probability of the outcome variable. It indicates that the model's estimated coefficients and predicted probabilities align well with the observed data.

* AICc and BIC: Lower AICc and BIC values indicate a better balance between model fit and complexity. In this case 2nd model has a slightly better fit.

* The -LogLikelihood provides a quantitative measure of how well the model fits the data. A lower -LogLikelihood value indicates a better fit, meaning that the model's predicted probabilities or expected values are closer to the observed data. 2nd model has a slightly better fit with -LogLikelihood 130.97 in comparison to 1st model’s 139.49.

* Chi-Square: A smaller Chi-Square value suggests a better fit. 2nd model has a better fit. Chi-Square is larger in 1st model 278.97 in comparison to 2nd model’s 261.94. 

* Degrees of Freedom (DF): The number of degrees of freedom represents the number of parameters estimated in the model. The 1st model has 10 degrees of freedom, while the 2nd model has 5 degrees of freedom. A lower number of degrees of freedom indicates a more parsimonious model.

* A higher R-square value indicates a better fit of the model to the data, as it implies that a larger proportion of the variance in the dependent variable is accounted for by the independent variables. 1st model has higher R-square of 0.1106 in comparison to 2nd model’s 10.39, suggesting a better fit.

* AUC stands for Area Under the Curve, and it is a metric commonly used in evaluating the performance of binary classification models, such as logistic regression or support vector machines. The AUC represents the overall performance of the model in distinguishing between the two classes (e.g., positive and negative outcomes). AUC is both models are incredibly similar, but slightly better in 1st model - 0.72817 vs 2nd model’s AUC of 0.72311.




:pushpin: **Assessing the model with performance metrics** (decided to assess both models with performance metrics)

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/HeartDiseasePrediction-StatModel/models_performance_metrics.png"/> 

<img src="https://github.com/aidas-projects/TC_data_projects/blob/main/HeartDiseasePrediction-StatModel/confusion_matrix.png"/> 

Ideally we are looking to find as many as possible True Positives. 
If we correctly identifying True Positives, that means we are potentially preventing people from dying from coronary heart disease. As people informed early about the risk can take measures to reduce the risk.

On other hand we can not have very low % of True Negatives. As that would mean that many people who do not have high ten year coronary heart disease risk will be informed that they do. That will put additional stress on people (which in itself can produce additional health problems) and will put additional strain on the hospital in a form of additional tests. 

I think the right balance is where Model’s Accuracy crosses with Recall and Specificity.
Meaning the point where overall correctness of the model is pretty high and the percentage of correctly predicted positive cases out of all actual positive cases is high too. And model still able to avoid false positive predictions for negative cases at a reasonably high rate.

Running both models on the test data (models were not trained on this data). The best cutoff point for both models is ~0.165.

At least using test data with the cutoff point of 0.165 2nd model has a slight performance advantage over 1st model on the test data.
While 1st model gives us 64.41% True Positives and 69.23% True Negatives. 
2nd model gives us 66.95% True Positives and 69.23% True Negatives.
Better 2nd model performance on test data + 2nd model having only 5 variables instead of 10 makes 2nd model a better choice.

