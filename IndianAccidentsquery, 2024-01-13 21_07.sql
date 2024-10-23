select*
from acc_projects
limit 1000;

select Road_Surface_Conditions, sum(Number_of_Casualties)
from acc_projects
where road_surface_conditions is not null
group by road_surface_conditions;


select
     Accident_Severity,
     sum (Number_of_Casualties),
     round(sum (Number_of_Casualties)/60950,2) as percentage
from acc_projects
group by Accident_Severity;
      



select*
from abolaji_project;

select*
from accident;

select Vehicle_Type, Number_of_Vehicles, Number_of_Casualties
from accident
group by Vehicle_Type
order by Number_of_Casualties;

describe accident;
drop table bolaji.accident;


select*
from accident;

select*
from work_with;

select*
from acc_projects;

select (Number_of_Casualties)
from acc_projects;

select sum( number_of_casualties)
from acc_projects ac;



select accident_severity, sum(number_of_casualties)
from acc_projects
group by accident_severity;

select Vehicle_Type , sum(number_of_casualties)
from acc_projects
group by vehicle_type;

select Urban_or_Rural_area, sum(number_of_casualties)
from acc_projects
group by Urban_or_Rural_area;

select Light_Conditions, sum(number_of_casualties)
from acc_projects
group by Light_Conditions;

select Road_Surface_Conditions, sum(number_of_casualties)
from acc_projects
group by Road_Surface_Conditions;

select Month, Year, sum(number_of_casualties)
from acc_projects
group by month;


select*
from walmart
where Invoice ID = null;

-------date engineering
---- putting time of the day


select 
     time,
     (case
         when time between '00:00:00' and '12:00:00' then 'morning'
         when time between '00:01:00' and '16:00:00' then 'Afternoon'
         else 'evening'
     end
     ) as time_of_day
from walmart;

alter table walmart
add column time_of_day varchar (20);

update walmart
set time_of_day = (
    case
         when time between '00:00:00' and '12:00:00' then 'morning'
         when time between '00:01:00' and '16:00:00' then 'Afternoon'
         else 'evening'
     end
);


select date,convert (STR_TO_DATE(date, '%dd/%mm/%yyyy'),%yyyy-%mm-%dd)
from walmart;

select*
from walmart;


select date,convert(STR_TO_DATE(date, '%d/%m/%y'),'yyyy-mm-dd')
from walmart;

describe walmart;


select DATE_FORMAT(date,'%d-%m-%y') as Dates
from walmart;


alter table walmart
add column Day_names varchar (10);



update walmart
set dates= STR_TO_DATE( date, '%d/%m/%y');

select DATE, STR_TO_DATE( date, '%d/%m/%y') as dates, DAYNAME(STR_TO_DATE( date, '%d/%m/%y'))as day_name, MONTHNAME(STR_TO_DATE( date, '%d/%m/%y'))as monthnames
from walmart as Engine;




alter table walmart
add column Monthnames varchar (10);

update walmart 
set monthnames = monthname(date);

alter table walmart
modify column date TIMESTAMP;



---------------------------------------------------------------------------------

--- how many Unique cities does the data have?
-Yangon
-Naypyitaw
-Mandalay

select 
    distinct City
from walmart;

--- how many Unique Branches does the data have?

A
C
B

select 
    distinct branch
from walmart;

--- how many Unique Branches and cities does the data have?
Yangon	A
Naypyitaw	C
Mandalay	B

select 
    distinct city, branch
from walmart;


----products
--- whatare the unique products line?
6

select count ( distinct `Product line`)
from walmart;
---Health and beauty
---Electronic accessories
---Home and lifestyle
--sports and travel
--F0od and beverages
---Fashion accessories


----what is the most common payment methods?

---Cash	344
--Credit card	311
--Ewallet	345

select payment, count(payment)
from walmart
group by payment;

---what is the most selling product line
--Electronic accessories	971
--Fashion accessories	902
--Food and beverages	952
--Health and beauty	854
--Home and lifestyle	911
--Sports and travel	920

select `Product line`, sum(quantity)
from walmart
group by `Product line`;

---what is the total revenue by month

--5537.71	January
--5212.17	March
--4629.49	February

select round(sum(total),2), monthnames
from (select  `gross income`as total ,  MONTHNAME(STR_TO_DATE( date, '%d/%m/%y'))as monthnames
from walmart) as usaged
group by monthnames
order by 1 desc;

--what is the month has the largest COGS?
--973.8	March
--985.2	January
--993	February

select max(Cogs),monthnames
from (select  cogs  ,  MONTHNAME(STR_TO_DATE( date, '%d/%m/%y'))as monthnames
    from walmart) as used
group by monthnames desc;

---what is the city has the largest revenue?

--Mandalay	B	5057.03
--Naypyitaw	C	5265.18
--Yangon	A	5057.16


select city, branch, `gross income` as Revenue, sum (quantity)
from walmart;
group by city, branch;


select city, branch,round(sum(revenue),2) as revenue
from ( select city, branch, `gross income` as Revenue
    from walmart) as usage_2
group by city, branch;


---which branch sold more products than the average products sold?

select `Product line`, sum(quantity) 
from walmart
group by `Product line`;

select sum(quantity)as total_qty
from walmart;

select branch, sum(quantity) 
from walmart
group by branch
having sum(quantity)> (select avg(quantity) from walmart);
----A	1859
---B	1820
----C	1831

---number of sales make each days of the week?
---Saturday	1942
--Tuesday	1950
--Wednesday	2109
--Friday	2196
--Sunday	2203
---Thursday	2277
---Monday	2703


select*
from walmart;

select DAYNAME(STR_TO_DATE( date, '%d/%m/%y'))as Daynames, round(sum(`gross income`),0)
from walmart
group by daynames
order by 2;

----which customer type bring most revenue?
select `Customer type`,  round(sum(`gross income`),0) 
from walmart
group by 1
order by 2 desc;

----which city has the highest number of payment of vat?

select city,round(sum(`Tax 5%`),2)
from walmart
group by 1
order by 2 desc;

--Naypyitaw	5265.18
--Yangon	5057.16
--Mandalay	5057.03

---which customer type has the highest number of payment of vat?

select `Customer type`,round(sum(`Tax 5%`),2)
from walmart
group by 1
order by 2 desc;

--Member	7820.16
--Normal	7559.21

---How many unique customer does the data have/

select distinct `Customer type`
from walmart;

--Member
--Normal


--How many unique Payment does the data have/

select distinct payment
from walmart;
--Ewallet
--Cash
--Credit card

--which customer type buy the most?

select `Customer type`, count (quantity)
from walmart
group by 1
order by 2 desc;

--Member	501
--Normal	499



---what is the gender distribution of customer

select gender, count (Quantity)
from walmart
group by 1
order by 2 desc;

--Female	501
--Male	499


---what is the gender distribution by branch/
select  branch ,count (gender)
from walmart
group by 1
order by 2 desc;
--A	340
--B	332
--C	328

--which time of the day does customer gives most rating

select count(rating), time_of_day
from walmart
group by 2
order by 1 desc;

--432	evening
--377	Afternoon
--191	morning

select avg(rating), time_of_day
from walmart
group by 2
order by 1 desc;

--432	evening
--377	Afternoon
--191	morning

--7.031299734748012	Afternoon
--6.960732984293193	morning
--6.926851851851853	evening


select round(avg(rating),1), branch
from walmart
group by 2
order by 1 desc;

--7.1	C
--7	A
--6.8	B






select count(rating), DAYNAME(STR_TO_DATE( date, '%d/%m/%y'))as Daynames
from walmart
group by 2
order by 1 desc;

--155	Monday
--155	Thursday
--150	Sunday
--141	Friday
--139	Wednesday
--131	Saturday
--129	Tuesday

