create database NeuralBits;
use NeuralBits;
select * from patient as p;
select * from hospital as h;
select * from billing as b;
select * from diagnosis as d;

select * from treatment as t;
--question 1
SELECT 
    h.hospital_name,
    -- Average patients per month
    (SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt
        FROM patient
        WHERE patient.hospital_id = h.hospital_id
        GROUP BY YEAR(admission_datetime), MONTH(admission_datetime)
    ) AS monthly) AS avg_monthly_patients,

    -- Average patients per week
    (SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt
        FROM patient
        WHERE patient.hospital_id = h.hospital_id
        GROUP BY YEAR(admission_datetime), DATEPART(WEEK, admission_datetime)
    ) AS weekly) AS avg_weekly_patients,

    -- Average patients per year
    (SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt
        FROM patient
        WHERE patient.hospital_id = h.hospital_id
        GROUP BY YEAR(admission_datetime)
    ) AS yearly) AS avg_yearly_patients

FROM hospital h;


--question 1


SELECT 
    h.hospital_name,
    -- Average patients per month
    (SELECT AVG(cnt) FROM (
        SELECT COUNT(distinct(patient_id)) AS cnt
        FROM patient
        WHERE patient.hospital_id = h.hospital_id
        GROUP BY YEAR(admission_datetime), MONTH(admission_datetime)
    ) AS monthly) AS avg_monthly_patients,

    -- Average patients per week
    (SELECT AVG(cnt) FROM (
        SELECT COUNT(distinct(patient_id)) AS cnt
        FROM patient
        WHERE patient.hospital_id = h.hospital_id
        GROUP BY YEAR(admission_datetime), DATEPART(WEEK, admission_datetime)
    ) AS weekly) AS avg_weekly_patients,

    -- Average patients per year
    (SELECT AVG(cnt) FROM (
        SELECT COUNT(distinct(patient_id)) AS cnt
        FROM patient
        WHERE patient.hospital_id = h.hospital_id
        GROUP BY YEAR(admission_datetime)
    ) AS yearly) AS avg_yearly_patients

FROM hospital h;


-- question 4
select top 1 medicine_name,count(medicine_name) as total_consumed from treatment
group by medicine_name
order by total_consumed desc




-- question 5

SELECT 
   d.diagnosis_name, t.medicine_name, 

  COUNT(t.medicine_name) AS total_consumed
FROM treatment t
JOIN diagnosis d ON d.patient_id = t.patient_id
GROUP BY d.diagnosis_name, t.medicine_name
HAVING COUNT(t.medicine_name) = (    SELECT MAX(cnt)
                                     FROM (
											SELECT COUNT(t2.medicine_name) AS cnt
											FROM treatment t2
											JOIN diagnosis d2 
											ON d2.patient_id = t2.patient_id
											WHERE d2.diagnosis_name = d.diagnosis_name
											GROUP BY t2.medicine_name
										  ) AS sub
										  )
										ORDER BY d.diagnosis_name;



--question 3


SELECT 
  age_group,
  COUNT(*) AS total
FROM (
  SELECT 
    CASE 
      WHEN DATEDIFF(YEAR, dob, GETDATE()) < 18 THEN 'Child'
      WHEN DATEDIFF(YEAR, dob, GETDATE()) BETWEEN 18 AND 59 THEN 'Adult'
      ELSE 'Senior'
    END AS age_group
  FROM patient
) AS grouped
GROUP BY age_group;




--question 6

SELECT AVG(DATEDIFF(DAY, admission_datetime, discharge_datetime)) AS avg_days
FROM patient;


--question 7
SELECT 
  FORMAT(p.admission_datetime, 'yyyy-MM') AS month,
  b.payment_mode,
  SUM(b.bill_amount) AS total_income
FROM billing b
JOIN patient p ON b.patient_id = p.patient_id
GROUP BY FORMAT(p.admission_datetime, 'yyyy-MM'), b.payment_mode
ORDER BY month;

SELECT 
  YEAR(p.admission_datetime) AS year,
  b.payment_mode,
  SUM(b.bill_amount) AS total_income
FROM billing b
JOIN patient p ON b.patient_id = p.patient_id
GROUP BY YEAR(p.admission_datetime), b.payment_mode
ORDER BY year;


--question 2


-- Daily
SELECT CAST(admission_datetime AS DATE) AS admission_date,
       COUNT(*) AS daily_occupancy
FROM patient
GROUP BY CAST(admission_datetime AS DATE)
order by admission_date
;

-- Weekly
SELECT DATEPART(YEAR, admission_datetime) AS year,
       DATEPART(WEEK, admission_datetime) AS week,
       COUNT(*) AS weekly_occupancy
FROM patient
GROUP BY DATEPART(YEAR, admission_datetime), DATEPART(WEEK, admission_datetime)
order by year;

-- Monthly
SELECT FORMAT(admission_datetime, 'yyyy-MM') AS month,
       COUNT(*) AS monthly_occupancy
FROM patient
GROUP BY FORMAT(admission_datetime, 'yyyy-MM')
order by month ;
-- Yearly
SELECT YEAR(admission_datetime) AS year,
       COUNT(*) AS yearly_occupancy
FROM patient
GROUP BY YEAR(admission_datetime)
;