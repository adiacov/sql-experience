[HOME](../../README.md)

## SQL Squid Game

SOURCE: https://datalemur.com/sql-game  
NOTE: [Mode SQL Tutorial](https://mode.com/sql-tutorial) was very helpful for this SQL Game. In particular the
intermediate and advanced modules (starting from level 3).

#### 000 schema

[schema.sql](schema.sql)

---

#### 001 level 1

The organizers want to identify vulnerable living players who might be easily manipulated for the next game. Find all
players who are alive, in severe debt (debt > 400,000,000 won), and are either elderly (age > 65) OR have a vice of
Gambling with no family connections.

```
select * 
from player
where
    status = 'alive'
	and debt > 400_000_000
	and (
	    age > 65 or 
	    (vice = 'Gambling' and has_close_family = false)
	)
```

---

#### 002 level 2

The organizers need to calculate how many food portions to withhold to create the right amount of tension. In a table,
calculate how many rations would feed 90% of the remaining(alive) non-insider players (rounded down), and in another
column, indicate if the current rations supply is sufficient. (True or False)

```
select
	round(count(*) * 0.9) as rations_90_pct,
	avg(r.amount) >= round(count(*) * 0.9) as is_supply_sufficient
from player p, rations r
where p.status = 'alive' and p.isinsider = false
```

---

#### 003 level 3

Analyze the average completion times for each shape in the honeycomb game during the hottest and coldest months, using
data from the past 20 years only. Order the results by average completion time.

```
with months as (
  select 
	  month
  from monthly_temperatures m1
  join (
	  select
		  min(avg_temperature) as min_temp,
		  max(avg_temperature) as max_temp
	  from monthly_temperatures
	  ) sub
  on sub.min_temp = m1.avg_temperature
	  or sub.max_temp = m1.avg_temperature
 )
select
	h.shape,
	extract(month from h.date) as month,
	avg(h.average_completion_time) as avg_time
from honeycomb_game h
join months
	on months.month = date_part('month', h.date)
where
	date_part('year', now()) - date_part('year', h.date) <= 20
group by h.shape, extract(month from h.date)
order by avg_time
```

---

#### 004 level 4

The Front Man needs to analyze and rank the teams before the Tug of War game begins. For each team that has exactly 10
players, calculate their average player age. Additionally, categorize the teams based on their average player age into
three age groups:

'Fit': Average age < 40  
'Grizzled': Average age between 40 and 50 (inclusive)  
'Elderly': Average age > 50

Show the team_id, average age, age group, and rank the teams based on their average player age (highest average age =
rank 1).

```
select 
	sub.team_id,
	sub.avg_age,
	sub.age_group,
	rank() over (order by sub.avg_age desc) as team_rank
from (
  select
  	team_id,
  	avg(age) as avg_age,
	case
		when avg(age) < 40 then 'Fit'
		when avg(age) between 40 and 50 then 'Grizzled'
		else 'Elderly'
	end as age_group
  from player
  group by team_id
  	having count(*) = 10
) sub
```

---

#### 005 level 5

For the Marbles game, the Front Man needs you to discover who Player 456's closest companion is. First, find the player
who has interacted with Player 456 the most frequently in daily activities. Then, confirm this player is still alive and
return a row with both players' first names, and the number of interactions they've had.

``` 
-- TODO: Continue from here
```

---

NOTE: not ideal, but works

[HOME](../../README.md)