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

[HOME](../README.md)