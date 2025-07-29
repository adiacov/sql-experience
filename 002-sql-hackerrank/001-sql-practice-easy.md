[HOME](../README.md)

## SQL Hackerrank Easy

SOURCE: https://www.hackerrank.com/domains/sql

```
-- Revising the Select Query I
select * from city 
where countrycode ='USA' and population > 100000
```

```
-- Revising the Select Query II
select name from city 
where population > 120000 and countrycode = 'USA';
```

``` 
-- Select All
select * from city;
```

```
-- Select By ID
select * from city where id = 1661
```

``` 
-- Japanese Cities' Attributes
select *
from city
where countrycode = 'JPN'
```

``` 
-- Japanese Cities' Names
select name
from city
where countrycode = 'JPN';
```

``` 
-- Weather Observation Station 1
select city, state
from station;
```

``` 
-- Weather Observation Station 3
select distinct city
from station
where (id % 2) = 0;
```

``` 
-- Weather Observation Station 4
select count(city) - count(distinct city) from station
```

``` 
-- Weather Observation Station 5
select city, length(city)
from station
where (city = (select city from station order by length(city) desc, city limit 1)) OR
(city = (select city from station order by length(city), city limit 1))
```

``` 
-- Weather Observation Station 6
select distinct city
from station
where
    city like 'a%' or
     city like 'e%' or
      city like 'i%' or
       city like 'o%' or
        city like 'u%'
```

``` 
-- Weather Observation Station 7
select distinct city
from station
where
city like '%a' or
city like '%e' or
city like '%i' or
city like '%o' or
city like '%u'
```

``` 
-- Weather Observation Station 8
select distinct city 
from station
where
(city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%') and
(city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u')
```

``` 
-- Weather Observation Station 9
select distinct city
from station
where
city not like 'a%' and
city not like 'e%' and
city not like 'i%' and
city not like 'o%' and
city not like 'u%'
```

``` 
-- Weather Observation Station 10
select distinct city
from station
where
city not like '%a' and
city not like '%e' and
city not like '%i' and
city not like '%o' and
city not like '%u'
```

``` 
-- Weather Observation Station 11
select distinct city
from station
where
(city not like 'a%' and city not like 'e%' and city not like 'i%' and city not like 'o%' and city not like 'u%') or
(city not like '%a' and city not like '%e' and city not like '%i' and city not like '%o' and city not like '%u')
```

``` 
-- Weather Observation Station 12
select distinct city
from station
where
(city not like 'a%' and city not like 'e%' and city not like 'i%' and city not like 'o%' and city not like 'u%') and
(city not like '%a' and city not like '%e' and city not like '%i' and city not like '%o' and city not like '%u')
```

``` 
-- Higher Than 75 Marks
select name
from students
where marks > 75
order by SUBSTRING(name, -3) ,id
```

``` 
-- Employee Names
select name from employee order by name
```

``` 
-- Employee Salaries
select name
from employee
where salary > 2000 and months < 10
order by employee_id
```

``` 
-- Type of Triangle
select
case
    when (a + b <= c) or (b + c <= a) or (c + a <= b) then 'Not A Triangle'
    when a = b and b = c then 'Equilateral'
    when (a = b and a != c) or (b = c and b !=a) or (c = a and c !=b) then 'Isosceles'
    else 'Scalene'
end
from triangles
```

``` 
-- Population Density Difference
select max(population) - min(population)
from city
```

``` 
-- Revising Aggregations - The Count Function

select 
    count(*) as cities
from city
where population > 100000
```

``` 
-- Revising Aggregations - The Sum Function

select 
    sum(population) as population
from city
where district = 'California'
```

``` 
-- Revising Aggregations - Averages

select
    avg(population) as avg_population
from city
where district = 'California'
```

```
-- Average Population

select 
    round(avg(population), 0) as avg_population
from city
```

``` 
-- Japan Population

select
    sum(population) as jpn_population
from city
where countrycode = 'JPN'
```

``` 
-- The Blunder

select
    ceil(avg(salary) - avg(replace(salary, '0', ''))) as avg_salary
from employees

```

``` 
-- Weather Observation Station 2

select
    round(sum(lat_n), 2) as lat,
    round(sum(long_w), 2) as lon
from station
```

``` 
-- Weather Observation Station 13

select
    round(sum(lat_n), 4) as lat
from station
where lat_n > 38.7880 and lat_n < 137.2345
```

``` 
-- Weather Observation Station 14

select
    round(max(lat_n), 4) as max_lat
from station
where lat_n < 137.2345
```

``` 
-- Weather Observation Station 15

select
    round(long_w, 4)
from station
where lat_n = (select max(lat_n) from station where lat_n < 137.2345)
```

``` 
-- Weather Observation Station 16

select
    round(min(lat_n), 4)
from station
where lat_n > 38.7780
```

``` 
-- Weather Observation Station 17

select
    round(long_w, 4)
from station
where lat_n = (select min(lat_n) from station where lat_n > 38.7780)
```

``` 
-- Weather Observation Station 18

with manhattan as (
    select
        abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w)) as distance
    from station
)
select
    round(m.distance, 4)
from manhattan m
```

[HOME](../README.md)