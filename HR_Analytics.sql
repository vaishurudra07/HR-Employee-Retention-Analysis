# Join the Two Tables And Created a View
create view hr_data as
select * from hr_1
inner join hr_2
on
hr_1.EmployeeNumber = hr_2.Employee_ID;

# ------------------------- Total no of employee ----------------------------
select count(distinct(employee_id)) as Total_employees from hr_data;



# ----------------------- Attrition and Retention count ----------------------
SELECT 
    SUM(CASE WHEN Attrition = 'yes' THEN 1 ELSE 0 END) AS Attrition_count,
    SUM(CASE WHEN Attrition = 'no' THEN 1 ELSE 0 END) AS Retention_count
FROM hr_data;



# ----------------------- Employees by gender ---------------------------------
select gender,
	count(distinct(EmployeeNumber)) as Employee_count,
    SUM(CASE WHEN Attrition = 'yes' THEN 1 ELSE 0 END) AS Attrition_count,
    SUM(CASE WHEN Attrition = 'no' THEN 1 ELSE 0 END) AS Retention_count
from hr_data 
group by gender;



# ---------------------- Attrition rate  ------------------------------------
select format(avg(a.Attrition_yes)*100,2) as Attrition_rate
from
(select attrition,
       case
       when attrition='yes' 
       then 1 
       else 0
       end as attrition_yes
from hr_data) as a;




# ===============================   (kpi 1) Department wise attrition rate   =======================================================
SELECT Department, 
       AVG(CASE WHEN Attrition = 'Yes' 
       THEN 1 ELSE 0 END) * 100 AS Avg_Attrition_Rate
FROM hr_data
GROUP BY Department;



# ===============================   (kpi 2) Average Hourly rate of Male Research Scientist  =======================================

select jobrole,gender, format(avg(hourlyrate),2) as Hourly_Rate
from hr_data
where jobrole='research scientist' and gender='male';
 
 
 
# ===============================   (kpi 3) Attrition rate Vs Monthly income status  ===============================================
 
 SELECT 
    jobrole,
    ROUND(AVG(CASE WHEN attrition = 'yes' 
			THEN 1 ELSE 0 END) * 100, 2) AS attrition_rate,
    ROUND(AVG(monthlyincome), 2) AS avg_monthlyincome
FROM 
    hr_data
GROUP BY 
    jobrole;

     
     
# ===============================   (kpi 4) Average working years for each Department     =============================================
 
 select department,format(avg(totalworkingyears),2) as Avg_workingyears
 from hr_data
 group by department;
 
 
 
# ===============================   (kpi 5) Job Role Vs Work life balance   ===========================================================
 
 select jobrole,avg(worklifebalance) as Avg_worklifebalance
 from hr_data
 group by jobrole;
 
 
 
 
# ===============================   (kpi 6) Attrition rate Vs Year since last promotion relation  =====================================
 SELECT 
    CASE 
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 5 THEN '1-5'
        WHEN YearsSinceLastPromotion BETWEEN 6 AND 10 THEN '6-10'
        WHEN YearsSinceLastPromotion BETWEEN 11 AND 15 THEN '11-15'
        WHEN YearsSinceLastPromotion BETWEEN 16 AND 20 THEN '16-20'
        WHEN YearsSinceLastPromotion BETWEEN 21 AND 25 THEN '21-25'
        WHEN YearsSinceLastPromotion BETWEEN 26 AND 30 THEN '26-30'
        WHEN YearsSinceLastPromotion BETWEEN 31 AND 35 THEN '31-35'
        WHEN YearsSinceLastPromotion BETWEEN 36 AND 40 THEN '36-40'
        ELSE 'Other'
    END AS Year_Group,
    AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 AS Attrition_Rate
FROM 
    hr_data
GROUP BY 
    Year_Group
ORDER BY 
    MIN(YearsSinceLastPromotion);




# ===============================    Average salary of each job role  ==========================================================
 
 select jobrole,format(avg(monthlyincome),2) as Avg_monthlyincome 
 from hr_data
 group by jobrole;
 
 
 
# ===============================   Attrition count by Marital status   ==========================================================
 
 select Maritalstatus,count(attrition) as Attrition_count 
 from hr_data where attrition='yes'
 group by MaritalStatus;
 
 
 
# ===============================   Average job satisfaction by department ========================================================
 
 select department,format(avg(jobsatisfaction),2) as Job_satisfaction 
 from hr_data
 group by department;
 
 
 
# ===============================   Performance rating by Department  =============================================================
 
 select Department,format(avg(performancerating),1) as Avg_performance_rating
 from hr_data
 group by department;