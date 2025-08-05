[HOME](../../README.md)

## SQL Squid Game

SOURCE: https://datalemur.com/sql-game  
NOTE 1: [Mode SQL Tutorial](https://mode.com/sql-tutorial) was very helpful for this SQL Game. In particular the
intermediate and advanced modules (starting from level 3).

NOTE 2: !!! IMPORTANT. This SQL game is interesting, but the requirements are poorly written. They don't clearly
describe the expected output. Only after multiple failed attempts to do you discover in the 'Solution' section that
either
not all fields are required in the output (e.g., in Level 8, only a few player columns are needed—guess which ones
without checking the 'Solution'), or the requirement description includes unnecessary information that makes it
confusing.
My advice for levels after 5: Try your query without looking at the 'Solution.' If you're confident it should work, but
it doesn't, compare it with the 'Solution.'

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

NOTE: this one was difficult

For the Marbles game, the Front Man needs you to discover who Player 456's closest companion is. First, find the player
who has interacted with Player 456 the most frequently in daily activities. Then, confirm this player is still alive and
return a row with both players' first names, and the number of interactions they've had.

``` 
with freq as (
  select
  	case
  		when player1_id = 456 then player2_id
  		else player1_id
  	end contact_player,
  	count(*) as contacts
  from daily_interactions
  where player1_id = 456 or player2_id = 456
  group by
  	case
  		when player1_id = 456 then player2_id
  		else player1_id
  	end
  order by count(*) desc
  limit 1
)
select 
	p1.first_name as p1_name,
	p2.first_name as p2_name,
	freq.contacts as interactions
from freq
join player p1 on p1.id = 456
join player p2 on p2.id = freq.contact_player
where exists(
 	select 1
  	from daily_interactions di
  	where
  		(
			(di.player1_id = 456 and di.player2_id = freq.contact_player)
		  or
		  	(di.player1_id = freq.contact_player and di.player2_id = 456)
		)
  		and p2.status = 'alive'
)
```

---

#### 006 level 6

The guards are investigating equipment durability across different game types, as some equipment has been breaking
prematurely. Determine the game type with the highest number of equipment failures and identify the supplier responsible
for the most failures within that game type. Finally, calculate the average lifespan until first failure, in whole
years (using 365.2425 days per year), of all failed equipment supplied by this supplier for the most faulty game type.

``` 
with most_failed_game as (
  select
	game_type
  from equipment e
  join failure_incidents i on i.failed_equipment_id = e.id
  group by game_type
  order by count(e.game_type) desc
  limit 1
),
most_failed_supplier as (
  select
  	e.supplier_id
  from equipment e
  join failure_incidents i on i.failed_equipment_id = e.id
  where e.game_type = (select game_type from most_failed_game)
  group by e.supplier_id
  order by count(*) desc
  limit 1
 ),
first_failed_date as (
  select
  	e.id,
	min(i.failure_date) as first_failure
  from equipment e
  join failure_incidents i on i.failed_equipment_id = e.id
  group by e.id
)
select
	floor(sum((d.first_failure - e.installation_date) / 365.2425) / count(*)) as avg_lifetime
from equipment e
join first_failed_date d on d.id = e.id
where e.supplier_id = (select supplier_id from most_failed_supplier)
```

NOTE Level 6: The problem statement is ambiguous. It’s unclear what the output should include. I was under the
impression, after reading the requirements, that the output should contain at least four columns: game type, the
supplier responsible for the most equipment failures for that game type, the total number of failures for that supplier
and game type, and the average lifespan until first failure. However, the game’s solution shows only the average
lifespan as the output. It’s frustrating to spend time figuring out how to combine all these elements into a query, only
to discover that just a small part is needed. Moreover, the requirements are completely unclear about the final output.

---

#### 007 level 7

Create a comprehensive report identifying guards who were missing from their sleeping quarters during off-duty hours.
This report should include the following details for each missing guard, ordered by guard ID:

Guard Number
Code Name
Status
Last Seen in Room
Spotted Outside Room Time
Spotted Outside Room >Location
Time Between Room and Outside
Time Range from First to Last Detection of Any Guard

``` 
with first_to_last_time_range as (
  select
  	max(movement_detected_time) - min(movement_detected_time) as time_range
  from camera
)
select
  g.id,
  g.code_name,
  g.status,
  r.last_check_time,
  c.movement_detected_time,
  c.location,
  c.movement_detected_time - r.last_check_time,
  (select time_range from first_to_last_time_range)
from guard g
join room r on r.id = g.assigned_room_id and r.isVacant = true
join camera c on c.guard_spotted_id = g.id
order by g.id
```

---

#### 008 level 8

Find and display the information for the player with the highest hesitation time among those who were pushed off in the
game that has the highest average hesitation time before a push occurred.

``` 
with most_hesitation_game as (
  select
  	game_id
  from player
  where lower(death_description) like 'push%'
  group by game_id
  order by avg(last_moved_time_seconds) desc
  limit 1
)
select
	id,
	first_name,
	last_name,
	last_moved_time_seconds
from player
where game_id = (select * from most_hesitation_game)
order by last_moved_time_seconds desc
limit 1
```

---

#### 009 level 9

Identify who deviated from their assigned position during the Squid Game, and then output a list of guard IDs and access
times of any OTHER guards who visited the same location during the disappearance timeframe.

``` 
with last_game as (
select 
 start_time, end_time
from game_schedule
where type = 'Squid Game'
order by date desc
limit 1
),
lost_guard as(
select 
  distinct g.id, l.door_location
from guard g
join daily_door_access_logs l on l.guard_id = g.id
where shift_start <= (select start_time from last_game)
	and shift_end >= (select end_time from last_game)
	and (l.access_time between (select start_time from last_game)
	and (select end_time from last_game))
	and l.door_location = 'Upper Management'
)
select
	g.id, l.access_time
from guard g
join daily_door_access_logs l on l.guard_id = g.id
where l.door_location = (select door_location from lost_guard)
  and (l.access_time between (select start_time from last_game) 
	   and (select end_time from last_game))
```

---

NOTE: conclusion on all game queries. not ideal, but it works.

[HOME](../../README.md)