SELECT * FROM Project.heart_disease;

ALTER TABLE heart_disease
ADD COLUMN HD char(3) FIRST;

ALTER TABLE heart_disease
ADD COLUMN AD char(3);

SET SQL_SAFE_UPDATES=0;

UPDATE heart_disease
SET HD = case when HeartDisease = "Yes" then 1 else 0 end;

UPDATE heart_disease
SET AD = case when AlcoholDrinking = "Yes" then 1 else 0 end;

#Impacts of Alcohol?
SELECT COUNT(HeartDisease), avg(HD), AlcoholDrinking
FROM heart_disease
GROUP BY AlcoholDrinking;

#Adding Age Category as a factor
SELECT avg(HD), COUNT(HeartDisease),  AlcoholDrinking
FROM heart_disease
GROUP BY AlcoholDrinking
ORDER BY AlcoholDrinking;

#Proportion of drinking people in different age group
SELECT AgeCategory,avg(AD)
FROM heart_disease
GROUP BY AgeCategory
ORDER BY  AgeCategory;

#Adding Age Category as a factor
SELECT AgeCategory,AlcoholDrinking, count(HeartDisease)
FROM heart_disease
GROUP BY AgeCategory, AlcoholDrinking
ORDER BY  AgeCategory;

#Add in BMI as a factor
SELECT CASE WHEN BMI < 18.5 THEN '0Underweight'
WHEN 18.5 <= BMI AND BMI<= 24.9 THEN '1Healthy'
WHEN 25 <= BMI  AND BMI<= 29.9 THEN '2Overweight'
ELSE '3Obese'
END AS BMI_Health, avg(HD), AlcoholDrinking
FROM heart_disease
GROUP BY AlcoholDrinking , BMI_Health
ORDER BY BMI_Health;

CREATE TABLE tb1 AS SELECT CASE WHEN BMI < 18.5 THEN 'Underweight'
WHEN 18.5 <= BMI AND BMI<= 24.9 THEN 'Healthy'
WHEN 25 <= BMI  AND BMI<= 29.9 THEN 'Overweight'
ELSE 'Obese'
END AS BMI_Health, HD, HeartDisease, AlcoholDrinking
FROM heart_disease;

SELECT BMI_Health, AlcoholDrinking,avg(HD)
FROM tb1
GROUP BY BMI_Health, AlcoholDrinking
ORDER BY BMI_Health;

#Proportion of drinking people in different age group
SELECT AgeCategory,avg(AD)
FROM heart_disease
GROUP BY AgeCategory
ORDER BY  AgeCategory;


#COUNT drinking people in different BMI group
SELECT BMI_Health, AlcoholDrinking, COUNT(AlcoholDrinking)
FROM tb1
GROUP BY BMI_Health, AlcoholDrinking
ORDER BY BMI_Health;


#######
SELECT COUNT(*), HeartDisease
FROM heart_disease
GROUP BY HeartDisease;

SELECT avg(HD),BMI_Health,HeartDisease,COUNT(HeartDisease),  AlcoholDrinking
FROM tb1
WHERE AlcoholDrinking = 'Yes'
GROUP BY BMI_Health, AlcoholDrinking
ORDER BY BMI_Health;

SELECT COUNT(HeartDisease),Sex, AgeCategory, AlcoholDrinking
FROM heart_disease
GROUP BY Sex, AgeCategory, AlcoholDrinking
ORDER BY AgeCategory, Sex, AlcoholDrinking;


SELECT COUNT(HeartDisease), Smoking
FROM heart_disease
GROUP BY Smoking
ORDER BY Smoking;